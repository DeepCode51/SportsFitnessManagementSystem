package com.stern.service.impl;

import com.stern.mapper.NewskindsMapper;
import com.stern.pojo.Newskinds;
import com.stern.pojo.NewskindsExample;
import com.stern.service.NewsKindsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsKindsServiceImpl implements NewsKindsService {
    @Autowired
    private NewskindsMapper newskindsMapper;
    public List<Newskinds> selectByExample(NewskindsExample example) {
        return newskindsMapper.selectByExample(example);
    }
}
