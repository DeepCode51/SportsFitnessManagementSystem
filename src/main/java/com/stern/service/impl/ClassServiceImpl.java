package com.stern.service.impl;

import com.stern.mapper.ClassMapper;
import com.stern.pojo.Class;
import com.stern.pojo.ClassExample;
import com.stern.service.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ClassServiceImpl implements ClassService {
    @Autowired
    private ClassMapper classMapper;

    public List<Class> selectByExample(ClassExample example) {
        return classMapper.selectByExample(example);
    }

    public Class selectByPrimaryKey(Integer classid) {
        return classMapper.selectByPrimaryKey(classid);
    }
}
