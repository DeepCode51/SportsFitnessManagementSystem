package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stern.pojo.*;
import com.stern.pojo.Class;
import com.stern.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 课程管理 -控制层
 */
@Controller
public class CourseController {
    @Autowired
    private CourseService courseService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private CoursecategoryService coursecategoryService;
    @Autowired
    private CoursefunctionService coursefunctionService;
    @Autowired
    private ClassService classService;
    @Autowired
    private OrderService orderService;

    /**
     * 前台页面-跳转到健身课程
     * @return
     */
    @RequestMapping("/course.html")
    public String coursePage(Model model,String page,String cate,String func){
        System.out.println(cate+"====================================="+func);
        //查询所有课程类型
        List<Coursecategory> coursecategories = coursecategoryService.selectByExample(new CoursecategoryExample());
        model.addAttribute("coursecategories",coursecategories);
        //查询所有课程功能
        List<Coursefunction> coursefunctions = coursefunctionService.selectByExample(new CoursefunctionExample());
        model.addAttribute("coursefunctions",coursefunctions);
        //查询所有课程  总页数
        int _page;
        if(page==null){
            _page = 1;
        }else {
            _page = Integer.parseInt(page);
        }
        //根据课程类型名称查询课程类型ID，根据功能名称查询功能ID
        CourseExample courseExample = new CourseExample();
        CourseExample.Criteria criteria = courseExample.createCriteria();

        CoursecategoryExample coursecategoryExample = new CoursecategoryExample();
        CoursecategoryExample.Criteria criteria1 = coursecategoryExample.createCriteria();

        CoursefunctionExample coursefunctionExample = new CoursefunctionExample();
        CoursefunctionExample.Criteria criteria2 = coursefunctionExample.createCriteria();


        if(cate!=null&&!cate.equals("全部")){
            criteria1.andCateNameEqualTo(cate);
            List<Coursecategory> coursecategories1 = coursecategoryService.selectByExample(coursecategoryExample);
            criteria.andCcateIdEqualTo(coursecategories1.get(0).getCateId());
        }
        if (func!=null&&!func.equals("全部")){
            criteria2.andFnameEqualTo(func);
            List<Coursefunction> coursefunctions1 = coursefunctionService.selectByExample(coursefunctionExample);
            criteria.andCfunctionIdEqualTo(coursefunctions1.get(0).getFid());
        }
        PageHelper.startPage(_page,6);
        List<Course> courses = courseService.selectByExampleWithBLOBs(courseExample);
        PageInfo<Course> pageInfo = new PageInfo<Course>(courses);
        int totalPages = pageInfo.getPages();
        model.addAttribute("totalPages",totalPages);
        model.addAttribute("currentPage",_page);
        model.addAttribute("courses",courses);
        model.addAttribute("cate",cate);
        model.addAttribute("func",func);
        Sheet sheet = courseService.selectSheetByPrimaryKey(1);
        if(sheet!=null){
            model.addAttribute("sheetsrc",sheet.getSsrc());
        }
        return "course";
    }

    /**
     * 前台课程详情页面
     * @param model
     * @param cid
     * @return
     */
    @RequestMapping("/courseinfo.html")
    public String coursePage(Model model,String cid){
        Course course = courseService.selectByPrimaryKey(Integer.parseInt(cid));
        model.addAttribute("course",course);
        //如果是cid为8（游泳）或者18（瑜伽）就查询所有开设班级
        if(cid.equals("8")||cid.equals("18")){
            ClassExample classExample = new ClassExample();
            ClassExample.Criteria criteria = classExample.createCriteria();
            criteria.andCourseIdEqualTo(Integer.parseInt(cid));
            List<Class> classes = classService.selectByExample(classExample);
            //查询该课程已预订人数
            for (Class aClass : classes) {
                TblOrderExample tblOrderExample = new TblOrderExample();
                TblOrderExample.Criteria criteria1 = tblOrderExample.createCriteria();
                criteria1.andClassIdEqualTo(aClass.getClassid());
                long haveOrder = orderService.countByExample(tblOrderExample);
                aClass.setHaveOrder(new Long(haveOrder).intValue());
            }
            model.addAttribute("classes",classes);
            //查询所有教练
            EmployeeExample employeeExample = new EmployeeExample();
            EmployeeExample.Criteria criteria2 = employeeExample.createCriteria();
            criteria2.andEpostIdEqualTo(1);
            List<Employee> trainers = employeeService.selectByExample(employeeExample);
            model.addAttribute("trainers",trainers);
        }
        return "courseinfo";
    }
    /**
     * 后台管理跳转到课程管理界面
     * @return
     */
    @RequestMapping("/admin/course.html")
    public String admincourse(Model model){
        //查询所有员工，进行教练名称显示
        List<Employee> employees = employeeService.selectByExample(new EmployeeExample());
        model.addAttribute("employees",employees);
        //查询所有课程类型
        List<Coursecategory> coursecategories = coursecategoryService.selectByExample(new CoursecategoryExample());
        model.addAttribute("coursecategories",coursecategories);
        //查询所有课程功能
        List<Coursefunction> coursefunctions = coursefunctionService.selectByExample(new CoursefunctionExample());
        model.addAttribute("coursefunctions",coursefunctions);
        return "admin/course/courselist";
    }

