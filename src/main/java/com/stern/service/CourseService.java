package com.stern.service;

import com.stern.pojo.Course;
import com.stern.pojo.CourseExample;
import com.stern.pojo.Sheet;
import com.stern.pojo.SheetExample;

import java.util.List;

/**
 * 课程 -业务逻辑层
 */
public interface CourseService {
    //查询所有课程
    List<Course> selectByExample(CourseExample example);
    //查询带描述的课程
    List<Course> selectByExampleWithBLOBs(CourseExample example);
    //通过课程id查询
    Course selectByPrimaryKey(Integer cid);
    //添加课程
    int insertSelective(Course record);
    //根据课程id修改课程信息
    int updateByPrimaryKeySelective(Course record);
    //根据课程id删除课程
    int deleteByPrimaryKey(Integer cid);
    //上传课表
    int insertSelective(Sheet record);
    //查询课表是否已经有了
    long countByExample(SheetExample example);
    //更新课表的地址
    int updateByPrimaryKey(Sheet record);
    //根据课表ID查询课表
    Sheet selectSheetByPrimaryKey(Integer sid);
}
