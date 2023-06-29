package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.pojo.Discussion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DiscussionMapper extends BaseMapper<Discussion> {
    @Select("select discussion_id, discussion_content, user_id, update_time from discussion" +
            "    where product_id = ${productId} and discussion_id > ${lastDiscussionId}" +
            "    limit ${offset}, ${pageSize}")
    List<Discussion> getDiscussionList(int productId, long lastDiscussionId, int offset, int pageSize);
}
