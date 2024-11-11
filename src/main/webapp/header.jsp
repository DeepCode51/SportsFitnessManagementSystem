<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--二级菜单样式--%>
<style>
    #son_ul{
        position: absolute;
        list-style-type: none;
        z-index: 11;
    }
    #son_ul>li{
        line-height: 24px;
        width: 100px;
        text-align: center;
        border-bottom: 1px solid #1b6aaa;
        border-left: 1px solid #1b6aaa;
        border-right: 1px solid #1b6aaa;
        margin: 0px;
    }
</style>

<script>
    <%--二级菜单js   start--%>
    $(document).ready(function () {
            $("#son_ul").hide();
            $("#parentLi").hover(
                function() {
                    $("#son_ul").show(200);
                    $("#son_ul>li").hover(function () {
                        $(this).css("background","#9AFF9A");
                    },function () {
                        $(this).css("background","");
                    });
                },function(){
                    $("#son_ul").hide(300);
                }
            );
    });
    <%--二级菜单js    end --%>
</script>
<div class="banner" id="home">
    <div class="header">
        <div class="container">
            <div class="header-main">
                <div class="logo">
                    <h1><a href="index.html"><span class="logo-clr">S</span>tern </a></h1>
                </div>
                <div class="header-right">
                    <div class="top-nav">
                        <span class="menu"> <img src="images/icon.png" alt=""/></span>
                        <ul class="res">
                            <li><a class="scroll" href="<%=request.getContextPath()%>/index.html">首页</a></li>
                            <li><a class="scroll" href="<%=request.getContextPath()%>/about.html">关于我们</a></li>
                            <li><a class="scroll" href="<%=request.getContextPath()%>/news.html">新闻活动</a></li>
                            <li><a class="scroll" href="<%=request.getContextPath()%>/course.html">健身课程</a></li>
                            <c:choose>
                                <c:when test="${empty member}">
                                    <li><a class="scroll" href="<%=request.getContextPath()%>/login.html">会员登录</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li id="parentLi"style="position: relative"><a class="scroll" href="#">${member.mname}</a>
                                        <ul id="son_ul">
                                            <li>
                                                <a class="scroll" href="<%=request.getContextPath()%>/message.html">查看留言</a>
                                            </li>
                                            <li>
                                                <a class="scroll" href="javascript:void(0);" onclick="loginout()">退出</a>
                                            </li>
                                        </ul>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                        <!-- menu 窗口缩小点击展示 -->
                        <script>
                            $("span.menu").click(function () {
                                $("ul.res").slideToggle(300, function () {});
                            });
                        </script>
                        <!-- /menu 窗口缩小点击展示 -->
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="banner-bottom">
    </div>
</div>
<script>
    /*退出*/
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
