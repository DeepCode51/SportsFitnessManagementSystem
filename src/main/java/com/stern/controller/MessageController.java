package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stern.pojo.Member;
import com.stern.pojo.Message;
import com.stern.pojo.Reply;
import com.stern.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 留言 -控制层
 */
@Controller
public class MessageController {
    @Autowired
    private MessageService messageService;

    /**
     * 用户前台留言
     * @param msgcontent
     * @param mid
     * @return
     */
    @RequestMapping("/member/sendmessage.html")
    @ResponseBody
    public Map<String,Object> sendMsg(String msgcontent,String mid){
        Map<String,Object> sendMsgMap = new HashMap<String,Object>();
        if(msgcontent==null){
            sendMsgMap.put("msg","留言不能为空");
            return sendMsgMap;
        }else {
            Message message = new Message();
            message.setMsgMid(Integer.parseInt(mid));
            message.setMsgContent(msgcontent);
            message.setMsgDate(new Date());
            int i = messageService.insertSelective(message);
            if(i>0){
                sendMsgMap.put("status",1);
                sendMsgMap.put("msg","留言成功");
            }else{
                sendMsgMap.put("status",0);
                sendMsgMap.put("msg","留言失败");
            }
            return sendMsgMap;
        }
    }

    /**
     * 前台 用户查看留言
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/message.html")
    public String memberCenter(HttpServletRequest request, Model model){
        Member member = (Member)request.getSession().getAttribute("member");
        List<Message> messages = messageService.selectMessageWithReply(member.getMid());
        model.addAttribute("messages",messages);
        return "membermessage";
    }
    /**
     * 后台 跳转到留言管理页面
     */
    @RequestMapping("/admin/message.html")
    public String adminMsg(){
        return "admin/message/messagelist";
    }
    /**
     * 后台 留言管理分页
     */
    @RequestMapping("/admin/messagelist.html")
    @ResponseBody
    public Map<String,Object> messageList(String page,String limit,String msgcontent){
        Map<String,Object> messagePageMap = new HashMap<String,Object>();
        PageHelper.startPage(Integer.parseInt(page),Integer.parseInt(limit));
        List<Message> messages = messageService.selectAllMessageWithReplyAndMember(msgcontent);
        PageInfo<Message> messagePageInfo = new PageInfo<Message>(messages);
        messagePageMap.put("code",0);
        messagePageMap.put("msg","");
        messagePageMap.put("count",messagePageInfo.getTotal());
        messagePageMap.put("data",messages);
        return messagePageMap;
    }
    /**
     * 进行回复
     */
    @RequestMapping("/admin/message/goreply.html")
    public String gpReply(String msgid,Model model){
        model.addAttribute("msgid",Integer.parseInt(msgid));
        return "admin/message/reply";
    }
    @RequestMapping("/admin/message/doreply.html")
    @ResponseBody
    public Map<String,Object> doReply(Reply reply){
        Map<String,Object> replyMap = new HashMap<String,Object>();
        Date rdate = new Date();
        reply.setRdate(rdate);
        if(!reply.getRcontent().trim().equals("")){//回复去除空格之后不为“”
            int i = messageService.insertSelective(reply);
            if(i>0){
                replyMap.put("status",1);
                replyMap.put("msg","回复成功");
            }else {
                replyMap.put("status",0);
                replyMap.put("msg","回复失败");
            }
        }else{
            replyMap.put("status",0);
            replyMap.put("msg","回复不能为空");
        }

        return replyMap;
    }
    /**
     * 删除回复
     */
    @RequestMapping("/admin/message/delReply.html")
    @ResponseBody
    public Map<String,String> delReply(String rid){
        Map<String,String> delMap = new HashMap<String, String>();
        int i = messageService.deleteReplyByPrimaryKey(Integer.parseInt(rid));
        if(i>0){
            delMap.put("status","1");
        }else {
            delMap.put("status","0");
        }
        return delMap;
    }
    /**
     * 删除留言
     */
    @RequestMapping("/admin/message/delMsg.html")
    @ResponseBody
    public Map<String,String > delMsg(String msgid){
        Map<String,String> delMap = new HashMap<String, String>();
        int i =messageService.deleteMsgByPrimaryKey(Integer.parseInt(msgid));
        if(i>0){
            delMap.put("status","1");
        }else {
            delMap.put("status","0");
        }
        return delMap;
    }

}
