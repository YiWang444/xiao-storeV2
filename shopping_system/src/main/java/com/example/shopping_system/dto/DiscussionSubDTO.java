package com.example.shopping_system.dto;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class DiscussionSubDTO {
    @TableId(type = IdType.AUTO)
    private Long discussionSubId;

    private String discussionContent;

    private Integer userId;
    private Integer productId;
    private Long parentId;
}

