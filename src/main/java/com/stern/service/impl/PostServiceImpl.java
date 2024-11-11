package com.stern.service.impl;

import com.stern.mapper.PostMapper;
import com.stern.pojo.Post;
import com.stern.pojo.PostExample;
import com.stern.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements PostService{
    @Autowired
    private PostMapper postMapper;
    public List<Post> selectByExample(PostExample example) {
        return postMapper.selectByExample(example);
    }
}
