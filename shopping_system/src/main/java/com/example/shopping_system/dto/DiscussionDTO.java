package com.example.shopping_system.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class DiscussionDTO {
    private Integer discussionId;

    private String discussionContent;
    private Integer parentId;

    private Integer userId;
    private Integer productId;
}
