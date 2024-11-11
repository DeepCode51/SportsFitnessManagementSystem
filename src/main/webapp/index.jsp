<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>sport健身</title>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <!-- jQuery  -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- 样式文件 -->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen"/>

    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%--<script type="application/x-javascript">--%>
        <%--addEventListener("load", function () {--%>
            <%--setTimeout(hideURLbar, 0);--%>
        <%--}, false);--%>

        <%--function hideURLbar() {--%>
            <%--window.scrollTo(0, 1);--%>
        <%--}--%>
    <%--</script>--%>
    <!--header start here-->
    <%--<script src="js/responsiveslides.min.js"></script>--%>
    <%--<script>--%>
        <%--//轮播插件responsiveslides.min.js--%>
        <%--$(function () {--%>
            <%--$("#slider").responsiveSlides({--%>
                <%--auto: true,--%>
                <%--speed: 500,--%>
                <%--namespace: "callbacks",--%>
                <%--pager: false,--%>
                <%--nav: true,--%>
            <%--});--%>
        <%--});--%>
    <%--</script>--%>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%--<div class="banner" id="home">--%>
    <%--<div class="header">--%>
        <%--<div class="container">--%>
            <%--<div class="header-main">--%>
                <%--<div class="logo">--%>
                    <%--<h1><a href="index.html"><span class="logo-clr">S</span>tern </a></h1>--%>
                <%--</div>--%>
                <%--<div class="header-right">--%>
                    <%--<div class="top-nav">--%>
                        <%--<span class="menu"> <img src="images/icon.png" alt=""/></span>--%>
                        <%--<ul class="res">--%>
                            <%--<li><a class="active  scroll" href="<%=request.getContextPath()%>/index.html">首页</a></li>--%>
                            <%--<li><a class="scroll" href="<%=request.getContextPath()%>/about.html">关于我们</a></li>--%>
                            <%--<li><a class="scroll" href="<%=request.getContextPath()%>/news.html">新闻活动</a></li>--%>
                            <%--<li><a class="scroll" href="<%=request.getContextPath()%>/course.html">健身课程</a></li>--%>
                            <%--<li><a class="scroll" href="<%=request.getContextPath()%>/login.html">会员登录</a></li>--%>
                        <%--</ul>--%>
                        <%--<!-- menu 窗口缩小点击展示 -->--%>
                        <%--<script>--%>
                            <%--$("span.menu").click(function () {--%>
                                <%--$("ul.res").slideToggle(300, function () {});--%>
                            <%--});--%>
                        <%--</script>--%>
                        <%--<!-- /menu 窗口缩小点击展示 -->--%>
                    <%--</div>--%>
                    <%--<div class="clearfix"></div>--%>
                <%--</div>--%>
                <%--<div class="clearfix"></div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div class="banner-bottom">--%>

    <%--</div>--%>
<%--</div>--%>
<!--header end here-->
<!--banner info start here-->
<div class="banner-info">
    <div class="container">
        <div class="banner-info-main">
            <h3>健身资讯</h3>
            <hr style="height: 5px;background-color: #0ab2d2">
            <div class="col-md-6 bann-info-grid indexnews">
                <h4>活动<span class="ban-info-clr"> 比赛 </span></h4>
                <ul>
                    <c:forEach items="${newsHuodong}" var="huodong">
                        <li>
                            <c:forEach items="${newskinds}" var="kind">
                                <c:if test="${kind.nkid == huodong.nkId}">
                                    <a href="<%=request.getContextPath()%>/newsinfo.html?nid=${huodong.nid}">[${kind.nkname}]${huodong.ntitle}</a>
                                </c:if>
                            </c:forEach>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="col-md-6 bann-info-grid indexnews">
                <h4>健身房<span class="ban-info-clr"> 公告 </span></h4>
                <ul>
                    <c:forEach items="${newsGonggao}" var="gonggao">
                        <li>
                            <c:forEach items="${newskinds}" var="kind">
                                <c:if test="${kind.nkid == gonggao.nkId}">
                                    <a href="<%=request.getContextPath()%>/newsinfo.html?nid=${gonggao.nid}">[${kind.nkname}]${gonggao.ntitle}</a>
                                </c:if>
                            </c:forEach>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!--banner info end here-->
<!--健身教练 here  使用swipebox灯箱效果插件-->
<link rel="stylesheet" href="css/swipebox.css">
<script src="js/jquery.swipebox.min.js"></script>
<script type="text/javascript">
    jQuery(function ($) {
        $(".swipebox").swipebox();
    });
