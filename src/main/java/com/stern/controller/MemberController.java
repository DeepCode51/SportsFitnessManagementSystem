package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.stern.pojo.Member;
import com.stern.pojo.MemberExample;
import com.stern.service.MemberService;
import com.stern.utils.Cons;
import com.stern.utils.Funcs;
import com.stern.utils.SendMail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;

@Controller
public class MemberController {
    @Autowired
    private MemberService memberService;
    @Autowired
    private DefaultKaptcha kaptcha;

    /**
     * 注册
     * @param member
     * @param result
     * @return
     */
    @RequestMapping("/user/register.html")
    @ResponseBody
    public Map<String,Object> reg(@Validated Member member, BindingResult result, @RequestParam("gender")String gender, @RequestParam("repassword") String repassword){
        Map<String,Object> errorMap = new HashMap<String, Object>();
        List<String> errorList = new ArrayList<String>();
        if(result.hasErrors()||!member.getMpassword().equals(repassword)){
            errorMap.put("status","0");
            if(!member.getMpassword().equals(repassword)){
                errorList.add("两次输入密码不一致");
            }
            FieldError nameError = result.getFieldError("mname");
            FieldError mpasswordError = result.getFieldError("mpassword");
            FieldError midnoError = result.getFieldError("midno");
            FieldError mphoneError = result.getFieldError("mphone");
            FieldError memailError = result.getFieldError("memail");
            if(nameError != null){
                errorList.add(nameError.getDefaultMessage());
            }
            if(mpasswordError != null){
                errorList.add(mpasswordError.getDefaultMessage());
            }
            if(midnoError != null){
                errorList.add(midnoError.getDefaultMessage());
            }
            if(mphoneError != null){
                errorList.add(mphoneError.getDefaultMessage());
            }
            if(memailError != null){
                errorList.add(memailError.getDefaultMessage());
            }
            errorMap.put("errorList",errorList);
        }else{
            if(gender.equals("1")){
              member.setMgender(1);
            }else{
                member.setMgender(0);
            }
            member.setMdate(new Date());
            memberService.addMember(member);
            errorMap.put("status","1");
            errorMap.put("msg","注册成功，请前往登录！");
        }
        return errorMap;
    }
    /**
     * 注册时校验邮箱和手机号是否已经被注册
     */
    @RequestMapping("/user/verifyemailandphone.html")
    @ResponseBody
    public Map<String,Object> verifyEmailAndPhone(String memail,String mphone){
        Map<String,Object> verifyMap = new HashMap<String,Object>();
        if(memail!=null&&!memail.equals(" ")){
            MemberExample memberExample1 = new MemberExample();
            MemberExample.Criteria criteria = memberExample1.createCriteria();
            criteria.andMemailEqualTo(memail);
            long memailCount = memberService.countByExample(memberExample1);
            if(memailCount>0){
                verifyMap.put("status",0);
                verifyMap.put("msg","邮箱已被注册");
                return verifyMap;
            }
        }
        if(mphone!=null && !mphone.equals(" ")){
            MemberExample memberExample2 = new MemberExample();
            MemberExample.Criteria criteria2 = memberExample2.createCriteria();
            criteria2.andMphoneEqualTo(mphone);
            long mphoneCount = memberService.countByExample(memberExample2);
            if(mphoneCount>0){
                verifyMap.put("status",0);
                verifyMap.put("msg","手机号已被注册");
                return verifyMap;
            }
        }
        verifyMap.put("status",1);
        return verifyMap;
    }
    /**
     * 点击验证码重新生成新的验证码
     */
    @RequestMapping("/login/captcha.html")
    public void captcha(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String capText = kaptcha.createText();
        request.getSession().setAttribute(
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY, capText);
        BufferedImage bi = kaptcha.createImage(capText);
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
    }
    /**
     * 验证码校验
     */
    @RequestMapping("/kaptchaverify.html")
    @ResponseBody
    public Map<String,Object> verifyCode(String code,HttpServletResponse response,HttpServletRequest request){
        Map<String,Object> verifyMap = new HashMap<String,Object>();
        String codeText = (String)request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
        if(codeText.equals(code)){
            verifyMap.put("status",1);
        }else{
            verifyMap.put("status",0);
            verifyMap.put("msg","验证码错误");
        }
        return verifyMap;
    }
    /**
     * 忘记密码 -重置密码
     */
    @RequestMapping("/user/resetpwd.html")
    @ResponseBody
    public Map<String,Object> resetPwd(String email){
        Map<String,Object> map = new HashMap<String,Object>();

        if(email!=null&&!email.equals(" ")){
            MemberExample memberExample = new MemberExample();
            MemberExample.Criteria criteria = memberExample.createCriteria();
            criteria.andMemailEqualTo(email);
            List<Member> members = memberService.selectByExample(memberExample);
            if(members.size()>0){
                if(SendMail.sendMail(email,members.get(0).getMname())){
                    String newPwd = Funcs.MD5(Cons.CONS_MD+"123456789");
                    members.get(0).setMpassword(newPwd);
                    memberService.updateByPrimaryKeySelective(members.get(0));
                    map.put("msg","重置成功，请用新密码登录,如果没有查收到邮件，请到垃圾箱中查看！");
                }else{
                    map.put("msg","重置失败");
                }

            }else if(members.size() == 0){
                map.put("msg","该邮箱没有被注册");
            }
        }else{
            map.put("msg","请输入正确的邮箱");
        }
        return map;
    }
    /**
     * 前台跳转到登录界面
     * @param request
     * @param model
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/login.html")
    public String loginPage(HttpServletRequest request,Model model) throws IOException {
        //判断是否用户登录时选择了记住密码，即cookie中有没有信息
        Cookie[] cookies = request.getCookies();
        String username = "";
        String pwd = "";
        if(cookies != null){
            for (Cookie cookie : cookies) {
                if(cookie.getName().equals("user")){
                    username = URLDecoder.decode(cookie.getValue().split("#")[0],"UTF-8");
                    pwd = cookie.getValue().split("#")[1];
                    break;
                }
            }
            model.addAttribute("mname",username);
            model.addAttribute("mpassword",pwd);
        }
        return "login";
    }

    /**
     * 用户登录
     * @param mname
     * @param mpassword
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/user/login.html")
    @ResponseBody
    public Map<String, String> login(String mname, String mpassword, HttpServletRequest request, HttpServletResponse response) throws Exception{
        Map<String, String> res = new HashMap<String, String>();
        Member member = memberService.selectMemberByNameAndPwd(mname, mpassword);
        if (member != null) {
            res.put("status", "1");
            if (request.getParameter("isRemember") != null) {
                Cookie cookie = new Cookie("user", java.net.URLEncoder.encode(mname,"utf-8")+"#"+mpassword);
                cookie.setPath("/");
                cookie.setMaxAge(7 * 24 * 60 * 60);//一星期
                response.addCookie(cookie);
            }
            res.put("username",mname);
            request.getSession().setAttribute("member", member);
        } else {
            res.put("status", "0");
            res.put("msg", "用户名或者密码错误！");
        }
        return res;
    }
    /**
     * 用户退出
     * @param request
     * @return
     */
    @RequestMapping("/member/loginout.html")
    @ResponseBody
    public Map<String,Object> loginout(HttpServletRequest request){
        Map<String,Object> loginoutMap = new HashMap<String,Object>();
        request.getSession().removeAttribute("member");
        request.getSession().invalidate();
        loginoutMap.put("status",1);
        return loginoutMap;
    }

