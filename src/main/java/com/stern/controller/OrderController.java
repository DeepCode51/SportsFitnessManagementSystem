package com.stern.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.stern.pojo.Class;
import com.stern.pojo.Member;
import com.stern.pojo.TblOrder;
import com.stern.pojo.TblOrderExample;
import com.stern.service.ClassService;
import com.stern.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单管理 -控制层
 */
@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private ClassService classService;
    /**
     * 后台跳转到订单页面
     * @return
     */
    @RequestMapping("/admin/order.html")
    public String adminOrder(){
        return "admin/order/orderlist";
    }

    /**
     * 订单后台分页
     * @param page
     * @param limit
     * @param mname
     * @return
     */
    @RequestMapping("/admin/orderlist.html")
    @ResponseBody
    public Map<String,Object> orderList(String page,String limit,String mname){
        Map<String,Object> orderPageMap = new HashMap<String,Object>();
        PageHelper.startPage(Integer.parseInt(page),Integer.parseInt(limit));
        List<TblOrder> orders = orderService.selectAllOrderWithMember(mname);
        PageInfo<TblOrder> orderPageInfo = new PageInfo<TblOrder>(orders);
        orderPageMap.put("code",0);
        orderPageMap.put("msg","");
        orderPageMap.put("count",orderPageInfo.getTotal());
        orderPageMap.put("data",orders);
        return orderPageMap;
    }

    /**
     * 预订
     * @param classId
     * @return
     */
    @RequestMapping("/class/order.html")
    @ResponseBody
    public Map<String,Object> orderCourse(String classId, HttpServletRequest request){
        Map<String,Object> orderMap = new HashMap<String,Object>();
        TblOrder order = new TblOrder();
        Member member = (Member) request.getSession().getAttribute("member");
        order.setMemberId(member.getMid());
        order.setOcreatetime(new Date());
        order.setOstatus(0);
        order.setClassId(Integer.parseInt(classId));
        TblOrderExample tblOrderExample = new TblOrderExample();
        TblOrderExample.Criteria criteria = tblOrderExample.createCriteria();
        criteria.andMemberIdEqualTo(member.getMid());
        criteria.andClassIdEqualTo(Integer.parseInt(classId));
        List<TblOrder> tblOrders = orderService.selectByExample(tblOrderExample);
        if(!tblOrders.isEmpty()){//不为null说明已经预订
            orderMap.put("msg","您已经预订过该课程，不可重复预订");
        }else{
            //判断是否已经满员
            //1、先根据课程id查询课程的容量
            TblOrderExample tblOrderExample2 = new TblOrderExample();
            Class clazz = classService.selectByPrimaryKey(Integer.parseInt(classId));
            TblOrderExample.Criteria criteria2 = tblOrderExample2.createCriteria();
            criteria2.andClassIdEqualTo(Integer.parseInt(classId));
            long haveOrder = orderService.countByExample(tblOrderExample2);
            //2、已经预订人数和容量比较
            if(new Long(haveOrder).intValue() == clazz.getClassvolume() ){
                orderMap.put("msg","班级已经满员");
            }else{
                int i = orderService.insertSelective(order);
                if(i>0){
                    orderMap.put("msg","预订成功");
                }else {
                    orderMap.put("msg","预订失败");
                }
            }
        }
        return orderMap;
    }
    @RequestMapping("/admin/order/del.html")
    @ResponseBody
    public Map<String,Object> delOrder(String oid){
        Map<String,Object> delMap = new HashMap<String,Object>();
        int i = orderService.deleteByPrimaryKey(Integer.parseInt(oid));
        if(i>0){
            delMap.put("status",1);
        }else{
            delMap.put("status",0);
        }
        return delMap;
    }

}
