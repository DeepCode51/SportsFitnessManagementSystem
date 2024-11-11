package com.stern.service.impl;

import com.stern.mapper.CoursecategoryMapper;
import com.stern.pojo.Coursecategory;
import com.stern.pojo.CoursecategoryExample;
import com.stern.service.CoursecategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CoursecategoryServiceImpl implements CoursecategoryService {
    @Autowired
    private CoursecategoryMapper coursecategoryMapper;

    public List<Coursecategory> selectByExample(CoursecategoryExample example) {
        return coursecategoryMapper.selectByExample(example);
    }
}
