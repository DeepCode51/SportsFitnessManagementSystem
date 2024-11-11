package com.stern.service;

import com.stern.pojo.Newskinds;
import com.stern.pojo.NewskindsExample;

import java.util.List;

/**
 * 新闻种类 -业务逻辑层
 */
public interface NewsKindsService {
    //查询所有新闻类型
    List<Newskinds> selectByExample(NewskindsExample example);
}
