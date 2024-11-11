package com.stern.service.impl;

import com.stern.mapper.CoursefunctionMapper;
import com.stern.pojo.Coursefunction;
import com.stern.pojo.CoursefunctionExample;
import com.stern.service.CoursefunctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CoursefunctionServiceImpl implements CoursefunctionService{
    @Autowired
    private CoursefunctionMapper coursefunctionMapper;
    public List<Coursefunction> selectByExample(CoursefunctionExample example) {
        return coursefunctionMapper.selectByExample(example);
    }
}
