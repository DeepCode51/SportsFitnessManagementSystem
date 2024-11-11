package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stern.pojo.Employee;
import com.stern.pojo.EmployeeExample;
import com.stern.pojo.Post;
import com.stern.pojo.PostExample;
import com.stern.service.EmployeeService;
import com.stern.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 员工 -控制层
 */
@Controller
public class EmployeeController {
    @Autowired
    private PostService postService;
    @Autowired
    private EmployeeService employeeService;
    /**
     * 后台员工管理
     * @return
     */
    @RequestMapping("/admin/employee.html")
    public String employeePage(Model model){
        //查询所有职务
        List<Post> posts = postService.selectByExample(new PostExample());
        model.addAttribute("posts",posts);
        return "admin/employee/employeelist";
    }

    /**
     * 员工管理分页
     * @param page
     * @param limit
     * @param model
     * @param ename
     * @return
     */
    @RequestMapping("/admin/employeelist.html")
    @ResponseBody
    public Map<String,Object> employeelistPage(String page, String limit, Model model, String ename){
        Map<String,Object> employeeMap = new HashMap<String,Object>();
        //查询所有职务
        List<Post> posts = postService.selectByExample(new PostExample());
        model.addAttribute("posts",posts);
        //分页查询员工
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        if(ename != null&& !ename.equals("")){
            criteria.andEnameLike("%"+ename+"%");
        }
        PageHelper.startPage(Integer.parseInt(page),Integer.parseInt(limit));
        List<Employee> employees = employeeService.selectByExample(employeeExample);
        PageInfo<Employee> employeePageInfo = new PageInfo<Employee>(employees);
        employeeMap.put("code",0);
        employeeMap.put("msg","");
        employeeMap.put("count",employeePageInfo.getTotal());
        employeeMap.put("data",employeePageInfo.getList());
        return employeeMap;
    }
    @RequestMapping("/admin/employee/goaddorupdate.html")
    public String goUpdate(Model model,String eid){
        //查询所有职务
        List<Post> posts = postService.selectByExample(new PostExample());
        model.addAttribute("posts",posts);
        //eid不为null，就进行更新，根据员工id查询员工
        if(eid!=null&&!eid.equals(" ")){
            Employee employee = employeeService.selectByPrimaryKey(Integer.parseInt(eid));
            model.addAttribute("employee",employee);
        }
        return "admin/employee/employeeedit";
    }
    @RequestMapping("/admin/employee/doaddorupdate.html")
    @ResponseBody
    public Map<String,Object> doaddorupdate(Employee employee,String time){
        Map<String,Object> updateMap = new HashMap<String,Object>();
        int i = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date date = sdf.parse(time);
            employee.setEhire(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if(employee.getEid()==null){//没有eid则是添加员工
            i = employeeService.insertSelective(employee);
            if(i>0){
                updateMap.put("msg","添加成功");
                updateMap.put("status",1);
            }else{
                updateMap.put("msg","添加失败");
                updateMap.put("status",0);
            }
        }else{
            i = employeeService.updateByPrimaryKeySelective(employee);
            if(i>0){
                updateMap.put("msg","更新成功");
                updateMap.put("status",1);
            }else{
                updateMap.put("msg","更新失败");
                updateMap.put("status",0);
            }
        }

        return updateMap;
    }
    @RequestMapping("/admin/employee/del.html")
    @ResponseBody
    public Map<String,String> delEmployee(String eid){
        Map<String,String> delMap = new HashMap<String, String>();
        int i = employeeService.deleteByPrimaryKey(Integer.parseInt(eid));
        if(i>0){
            delMap.put("status","1");
        }else {
            delMap.put("status","0");
        }
        return delMap;
    }
    /**
     *
     * 教练管理
     *
     */
    @RequestMapping("/admin/trainer.html")
    public String adminTrainer(Model model){
        return "admin/trainer/trainerlist";
    }
    /**
     * 教练管理分页
     */
    @RequestMapping("/admin/trainerlist.html")
    @ResponseBody
    public Map<String,Object> trainerPage(String page,String limit,String ename,Model model){
        Map<String,Object> trainerMap = new HashMap<String,Object>();
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEpostIdEqualTo(1);
        if(ename!=null && !ename.equals(" ")){
            criteria.andEnameLike("%"+ename+"%");
        }
        PageHelper.startPage(Integer.parseInt(page),Integer.parseInt(limit));
        List<Employee> trainers = employeeService.selectByExample(employeeExample);
        PageInfo<Employee> trainerPageInfo = new PageInfo<Employee>(trainers);
        trainerMap.put("code",0);
        trainerMap.put("msg","");
        trainerMap.put("count",trainerPageInfo.getTotal());
        trainerMap.put("data",trainers);
        return trainerMap;
    }
    /**
     * 添加或者更新教练
     */
    @RequestMapping("/admin/trainer/goaddorupdate.html")
    public String trainerGoAddOrUpdate(String eid,Model model){
        if(eid!=null&&!eid.equals(" ")){//更新
            Employee trainer = employeeService.selectByPrimaryKey(Integer.parseInt(eid));
            model.addAttribute("trainer",trainer);
        }
        return "admin/trainer/traineredit";
    }
    @RequestMapping("/admin/trainer/doaddorupdate.html")
    @ResponseBody
    public Map<String,Object>  trainerDoAddOrUpdate(Employee employee,String time){
        Map<String,Object> trainerMap = new HashMap<String,Object>();
        int i = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Date ehire = sdf.parse(time);
            employee.setEhire(ehire);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if(employee.getEid()!=null&&!employee.getEid().equals(" ")){//eid不为null则是更新
            i = employeeService.updateByPrimaryKeySelective(employee);
            if(i>0){
                trainerMap.put("msg","更新成功");
                trainerMap.put("res",1);
            }else {
                trainerMap.put("msg","更新失败");
                trainerMap.put("res",0);
            }
        }else{
            i = employeeService.insertSelective(employee);
            if(i>0){
                trainerMap.put("msg","添加成功");
                trainerMap.put("res",1);
            }else{
                trainerMap.put("msg","添加失败");
                trainerMap.put("res",0);
            }
        }
        return trainerMap;
    }
    /**
     * 教练删除
     */
    @RequestMapping("/admin/trainer/del.html")
    @ResponseBody
    public Map<String,Object> delTrainer(String eid){
        Map<String,Object> delMap = new HashMap<String,Object>();
        int i = employeeService.deleteByPrimaryKey(Integer.parseInt(eid));
        if(i>0){
            delMap.put("status",1);
        }else {
            delMap.put("status",0);
        }
        return delMap;
    }

}