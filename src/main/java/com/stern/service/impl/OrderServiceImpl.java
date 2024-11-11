package com.stern.service.impl;

import com.stern.mapper.TblOrderMapper;
import com.stern.pojo.TblOrder;
import com.stern.pojo.TblOrderExample;
import com.stern.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private TblOrderMapper tblOrderMapper;

    public int insertSelective(TblOrder record) {
        return tblOrderMapper.insertSelective(record);
    }

    public List<TblOrder> selectAllOrderWithMember(String mname) {
        return tblOrderMapper.selectAllOrderWithMember(mname);
    }

    public int deleteByPrimaryKey(Integer oid) {
        return tblOrderMapper.deleteByPrimaryKey(oid);
    }

    public long countByExample(TblOrderExample example) {
        return tblOrderMapper.countByExample(example);
    }

    public List<TblOrder> selectByExample(TblOrderExample example) {
        return tblOrderMapper.selectByExample(example);
    }
}
