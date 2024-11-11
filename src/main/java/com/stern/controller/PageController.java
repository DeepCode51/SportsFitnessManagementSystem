package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.stern.pojo.*;
import com.stern.service.NewsKindsService;
import com.stern.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class PageController {
    @Autowired
    private NewsService newsService;
    @Autowired
    private NewsKindsService newsKindsService;
    @RequestMapping("/index.html")
    public String indexPage(Model model, HttpServletRequest request){
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds", newskinds);

        NewsExample newsExample = new NewsExample();
        NewsExample.Criteria criteria = newsExample.createCriteria();
        newsExample.setOrderByClause("ncreatetime DESC");
        //查询活动
        criteria.andNkIdEqualTo(1);
        PageHelper.startPage( 1,4);
        List<News> newsHuodong = newsService.selectByExampleWithBLOBs(newsExample);
        model.addAttribute("newsHuodong",newsHuodong);
        //查询公告
        NewsExample newsExample2 = new NewsExample();
        NewsExample.Criteria criteria2 = newsExample2.createCriteria();
        criteria2.andNkIdEqualTo(4);
        PageHelper.startPage( 1,4);
        List<News> newsGonggao = newsService.selectByExampleWithBLOBs(newsExample2);
        model.addAttribute("newsGonggao",newsGonggao);
        //当登录之后再跳转到这的时候在session中取到用户信息
        Member member = (Member)request.getSession().getAttribute("member");
        model.addAttribute("member",member);
        return "index";
    }
    @RequestMapping("/about.html")
    public String aboutPage(){
        return "about";
    }
    @RequestMapping("/register.html")
    public String registerPage(){
        return "register";
    }
}
