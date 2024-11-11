package com.stern.service.impl;

import com.stern.mapper.CourseMapper;
import com.stern.mapper.SheetMapper;
import com.stern.pojo.Course;
import com.stern.pojo.CourseExample;
import com.stern.pojo.Sheet;
import com.stern.pojo.SheetExample;
import com.stern.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private SheetMapper sheetMapper;

    public List<Course> selectByExample(CourseExample example) {
        return courseMapper.selectByExample(new CourseExample());
    }

    public List<Course> selectByExampleWithBLOBs(CourseExample example) {
        return courseMapper.selectByExampleWithBLOBs(example);
    }

    public Course selectByPrimaryKey(Integer cid) {
        return courseMapper.selectByPrimaryKey(cid);
    }

    public int insertSelective(Course record) {
        return courseMapper.insertSelective(record);
    }

    public int updateByPrimaryKeySelective(Course record) {
        return courseMapper.updateByPrimaryKeySelective(record);
    }

    public int deleteByPrimaryKey(Integer cid) {
        return courseMapper.deleteByPrimaryKey(cid);
    }

    public int insertSelective(Sheet record) {
        return sheetMapper.insertSelective(record);
    }

    public long countByExample(SheetExample example) {
        return sheetMapper.countByExample(example);
    }

    public int updateByPrimaryKey(Sheet record) {
        return sheetMapper.updateByPrimaryKey(record);
    }

    public Sheet selectSheetByPrimaryKey(Integer sid) {
        return sheetMapper.selectByPrimaryKey(sid);
    }
}
