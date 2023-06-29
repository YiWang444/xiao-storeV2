package com.example.shopping_system.service;

import cn.hutool.core.util.BooleanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.example.shopping_system.dto.Result;
import com.example.shopping_system.mapper.DiscussionMapper;
import com.example.shopping_system.mapper.DiscussionSubMapper;
import com.example.shopping_system.mapper.UserMapper;
import com.example.shopping_system.pojo.*;
import com.example.shopping_system.vo.DiscussionVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class DiscussionService {

    private static final int PAGE_SIZE = 5;

    private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Autowired
    private DiscussionMapper discussionMapper;

    @Autowired
    private DiscussionSubMapper discussionSubMapper;

    @Autowired
    private UserMapper userMapper;

    public Result getDiscussionInfo(int productId, int currentPage, long lastDiscussionId) {
        Set<Integer> distinctSet = new HashSet<>();
        List<Long> parentList = new ArrayList<>();

        // 深度分页
        List<Discussion> discussionList = discussionMapper.getDiscussionList(productId, lastDiscussionId, 0, PAGE_SIZE);

        if(discussionList.size() == 0) {
            return Result.error("002", "错误获取，没有评论");
        }

        discussionList.forEach(discussion -> {
            parentList.add(discussion.getDiscussionId());
            distinctSet.add(discussion.getUserId());
        });

        // select * from DiscussionSub where user_id in (xx, xx, ...)  查询子表
        List<DiscussionSub> discussionSubList = discussionSubMapper.selectList(new LambdaQueryWrapper<DiscussionSub>()
                .in(DiscussionSub::getParentId ,parentList)
                .eq(DiscussionSub::getProductId, productId));
        Map<Long, List<DiscussionSub>> discussionSubMap = discussionSubList.stream().collect(Collectors.groupingBy(DiscussionSub::getParentId));

        // distinct
        discussionSubList.forEach(discussionSub -> distinctSet.add(discussionSub.getUserId()));

        // 查询用户信息
        List<User> userList = userMapper.selectBatchIds(new ArrayList<>(distinctSet));
        Map<Integer, DiscussionUser> userMap = new HashMap<>();
        userList.forEach(user -> userMap.put(user.getUserId(), new DiscussionUser(user.getUserId(), user.getUserName(), user.getUserImg())));


        // 组装
        Map<Long, List<DiscussionVo>> sunMap = new HashMap<>();
        discussionSubMap.forEach((id, discussionSubs) -> {
            List<DiscussionVo> t = new ArrayList<>();

            discussionSubs.forEach(d -> {
                DiscussionVo discussionVo = new DiscussionVo(d.getDiscussionSubId(),
                        userMap.get(d.getUserId()), userMap.get(d.getTouchId()),
                        d.getDiscussionContent(), d.getUpdateTime().format(dateTimeFormatter), null);
                t.add(discussionVo);
            });

            sunMap.put(id, t);
        });


        List<DiscussionVo> res = new ArrayList<>();
        discussionList.forEach(d -> {
            res.add(new DiscussionVo(d.getDiscussionId(),
                    userMap.get(d.getUserId()), null,
                    d.getDiscussionContent(), d.getUpdateTime().format(dateTimeFormatter), sunMap.get(d.getDiscussionId())));
        });

        return Result.success(res, "获取评论成功");
    }

    public Result addDiscussion(int userId, int productId, String content) {
        Discussion discussion = new Discussion(content, userId, productId);
        discussionMapper.insert(discussion);

        User user = userMapper.selectById(userId);
        Discussion d = discussionMapper.selectById(discussion.getDiscussionId());

        DiscussionVo res = new DiscussionVo(d.getDiscussionId(),
                new DiscussionUser(userId, user.getUserName(), user.getUserImg()),
                null,
                content, d.getUpdateTime().format(dateTimeFormatter), new ArrayList<>());

        return Result.success(res, "添加评论成功");
    }

    public Result addSunDiscussion(int userId, long parentId, int productId, int touchId, String content) {
        DiscussionSub discussionSub = new DiscussionSub(content, userId, productId, parentId, touchId);
        discussionSubMapper.insert(discussionSub);

        User user = userMapper.selectById(userId);
        User parentUser =  userMapper.selectById(touchId);
        DiscussionSub d = discussionSubMapper.selectById(discussionSub.getDiscussionSubId());

        DiscussionVo res = new DiscussionVo(d.getDiscussionSubId(),
                new DiscussionUser(userId, user.getUserName(), user.getUserImg()),
                new DiscussionUser(parentUser.getUserId(), parentUser.getUserName(), parentUser.getUserImg()),
                content, d.getUpdateTime().format(dateTimeFormatter), null);

        return Result.success(res, "添加二级评论成功");
    }

    public Result getDiscussionCount(int productId) {
        return Result.success(discussionMapper.selectCount(
                new QueryWrapper<Discussion>().eq("product_id", productId)),
                "获取评论个数成功");
    }

    /*
    类添加：isLike，liked ｜ 数据库添加：liked
    @TableField(exist = false)
    private Boolean isLike;

    public Result likeDiscussion(Integer userId, long discussionId) {
        String key = "blog:liked:" + discussionId;
        // 判断当前用户是否已经点赞
        Boolean isMember = stringRedisTemplate.opsForSet().isMember(key, userId.toString());

        if (BooleanUtil.isFalse(isMember)) {
            int effectRow = discussionMapper.update(null,
                    new UpdateWrapper<Discussion>().setSql("liked = liked + 1").eq("discussion_id", discussionId));
            if(effectRow > 0) {
                stringRedisTemplate.opsForSet().add(key, userId.toString());
            }
        }else {
            int effectRow = discussionMapper.update(null,
                    new UpdateWrapper<Discussion>().setSql("liked = liked - 1").eq("discussion_id", discussionId));
            if(effectRow > 0) {
                stringRedisTemplate.opsForSet().remove(key, userId.toString());
            }
        }


        return Result.success();
    }

    private void isBlogLiked(Integer userId, Discussion discussion) {
        // 获取登陆用户

        // 判断当前登陆用户是否已经点赞
        String key = "blog:liked:" + discussion.getDiscussionId();
        Boolean isMember = stringRedisTemplate.opsForSet().isMember(key, userId.toString());
        discussion.setIsLike(BooleanUtil.isTrue(isMember));
    }

     */
}
