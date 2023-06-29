package com.example.shopping_system.vo;


import com.example.shopping_system.pojo.DiscussionUser;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DiscussionVo {
    private Long id;                            // 评论id
    private DiscussionUser commentUser;         // 评论用户
    private DiscussionUser targetUser;          // 被评论用户
    private String content;                     // 评论内容
    private String createDate;                  // 评论时间
    private List<DiscussionVo> childrenList;    // 子评论列表
}
