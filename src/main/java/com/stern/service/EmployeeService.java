package com.stern.service;

import com.stern.pojo.Employee;
import com.stern.pojo.EmployeeExample;

import java.util.List;

/**
 * 员工 -业务逻辑层
 */
public interface EmployeeService {
    //添加员工
    int insertSelective(Employee record);
    //查询所有员工
    List<Employee> selectByExample(EmployeeExample example);
    //根据员工ID查询员工
    Employee selectByPrimaryKey(Integer eid);
    //根据员工id更新员工信息
    int updateByPrimaryKeySelective(Employee record);
    //根据员工id删除
    int deleteByPrimaryKey(Integer eid);
}
