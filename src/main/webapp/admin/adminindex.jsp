<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>sport健身房后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
    <script src="../layui/layui.js" charset="utf-8"></script>
    <script src="../js/jquery-1.11.0.min.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">sport健身后台</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
       <%-- <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>--%>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <%--<img src="http://t.cn/RCzsdCq" class="layui-nav-img">--%>
                    ${member.mname}
                </a>
                <dl class="layui-nav-child">
                    <%--<dd><a href="">基本资料</a></dd>--%>
                    <%--<dd><a href="">安全设置</a></dd>--%>
                    <dd><a href="javascript:void(0);" onclick="loginout()">退出</a></dd>
                </dl>
            </li>
            <%--<li class="layui-nav-item"><a href="">退了</a></li>--%>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="<%=request.getContextPath()%>/admin/memberlist.html" target="option">会员管理</a>
                    <%--<dl class="layui-nav-child">--%>
                        <%--<dd><a href="javascript:;">列表一</a></dd>--%>
                        <%--<dd><a href="javascript:;">列表二</a></dd>--%>
                        <%--<dd><a href="javascript:;">列表三</a></dd>--%>
                        <%--<dd><a href="">超链接</a></dd>--%>
                    <%--</dl>--%>
                </li>
                <li class="layui-nav-item">
                    <a href="<%=request.getContextPath()%>/admin/employee.html" target="option">员工管理</a>
                    <%--<dl class="layui-nav-child">--%>
                        <%--<dd><a href="javascript:;">列表一</a></dd>--%>
                        <%--<dd><a href="javascript:;">列表二</a></dd>--%>
                        <%--<dd><a href="">超链接</a></dd>--%>
                    <%--</dl>--%>
                </li>
                <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin/trainer.html" target="option">教练管理</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">健身课程</a>
                    <dl class="layui-nav-child">
                        <dd><a href="<%=request.getContextPath()%>/admin/course.html" target="option">课程管理</a></dd>
                        <dd><a href="<%=request.getContextPath()%>/admin/courseupload.html" target="option">课表管理</a></dd>
                    </dl>
                </li>
               <!--  <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin/order.html" target="option">订单管理</a></li>-->
                <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin/news.html" target="option">网站管理</a></li>
                <li class="layui-nav-item"><a href="<%=request.getContextPath()%>/admin/message.html" target="option">留言板管理</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <iframe id="option" name="option" src="<%=request.getContextPath()%>/admin/memberlist.html" style="overflow: visible;" scrolling="yes" frameborder="no" width="100%" height="100%"></iframe>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        sport健身俱乐部
    </div>
</div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element
    });
    function loginout() {
        $.ajax({
            url:'<%=request.getContextPath()%>/member/loginout.html',
            success:function (data) {
                if(data.status == 1){
                    window.location.href="<%=request.getContextPath()%>/index.html";
                }
            }
        });
    }
</script>
</body>
</html>