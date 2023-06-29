package com.example.shopping_system.controller;

import com.example.shopping_system.dto.Result;
import com.example.shopping_system.service.DiscussionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/discussion")
public class DiscussionController {

    @Autowired
    private DiscussionService discussionService;

    @PostMapping("/getDiscussionInfo")
    public Result getCollectInfo(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return discussionService.getDiscussionInfo(
                obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj,
                (int)requestMap.get("currentPage"),
                Long.parseLong(requestMap.get("lastDiscussionId").toString())
        );
    }

    @PostMapping("/getDiscussionCount")
    public Result getDiscussionCount(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return discussionService.getDiscussionCount(
                obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj
        );
    }

    @PostMapping("/addDiscussion")
    public Result addDiscussion(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return discussionService.addDiscussion(
                (int)requestMap.get("userId"),
                obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj,
                (String)requestMap.get("content")
        );
    }

    @PostMapping("/addSunDiscussion")
    public Result addSunDiscussion(@RequestBody Map<String, Object> requestMap) {
        Object obj = requestMap.get("productId");

        return discussionService.addSunDiscussion(
                (Integer) requestMap.get("userId"),
                ((Number) requestMap.get("parentId")).longValue(),
                obj instanceof String ? Integer.parseInt((String) obj) : (Integer) obj,
                (int)requestMap.get("touchId"),
                (String) requestMap.get("content")
        );
    }
}