</script>
<div class="creative">
    <div class="container">
        <div class="creative-main">
            <h3>健身教练</h3>
            <div class="port-folio-bottom">
                <div id="portfoliolist">
                    <div class="col-md-3 portfolio-wrapper">
                        <a href="images/b-w1.jpg" class="b-link-stripe b-animate-go  swipebox" title="教练信息">
                            <img src="images/w1.jpg" alt="" class="img-responsive">
                            <div class="b-wrapper"><h2 class="b-animate b-from-left    b-delay03"><img
                                    src="images/Dumbbell.png" alt=""></h2>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3 portfolio-wrapper">
                        <a href="images/b-w2.jpg" class="b-link-stripe b-animate-go  swipebox" title="教练信息">
                            <img src="images/w2.jpg" alt="" class="img-responsive">
                            <div class="b-wrapper"><h2 class="b-animate b-from-left    b-delay03"><img
                                    src="images/Dumbbell.png" alt=""></h2>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3 portfolio-wrapper">
                        <a href="images/b-w3.jpg" class="b-link-stripe b-animate-go  swipebox" title="教练信息">
                            <img src="images/w3.jpg" alt="" class="img-responsive">
                            <div class="b-wrapper"><h2 class="b-animate b-from-left    b-delay03"><img
                                    src="images/Dumbbell.png" alt=""></h2>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-3 portfolio-wrapper">
                        <a href="images/b-w4.jpg" class="b-link-stripe b-animate-go  swipebox" title="教练信息">
                            <img src="images/w4.jpg" alt="" class="img-responsive">
                            <div class="b-wrapper"><h2 class="b-animate b-from-left    b-delay03"><img
                                    src="images/Dumbbell.png" alt=""></h2>
                            </div>
                        </a>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--健身教练 end here-->
<!--服务 start here-->
<div class="services" id="service">
    <div class="container">
        <div class="services-main">
            <div class="services-bottom">
                <div class="col-md-6 services-gridleft">
                    <h4>sport健身俱乐部</h4>
                    <h5>身体和灵魂总有一个要在路上</h5>
                    <p></p>
                </div>
                <div class="col-md-6 services-gridright">
                    <h4>这就是我们！</h4>
                    <ul>
                        <li><a>用最热情的态度,最真挚的微笑迎接每一位顾客</a></li>
                        <li><a>想顾客所想,给顾客所需</a></li>
                        <li><a>保持最佳的工作状态,最旺盛的精力,最蓬勃的生机,是进步的最大保障.</a></li>
                        <li><a>外塑形象，内修品性，细致入微，精益求精，对所有顾客一视同仁</a></li>
                        <li><a>用最专业的技术,最卓越的服务赢得更好的发展未来</a></li>

                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!--服务 end here-->
<!-- FlexSlider -->
<script defer src="js/jquery.flexslider.js"></script>
<script type="text/javascript">
//        $(function () {
//            SyntaxHighlighter.all();
//        });
//        $(window).load(function () {
//            $('.flexslider').flexslider({
//                animation: "slide",
//                start: function (slider) {
//                    $('body').removeClass('loading');
//                }
//            });
//        });
</script>
<!-- FlexSlider -->
<!--clients end here-->
<!--联系我们 start here-->
<div class="contact" id="contact">
    <div class="container">
        <div class="contact-main">
            <h3>联系我们</h3>
            <div class="col-md-6 contact-left">
                <div class="ftr-left-gd1">
                    <span class="glyphicon glyphicon-earphone" aria-hidden="true"></span>
                    <p>+13022500400</p>
                </div>
                <div class="ftr-left-gd1">
                    <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                    <p><a href="#">1347845688@qq.com</a></p>
                </div>
                <div class="ftr-left-gd1">
                    <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                    <p>源码码头</p>
                </div>
            </div>
            <div class="col-md-6 contact-right">
                <input type="hidden" name="mid" id="mid" value="${member.mid}"/>
                <input type="text" name="mname" id="mname" class="name" placeholder="你的名字" <c:if test="${!empty member}">value="${member.mname}" disabled</c:if>>
                <input type="text" name="memail" id="memail" placeholder="邮箱" <c:if test="${!empty member}">value="${member.memail}" disabled</c:if>>
                <textarea placeholder="留言" id="msgcontent" name="msgcontent"></textarea>
                <div class="send">
                    <input type="submit" value="发送" id="sendMsg" >
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!--联系我们 end here-->
<!--footer start here-->
<jsp:include page="footer.jsp"></jsp:include>
<!--footer end here-->
    <script type="text/javascript">
        $(document).ready(function () {
//            $().UItoTop({easingType: 'easeOutQuart'});
            $("#sendMsg").on('click',function () {
                $.ajax({
                    url:'<%=request.getContextPath()%>/member/sendmessage.html',
                    data:'msgcontent='+$("#msgcontent").val()+"&mid="+$("#mid").val(),
                    type:'post',
                    success:function(data){
                        if(data=="logout") {
                            alert("请登录后留言");
                            window.location.href = "<%=request.getContextPath()%>/login.html";
                        }else {
                            alert(data.msg);
                            $("#msgcontent").val("");
                        }
                    }
                });
                return false;
            });
        });
    </script>
</body>
</html>