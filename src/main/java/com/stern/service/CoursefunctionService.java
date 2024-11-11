package com.stern.service;

import com.stern.pojo.Coursefunction;
import com.stern.pojo.CoursefunctionExample;

import java.util.List;

/**
 * 课程功能 -业务逻辑层
 */
public interface CoursefunctionService {
    //查询所有课程功能
    List<Coursefunction> selectByExample(CoursefunctionExample example);
}
