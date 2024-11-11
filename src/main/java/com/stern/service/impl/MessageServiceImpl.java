package com.stern.service.impl;

import com.stern.mapper.MessageMapper;
import com.stern.mapper.ReplyMapper;
import com.stern.pojo.Message;
import com.stern.pojo.MessageExample;
import com.stern.pojo.Reply;
import com.stern.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private ReplyMapper replyMapper;

    public int insertSelective(Message record) {
        return messageMapper.insertSelective(record);
    }

    public List<Message> selectByExample(MessageExample example) {
        return messageMapper.selectByExample(example);
    }

    public List<Message> selectMessageWithReply(Integer msgMid) {
        return messageMapper.selectMessageWithReply(msgMid);
    }

    public List<Message> selectAllMessageWithReplyAndMember(String msgcontent) {
        return messageMapper.selectAllMessageWithReplyAndMember(msgcontent);
    }

    public int insertSelective(Reply record) {
        return replyMapper.insertSelective(record);
    }

    public int deleteReplyByPrimaryKey(Integer rid) {
        return replyMapper.deleteByPrimaryKey(rid);
    }

    public int deleteMsgByPrimaryKey(Integer msgId) {
        return messageMapper.deleteByPrimaryKey(msgId);
    }
}
