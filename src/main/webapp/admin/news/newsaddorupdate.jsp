<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css"  media="all">
    <script src="<%=request.getContextPath()%>/js/jquery-1.11.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/layui/layui.js" charset="utf-8"></script>

    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<span class="layui-breadcrumb">

  <a href="<%=request.getContextPath()%>/admin/newslist.jsp">新闻管理</a>
    <c:choose>
        <c:when test="${!empty news}">
            <a><cite>更新新闻</cite></a>
        </c:when>
        <c:otherwise>
            <a><cite>添加新闻</cite></a>
        </c:otherwise>
    </c:choose>
</span>
<form class="layui-form" action="<%=request.getContextPath()%>/admin/news/addorupdate.html" method="post">
    <input type="hidden" name="nid" value="${news.nid}">
    <div class="layui-form-item">
        <label class="layui-form-label">新闻标题</label>
        <div class="layui-input-inline">
            <input type="text" name="ntitle" lay-verify="required" autocomplete="off" class="layui-input" value="${news.ntitle}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发布时间</label>
        <div class="layui-input-inline">
            <input type="text" id="time" name="time" lay-verify="required"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新闻类型</label>
        <div class="layui-input-inline">
            <select name="nkId" lay-verify="required">
                <c:forEach items="${newskinds}" var="newskind">
                    <option value="${newskind.nkid}" <c:if test="${news.nkId==newskind.nkid}"> selected</c:if>>${newskind.nkname}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">新闻内容</label>
        <div class="layui-input-block">
        <textarea name="ncontent" id="ncontent" class="layui-textarea" style="display: none">${news.ncontent}</textarea>
    </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
            <button type="reset" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </div>
</form>

<script>
    //对laydate的默认时间 初始化
    function dateToGMT(strDate){
        var dateStr=strDate.split(" ");
        var strGMT = dateStr[0]+" "+dateStr[1]+" "+dateStr[2]+" "+dateStr[5]+" "+dateStr[3]+" GMT+0800";
        var date = new Date(Date.parse(strGMT));
        return date;
    }
    layui.use(['form','element','laydate','layedit'], function(){
        var form = layui.form
            ,element = layui.element//导航的hover效果、二级菜单等功能，需要依赖element模块
            ,$ = layui.jquery
            ,upload = layui.upload
            ,laydate = layui.laydate
            ,layedit = layui.layedit;

        //监听提交
        form.on('submit(formDemo)', function(data){
//            layer.msg(JSON.stringify(data.field));
//            return false;
        });
        //监听导航点击
        element.on('nav(demo)', function(elem){
            //console.log(elem)
            layer.msg(elem.text());
        });
        //日期选择器
        if(${!empty news.ncreatetime}){//编辑
            laydate.render({
                elem:'#time',
                type:'datetime',
                value:dateToGMT('${news.ncreatetime}')
            });
        }else{//添加
            laydate.render({
                elem:'#time',
                type:'datetime',
                value:new Date()
            });
        }
        //富文本编辑器
        layedit.set({
            uploadImage:{
                url:'<%=request.getContextPath()%>/admin/news/upload.html',
                type:'post'
            }
        });
        var index = layedit.build('ncontent');
    });
</script>
</body>
</html>
