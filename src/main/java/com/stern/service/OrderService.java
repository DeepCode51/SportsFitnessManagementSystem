package com.stern.service;

import com.stern.pojo.TblOrder;
import com.stern.pojo.TblOrderExample;

import java.util.List;

public interface OrderService {
    //生成订单
    int insertSelective(TblOrder record);
    //根据会员名搜索订单
    List<TblOrder> selectAllOrderWithMember(String mname);
    //根据订单id删除订单
    int deleteByPrimaryKey(Integer oid);
    //根据example 查询总数
    long countByExample(TblOrderExample example);
    //根据订单条件查询订单
    List<TblOrder> selectByExample(TblOrderExample example);
}
