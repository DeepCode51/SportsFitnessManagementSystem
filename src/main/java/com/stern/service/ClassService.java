package com.stern.service;

import com.stern.pojo.Class;
import com.stern.pojo.ClassExample;

import java.util.List;

/**
 * 班级信息 -业务逻辑层
 */
public interface ClassService {
    //查询所有开设班级
    List<Class> selectByExample(ClassExample example);
    //根据班级id查询班级
    Class selectByPrimaryKey(Integer classid);
}
