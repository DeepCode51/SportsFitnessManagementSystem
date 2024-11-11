package com.stern.service;

import com.stern.pojo.Post;
import com.stern.pojo.PostExample;

import java.util.List;

/**
 * 职务 -业务逻辑层
 */
public interface PostService {
    //查询所有职务
    List<Post> selectByExample(PostExample example);
}
