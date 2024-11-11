package com.stern.service.impl;

import com.stern.mapper.MemberMapper;
import com.stern.pojo.Member;
import com.stern.pojo.MemberExample;
import com.stern.service.MemberService;
import com.stern.utils.Cons;
import com.stern.utils.Funcs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService{
    @Autowired
    private MemberMapper memberMapper;

    public void addMember(Member member) {
        String oldPwd = member.getMpassword();
        String md5Pwd = Funcs.MD5(Cons.CONS_MD+oldPwd);
        member.setMpassword(md5Pwd);
        memberMapper.insert(member);
    }

    public Member selectMemberByNameAndPwd(String mname, String mpassword) {
        String md5Pwd = Funcs.MD5(Cons.CONS_MD+mpassword);
        MemberExample memberExample = new MemberExample();
        MemberExample.Criteria criteria = memberExample.createCriteria();
        criteria.andMnameEqualTo(mname);
        criteria.andMpasswordEqualTo(md5Pwd);
        List<Member> members = memberMapper.selectByExample(memberExample);
        if(members.size()>0){
            return members.get(0);
        }
        return null;
    }

    public List<Member> selectByExample(MemberExample example) {
        List<Member> members = memberMapper.selectByExample(example);
        return members;
    }

    public Member selectByPrimaryKey(Integer mid) {
        return memberMapper.selectByPrimaryKey(mid);
    }

    public int updateByPrimaryKeySelective(Member record) {
        return memberMapper.updateByPrimaryKeySelective(record);
    }

    public int deleteByPrimaryKey(Integer mid) {
        return memberMapper.deleteByPrimaryKey(mid);
    }

    public long countByExample(MemberExample example) {
        return memberMapper.countByExample(example);
    }
}