    /**
     * 分页+课程名称  查询
     * @param page
     * @param limit
     * @param model
     * @param cname
     * @return
     */
    @RequestMapping("/admin/courselist.html")
    @ResponseBody
    public Map<String,Object> courselistPage(String page, String limit,Model model,String cname){
        List<Employee> employees = employeeService.selectByExample(new EmployeeExample());
        model.addAttribute("employees",employees);
        CourseExample example = new CourseExample();
        if(cname!=null&&!"".equals(cname)){
            CourseExample.Criteria criteria = example.createCriteria();
            criteria.andCnameLike("%"+cname+"%");
        }
        PageHelper.startPage(Integer.parseInt(page),Integer.parseInt(limit));
        List<Course> courses = courseService.selectByExampleWithBLOBs(example);
        PageInfo<Course> pageInfo = new PageInfo<Course>(courses);
        Map<String,Object> pageMap = new HashMap<String,Object >();
        pageMap.put("code",0);
        pageMap.put("msg","");
        pageMap.put("count",pageInfo.getTotal());
        pageMap.put("data",pageInfo.getList());
        return pageMap;
    }


    /**
     * 上传课程图片
     * @param file
     * @return
     */
    @RequestMapping("/admin/upload.html")
    @ResponseBody
    public Map<String,Object> upload(MultipartFile file){
        String extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String filename = System.currentTimeMillis()+extName;
        File newFile = new File(Thread.currentThread().getContextClassLoader().getResource("").getPath().substring(0,Thread.currentThread().getContextClassLoader().getResource("").getPath().length()-16)+"/sterngymimages/"+filename);
        try {
            file.transferTo(newFile);
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,String > srcMap = new HashMap<String, String>();
        srcMap.put("src",filename);
        Map<String,Object> imgMap = new HashMap<String,Object>();
        imgMap.put("code",0);
        imgMap.put("msg","");
        imgMap.put("data",srcMap);
        return imgMap;
    }

    /**
     * 查看课程信息
     * @param model
     * @param cid
     * @return
     */
    @RequestMapping("/admin/courseinfo.html")
    public String courseInfo(Model model,String cid){
        Course course = courseService.selectByPrimaryKey(Integer.parseInt(cid));
        model.addAttribute("course",course);
        //查询所有教练
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEpostIdEqualTo(1);
        List<Employee> trainers = employeeService.selectByExample(example);
        model.addAttribute("trainers",trainers);
        //查询所有课程类型
        List<Coursecategory> coursecategories = coursecategoryService.selectByExample(new CoursecategoryExample());
        model.addAttribute("coursecategories",coursecategories);
        //查询所有课程功能
        List<Coursefunction> coursefunctions = coursefunctionService.selectByExample(new CoursefunctionExample());
        model.addAttribute("coursefunctions",coursefunctions);
        return "admin/course/courseinfo";
    }
    @RequestMapping("/admin/goaddorupdate.html")
    public String admingoaddPage(Model model, @RequestParam(required = false)String cid){
        //查询所有教练
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEpostIdEqualTo(1);
        List<Employee> trainers = employeeService.selectByExample(example);
        model.addAttribute("trainers",trainers);
        //查询所有课程类型
        List<Coursecategory> coursecategories = coursecategoryService.selectByExample(new CoursecategoryExample());
        model.addAttribute("coursecategories",coursecategories);
        //查询所有课程功能
        List<Coursefunction> coursefunctions = coursefunctionService.selectByExample(new CoursefunctionExample());
        model.addAttribute("coursefunctions",coursefunctions);
        //如果是要更新，根据课程id查询课程
        if(cid!=null &&!cid.equals("")){
            Course course = courseService.selectByPrimaryKey(Integer.parseInt(cid));
            model.addAttribute("course",course);
        }
        return "admin/course/courseaddorupdate";
    }

    /**
     * 更新或者添加课程
     * @param course
     * @return
     */
    @RequestMapping("/admin/addorupdate.html")
    public String adminaddorupdatePage(Course course){
        if(course.getCid() == null){//添加
            if(course.getTrainerId().equals(-1)){
                course.setTrainerId(null);
            }
            course.setCcreatetime(new Date());
            courseService.insertSelective(course);
        }else{//更新
            if(course.getTrainerId().equals(-1)){
                course.setTrainerId(null);
            }
            courseService.updateByPrimaryKeySelective(course);
        }
        return "forward:/admin/course.html";
    }
    @RequestMapping("/admin/course/del.html")
    @ResponseBody
    public Map<String,Object> courseDel(String cid){
        int i = courseService.deleteByPrimaryKey(Integer.parseInt(cid));
        Map<String ,Object> delMap = new HashMap<String,Object>();
        if(i>0){//删除成功
            delMap.put("status",1);
        }else{
            delMap.put("status",0);
        }
        return delMap;
    }
    /**
     * 上传课表
     */
    @RequestMapping("/admin/courseupload.html")
    public String courseUpload(Model model){
        Sheet sheet = courseService.selectSheetByPrimaryKey(1);
        if(sheet!=null){
            model.addAttribute("sheetsrc",sheet.getSsrc());
        }
        return "admin/course/courseupload";
    }
    @RequestMapping("/admin/coursesheet.html")
    @ResponseBody
    public Map<String,Object> uploatSheet(MultipartFile file){
        Map<String,Object> uploadMap = new HashMap<String,Object>();
        Map<String,String> srcMap = new HashMap<String, String>();
        String filename = file.getOriginalFilename();
        Sheet sheet = new Sheet();
        sheet.setSsrc(filename);
        if(courseService.countByExample(new SheetExample())==0){
            courseService.insertSelective(sheet);
        }else {
            sheet.setSid(1);
            courseService.updateByPrimaryKey(sheet);
        }
        File newFile = new File(Thread.currentThread().getContextClassLoader().getResource("").getPath().substring(0,Thread.currentThread().getContextClassLoader().getResource("").getPath().length()-16)+"/sterngymimages/"+filename);
        try {
            file.transferTo(newFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        srcMap.put("src",filename);
        uploadMap.put("data",srcMap);
        uploadMap.put("code",0);
        uploadMap.put("msg","");
        return uploadMap;
    }
}
