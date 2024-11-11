package com.stern.service.impl;

import com.stern.mapper.NewsMapper;
import com.stern.pojo.News;
import com.stern.pojo.NewsExample;
import com.stern.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsServiceImpl implements NewsService{
    @Autowired
    private NewsMapper newsMapper;
    public List<News> selectByExampleWithBLOBs(NewsExample example) {
        return newsMapper.selectByExampleWithBLOBs(example);
    }

    public News selectByPrimaryKey(Integer nid) {
        return newsMapper.selectByPrimaryKey(nid);
    }

    public int insertSelective(News record) {
        return newsMapper.insertSelective(record);
    }

    public int updateByPrimaryKeySelective(News record) {
        return newsMapper.updateByPrimaryKeySelective(record);
    }

    public int deleteByPrimaryKey(Integer nid) {
        return newsMapper.deleteByPrimaryKey(nid);
    }

}
