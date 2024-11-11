package com.stern.service;

import com.stern.pojo.News;
import com.stern.pojo.NewsExample;

import java.util.List;

/**
 * 新闻 -业务逻辑层
 */
public interface NewsService {
    //查询 所有活动
    List<News> selectByExampleWithBLOBs(NewsExample example);
    //根据新闻id查询新闻
    News selectByPrimaryKey(Integer nid);
    //添加新闻
    int insertSelective(News record);
    //根据新闻id修改新闻
    int updateByPrimaryKeySelective(News record);
    //根据新闻id删除
    int deleteByPrimaryKey(Integer nid);
}
