package com.example.shopping_system.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class Discussion {
    @TableId(type = IdType.AUTO)
    private Long discussionId;

    private String discussionContent;

    private int deleted;
    private int version;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    private Integer userId;
    private Integer productId;

    public Discussion(String discussionContent, Integer userId, Integer productId) {
        this.discussionContent = discussionContent;
        this.userId = userId;
        this.productId = productId;
    }
}
