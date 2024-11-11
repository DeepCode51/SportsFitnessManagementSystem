package com.stern.service;

import com.stern.pojo.Member;
import com.stern.pojo.MemberExample;

import java.util.List;

/**
 * 会员 -业务逻辑层
 */
public interface MemberService {
    //注册
   void addMember(Member member);
    //登录
    Member selectMemberByNameAndPwd(String mname,String mpassword);
    //查询所有用户
    List<Member> selectByExample(MemberExample example);
    //根据用户id查询用户
    Member selectByPrimaryKey(Integer mid);
    //根据用户id更新用户
    int updateByPrimaryKeySelective(Member record);
    //根据id删除用户
    int deleteByPrimaryKey(Integer mid);
    //根据用户条件查询是否已经存在
    long countByExample(MemberExample example);
}