    /**
     * 跳转到后台
     * @return
     */
    @RequestMapping("admin/adminindex.html")
    public Object admin(HttpServletRequest request,HttpServletResponse response,Model model) throws IOException{
        Member member = (Member)request.getSession().getAttribute("member");
        if(!member.getMname().equals("admin")){
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html;charset=utf-8;");
            PrintWriter writer = response.getWriter();
            writer.print("<script>alert('没有访问权限！');parent.location.href='"+request.getContextPath()+"/index.html'</script>");
            return false;
        }
        return request.getContextPath()+"/admin/adminindex";
    }
    /**
     * 后台跳转到会员管理
     * @return
     */
    @RequestMapping("/admin/memberlist.html")
    public String memberlistPage(){
        return "admin/member/membermanage";
    }

    /**
     * 后台会员管理分页
     * @param page
     * @param limit
     * @param mname
     * @return
     */
    @RequestMapping("/admin/userlist.html")
    @ResponseBody
    public Map<String,Object> userlistPage(String page,String limit,String mname){
        MemberExample memberExample = new MemberExample();
        if(mname != null && !mname.equals("")){
            MemberExample.Criteria criteria = memberExample.createCriteria();
            criteria.andMnameLike("%"+mname+"%");
        }
        PageHelper.startPage(Integer.parseInt(page),Integer.parseInt(limit));
        List<Member> members = memberService.selectByExample(memberExample);
        PageInfo<Member> pageInfo = new PageInfo<Member>(members);
        Map<String,Object> pageMap = new HashMap<String,Object >();
        pageMap.put("code",0);
        pageMap.put("msg","");
        pageMap.put("count",pageInfo.getTotal());
        pageMap.put("data",pageInfo.getList());
        return pageMap;
    }

    /**
     * 后台 -会员更新
     * @param model
     * @param mid
     * @return
     */
    @RequestMapping("/admin/member/goupdate.html")
    public String memberGoUpdate(Model model,String mid){
        Member member = memberService.selectByPrimaryKey(Integer.parseInt(mid));
        model.addAttribute("member",member);
        return "admin/member/memberedit";
    }
    @RequestMapping("/admin/member/doupdate.html")
    @ResponseBody
    public Map<String,Object> memberGoUpdate(Member member){
        Map<String,Object> updateMap = new HashMap<String,Object>();
        int i = memberService.updateByPrimaryKeySelective(member);
        if(i>0){
            updateMap.put("status",1);
        }else {
            updateMap.put("status",0);
        }
        return updateMap;
    }

    /**
     * 管理员删除用户
     * @param mid
     * @return
     */
    @RequestMapping("/admin/del.html")
    @ResponseBody
    public Map<String,Object> userdelPage(String mid){
        int i = memberService.deleteByPrimaryKey(Integer.parseInt(mid));
        Map<String,Object> delMap = new HashMap<String,Object >();
        if(i>0){
            delMap.put("status",1);
        }else{
           delMap.put("status",0);
        }
        return delMap;
    }
}
