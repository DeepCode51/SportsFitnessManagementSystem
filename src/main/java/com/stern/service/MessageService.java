package com.stern.service;

import com.stern.pojo.Message;
import com.stern.pojo.MessageExample;
import com.stern.pojo.Reply;

import java.util.List;

/**
 * 留言 -业务逻辑层
 */
public interface MessageService {
    //用户留言
    int insertSelective(Message record);
    //查询所有留言
    List<Message> selectByExample(MessageExample example);
    //根据留言的用户id查询留言和回复（用户的查看留言功能）
    List<Message> selectMessageWithReply(Integer msgMid);
    //后台全查留言，带回复以及用户
    List<Message> selectAllMessageWithReplyAndMember(String msgcontent);
    //新增回复
    int insertSelective(Reply record);
    //根据回复id删除回复
    int deleteReplyByPrimaryKey(Integer rid);
    //根据留言id删除留言
    int deleteMsgByPrimaryKey(Integer msgId);
}
