package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stern.pojo.News;
import com.stern.pojo.NewsExample;
import com.stern.pojo.Newskinds;
import com.stern.pojo.NewskindsExample;
import com.stern.service.NewsKindsService;
import com.stern.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 新闻 -控制层
 */
@Controller
public class NewsController {
    @Autowired
    private NewsService newsService;
    @Autowired
    private NewsKindsService newsKindsService;

    /**
     * 前台跳转到新闻界面
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/news.html")
    public String newsPage(Model model,String page){
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds", newskinds);
        //查询所有课程  总页数
        int _page;
        if(page==null){
            _page = 1;
        }else {
            _page = Integer.parseInt(page);
        }
        NewsExample newsExample = new NewsExample();
        newsExample.setOrderByClause("ncreatetime DESC");
        PageHelper.startPage( _page,10);
        List<News> news = newsService.selectByExampleWithBLOBs(newsExample);
        PageInfo<News> newsPageInfo = new PageInfo<News>(news);
        int totalPages = newsPageInfo.getPages();
        model.addAttribute("totalPages",totalPages);
        model.addAttribute("currentPage",_page);
        model.addAttribute("news",news);
        return "news";
    }

    /**
     * 前台ajax分页
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/newsajax.html")
    @ResponseBody
    public Map<String,Object> newsajaxPage(Model model,String page){
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        //分页查询新闻
        NewsExample newsExample = new NewsExample();
        newsExample.setOrderByClause("ncreatetime DESC");
        PageHelper.startPage(Integer.parseInt(page),10);
        List<News> news = newsService.selectByExampleWithBLOBs(newsExample);
        PageInfo<News> newsPageInfo = new PageInfo<News>(news);
        Map<String,Object> newsMap = new HashMap<String,Object>();
        int totalPages = newsPageInfo.getPages();
        newsMap.put("news",news);
        newsMap.put("newskinds",newskinds);
        model.addAttribute("totalPages",totalPages);
        model.addAttribute("currentPage",Integer.parseInt(page));
        return newsMap;
    }
    @RequestMapping("/newsinfo.html")
    public String newsInfo(Model model,String nid){
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds",newskinds);
        News news = newsService.selectByPrimaryKey(Integer.parseInt(nid));
        model.addAttribute("news",news);
        return "newsinfo";
    }
    /**
     * 后台管理跳转到网站管理界面
     *
     * @return
     */
    @RequestMapping("/admin/news.html")
    public String adminnews(Model model) {
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds", newskinds);
        return "admin/news/newslist";
    }

    /**
     * 新闻列表
     *
     * @param page
     * @param limit
     * @param model
     * @param ntitle
     * @return
     */
    @RequestMapping("/admin/newslist.html")
    @ResponseBody
    public Map<String, Object> newslistPage(String page, String limit, Model model, String ntitle) {
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds", newskinds);
        //查询所有新闻
        NewsExample newsExample = new NewsExample();
        NewsExample.Criteria criteria = newsExample.createCriteria();
        if (ntitle != null && !ntitle.equals("")) {
            criteria.andNtitleLike("%"+ntitle+"%");
        }
        PageHelper.startPage(Integer.parseInt(page), Integer.parseInt(limit));
        List<News> news = newsService.selectByExampleWithBLOBs(newsExample);
        PageInfo<News> pageInfo = new PageInfo<News>(news);
        Map<String, Object> pageMap = new HashMap<String, Object>();
        pageMap.put("code", 0);
        pageMap.put("msg", "");
        pageMap.put("count", pageInfo.getTotal());
        pageMap.put("data", pageInfo.getList());
        return pageMap;
    }

    /**
     * 更新或者添加新闻
     * @param model
     * @param nid
     * @return
     */
    @RequestMapping("/admin/news/goaddorupdate.html")
    public String adminGoaddorupdatePage(Model model, @RequestParam(required = false) String nid) {
        //查询所有新闻类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds", newskinds);
        //如果是要更新，根据新闻id查询新闻
        if (nid != null && !nid.equals("")) {
            News news = newsService.selectByPrimaryKey(Integer.parseInt(nid));
            model.addAttribute("news", news);
        }
        return "admin/news/newsaddorupdate";
    }
    /**
     * 更新或者添加新闻
     * @param news
     * @return
     */
    @RequestMapping("/admin/news/addorupdate.html")
    public String adminAddorupdatePage(News news,String time){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date date=sdf.parse(time);
            news.setNcreatetime(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if(news.getNid() == null){//添加
            newsService.insertSelective(news);
        }else{//更新
            newsService.updateByPrimaryKeySelective(news);
        }
        return "forward:/admin/news.html";
    }
    /**
     * 后台查看新闻详情
     * @param model
     * @param nid
     * @return
     */
    @RequestMapping("/admin/newsinfo.html")
    public String adminNewsInfo(Model model,String nid){
        News news = newsService.selectByPrimaryKey(Integer.parseInt(nid));
        model.addAttribute("news",news);
        //查询所有课程类型
        List<Newskinds> newskinds = newsKindsService.selectByExample(new NewskindsExample());
        model.addAttribute("newskinds",newskinds);
        return "admin/news/newsinfo";
    }
    @RequestMapping("/admin/news/del.html")
    @ResponseBody
    public Map<String,Object> newsDel(String nid){
        int i = newsService.deleteByPrimaryKey(Integer.parseInt(nid));
        Map<String ,Object> delMap = new HashMap<String,Object>();
        if(i>0){//删除成功
            delMap.put("status",1);
        }else{
            delMap.put("status",0);
        }
        return delMap;
    }
    /**
     * 富文本编辑器中上传图片组件
     * @param file
     * @return
     */
    @RequestMapping("/admin/news/upload.html")
    @ResponseBody
    public Map<String,Object> uploadImg(MultipartFile file){
        String extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String fileName = System.currentTimeMillis()+extName;
        File newFile = new File(Thread.currentThread().getContextClassLoader().getResource("").getPath().substring(0,Thread.currentThread().getContextClassLoader().getResource("").getPath().length()-16)+"/sterngymimages/"+fileName);
        try {
            file.transferTo(newFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,Object> uploadMap = new HashMap<String,Object>();
        Map<String,String> srcMap = new HashMap<String, String>();
        srcMap.put("src","http://www.csbishe.cn:8009/SternGym/sterngymimages/"+fileName);
        uploadMap.put("code",0);
        uploadMap.put("msg","");
        uploadMap.put("data",srcMap);
        return uploadMap;
    }

}
