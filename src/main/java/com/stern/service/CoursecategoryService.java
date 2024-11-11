package com.stern.service;

import com.stern.pojo.Coursecategory;
import com.stern.pojo.CoursecategoryExample;

import java.util.List;

/**
 * 课程类型 -业务逻辑层
 */
public interface CoursecategoryService {
    //查询所有课程类型
    List<Coursecategory> selectByExample(CoursecategoryExample example);
}

