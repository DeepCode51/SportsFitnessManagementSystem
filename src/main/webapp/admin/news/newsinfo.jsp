<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/layui/css/layui.css"  media="all">
    <script src="<%=request.getContextPath()%>/js/jquery-1.11.0.min.js"></script>
    <%--要设置富文本编辑器不可编辑 修改了all.js中的东西--%>
    <script src="<%=request.getContextPath()%>/layui/layui.all.js" charset="utf-8"></script>

    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<form class="layui-form">
    <input type="hidden" name="nid" value="${news.nid}">
    <div class="layui-form-item">
        <label class="layui-form-label">新闻标题</label>
        <div class="layui-input-inline">
            <input type="text" name="ntitle" lay-verify="required" disabled autocomplete="off" class="layui-input" value="${news.ntitle}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发布时间</label>
        <div class="layui-input-inline">
            <input  type="text" disabled id="ncreatetime" name="ncreatetime" lay-verify="required"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新闻类型</label>
        <div class="layui-input-inline">
                <c:forEach items="${newskinds}" var="newskind">
                    <c:if test="${news.nkId==newskind.nkid}">
                        <input disabled type="text" lay-verify="required"  autocomplete="off" class="layui-input" value="${newskind.nkname}">
                    </c:if>
                </c:forEach>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">新闻内容</label>
        <div class="layui-input-block">
            <textarea name="ncontent" id="ncontent"  class="layui-textarea">${news.ncontent}</textarea>
        </div>
    </div>
</form>
<script>
    //对laydate的默认时间 吧时间字符串 转换成 时间对象
    function dateToGMT(strDate){
        var dateStr=strDate.split(" ");
        var strGMT = dateStr[0]+" "+dateStr[1]+" "+dateStr[2]+" "+dateStr[5]+" "+dateStr[3]+" GMT+0800";
        var date = new Date(Date.parse(strGMT));
        return date;
    }
    layui.use(['laydate','layedit'],function () {
       var laydate = layui.laydate
           , $ = layui.jquery
           ,layedit = layui.layedit;
       laydate.render({
           elem:'#ncreatetime',
           type:'datetime',
           value:dateToGMT('${news.ncreatetime}'),
       });
        layedit.set({
            uploadImage:{
                url:'<%=request.getContextPath()%>/admin/news/upload.html',
                type:'post',
            }
        });
        var index = layedit.build('ncontent',{ disabled:'false',});
    });
</script>
</body>
</html>
