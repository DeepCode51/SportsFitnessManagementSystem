package com.stern.service.impl;

import com.stern.mapper.EmployeeMapper;
import com.stern.pojo.Employee;
import com.stern.pojo.EmployeeExample;
import com.stern.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public int insertSelective(Employee record) {
        return employeeMapper.insertSelective(record);
    }

    public List<Employee> selectByExample(EmployeeExample example) {
        return employeeMapper.selectByExample(example);
    }

    public Employee selectByPrimaryKey(Integer eid) {
        return employeeMapper.selectByPrimaryKey(eid);
    }

    public int updateByPrimaryKeySelective(Employee record) {
        return employeeMapper.updateByPrimaryKeySelective(record);
    }

    public int deleteByPrimaryKey(Integer eid) {
        return employeeMapper.deleteByPrimaryKey(eid);
    }
}
