package com.example.shopping_system.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DiscussionUser {
    private Integer id;                         // 用户ID
    private String nickName;                    // 用户昵称
    private String avatar;                      // 用户头像
}
