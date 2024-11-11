package com.stern.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(request.getSession().getAttribute("member")!=null){
            return true;
        }
        if (request.getHeader("x-requested-with") != null
                && request.getHeader("x-requested-with")
                .equalsIgnoreCase("XMLHttpRequest")){
            //如果是ajax请求响应头会有，x-requested-with
            response.getWriter().print("logout");
            return false;
        }
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8;");
        PrintWriter writer = response.getWriter();
        writer.print("<script>alert('您还没有登录！');parent.location.href='"+request.getContextPath()+"/index.html'</script>");
        return false;
    }
}
