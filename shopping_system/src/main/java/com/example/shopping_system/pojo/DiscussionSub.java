package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DiscussionSub {
    @TableId(type = IdType.AUTO)
    private Long discussionSubId;

    private String discussionContent;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private Integer userId;
    private Integer productId;
    private Long parentId;
    private Integer touchId;                    // @的用户

    public DiscussionSub(String discussionContent, Integer userId, Integer productId, Long parentId, Integer touchId) {
        this.discussionContent = discussionContent;
        this.userId = userId;
        this.productId = productId;
        this.parentId = parentId;
        this.touchId = touchId;
    }
}
