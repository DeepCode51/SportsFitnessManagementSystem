<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>健身课程</title>
    <!-- 样式文件 -->
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css" media="all">
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/courseStyle.css" type="text/css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
    <!--js文件-->
    <!-- jQuery  -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <%--Bootstrap分页插件--%>
    <script src="js/bootstrap-paginator.js"></script>
    <!--width = device-width：宽度等于当前设备的宽度
    initial-scale：初始的缩放比例（默认设置为1.0，即代表不缩放）
    user-scalable：用户是否可以手动缩放（默认设置为no，因为我们不希望用户放大缩小页面）
    -->
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%--container start here--%>
<div class="container">
    <%--轮播图  start--%>
    <div class="container-fluid">
        <div class="carousel slide" id="carousel-485077">
            <ol class="carousel-indicators">
                <li data-slide-to="0" data-target="#carousel-485077">
                </li>
                <li data-slide-to="1" data-target="#carousel-485077">
                </li>
                <li data-slide-to="2" data-target="#carousel-485077" class="active">
                </li>
            </ol>
            <div class="carousel-inner">
                <div class="item">
                    <img alt="" src="images/1.jpg"/>
                </div>
                <div class="item">
                    <img alt="" src="images/2.jpg"/>
                </div>
                <div class="item active">
                    <img alt="" src="images/3.jpg"/>
                </div>
            </div>
            <a data-slide="prev" href="#carousel-485077" class="left carousel-control">‹</a> <a data-slide="next"
                                                                                                href="#carousel-485077"
                                                                                                class="right carousel-control">›</a>
        </div>
    </div>
    <%--轮播图  end--%>

    <div class="col-md-12 span121" style="background-color: #FFFFFF">
        <div class="row-fluid">
            <div class="span12">
                <div class="tabbable" id="tabs-364153">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#panel-377689" data-toggle="tab">课程简介</a>
                        </li>
                        <li>
                            <a href="#panel-812368" data-toggle="tab">课程表</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="panel-377689">
                            <p>
                                <%--搜索框 start--%>
                            <form class="form-search" id="searchForm">
                                <span style="float: left;margin-top: 11px;margin-right: 5px">课程种类</span>
                                <ul id="main_ul1">
                                    <li class="Select_li1">
                                        <span id="first">${empty cate?'全部':cate}</span>
                                        <ul class="son_ul1">
                                            <li><span>全部</span></li>
                                            <c:forEach items="${coursecategories}" var="cate">
                                                <li><span>${cate.cateName}</span></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </ul>
                                <span style="float: left;margin-top: 11px;margin-right: 5px">功能</span>
                                <ul id="main_ul2">
                                    <li class="Select_li2">
                                        <span id="second">${empty func?'全部':func}</span>
                                        <ul class="son_ul2">
                                            <li><span>全部</span></li>
                                            <c:forEach items="${coursefunctions}" var="func">
                                                <li><span>${func.fname}</span></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </ul>
                                <button type="button" class="btn" id="subBtn" style="margin-top: 5px">查找</button>
                            </form>
                            <%--搜索框 end--%>
                            <%--课程展示 start--%>
                            <div class="col-md-6">
                                <ul class="thumbnails">
                                    <c:forEach items="${courses}" begin="0" end="2" var="course">
                                        <li class="span4">
                                            <div class="thumbnail">
                                                <img alt="d" src="${course.cpic}" />
                                                <div class="caption">
                                                    <h3>
                                                        ${course.cname}
                                                    </h3>
                                                    <%--<p>--%>
                                                        <%--${course.cdesc}--%>
                                                    <%--</p>--%>
                                                    <p>
                                                        <a class="btn btn-primary" href="<%=request.getContextPath()%>/courseinfo.html?cid=${course.cid}">查看</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                    <%--<li class="span4">--%>
                                        <%--<div class="thumbnail">--%>
                                            <%--<img alt="300x200" src="images/city.jpg" />--%>
                                            <%--<div class="caption">--%>
                                                <%--<h3>--%>
                                                    <%--改进型哈佛结构--%>
                                                <%--</h3>--%>
                                                <%--<p>--%>
                                                    <%--改进型的哈佛结构具有一条独立的地址总线和一条独立的数据总线，两条总线由程序存储器和数据存储器分时复用，使结构更紧凑。--%>
                                                <%--</p>--%>
                                                <%--<p>--%>
                                                    <%--<a class="btn btn-primary" href="#">查看</a>--%>
                                                <%--</p>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</li>--%>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="thumbnails">
                                    <c:forEach items="${courses}" begin="3" end="5" var="course">
                                        <li class="span4">
                                            <div class="thumbnail">
                                                <img alt="d" src="${course.cpic}" />
                                                <div class="caption">
                                                    <h3>
                                                            ${course.cname}
                                                    </h3>
                                                    <%--<p>--%>
                                                            <%--${course.cdesc}--%>
                                                    <%--</p>--%>
                                                    <p>
                                                        <a class="btn btn-primary" href="<%=request.getContextPath()%>/courseinfo.html?cid=${course.cid}">查看</a>
                                                    </p>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <%--课程展示 end--%>
                            <%--分页 start--%>
                                <div class="col-md-5 col-md-offset-4">
                                    <ul id="bp-3-element-test"></ul>
                                </div>
                            <%--分页 end--%>
                            </p>
                        </div>
                        <div class="tab-pane" id="panel-812368">
                            <p>
                                <a class="btn btn-primary" href="http://www.csbishe.cn:8009/SternGym/sterngymimages/${sheetsrc}" target="_blank">点击查看课表</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script>
    $(document).ready(function () {
        $('.son_ul1').hide();
        $('.son_ul2').hide();//初始ul隐藏
        $('.Select_li1>span').click(function () {
            $(this).parent().find('ul.son_ul1').slideDown();
            $(this).parent().find('ul.son_ul1').children().hover(function(){
                $(this).css("background-color","#0ab2d2")
            },function(){
                $(this).css("background-color","")
            });//找到ul.son_ul显示
                $(this).parent().hover(function () {},
                    function () {
                        $(this).parent().find("ul.son_ul1").slideUp();
                    }
                );
        });
        $('.Select_li2>span').click(function () {
            $(this).parent().find('ul.son_ul2').slideDown();  //找到ul.son_ul显示
            $(this).parent().hover(function () {},
                function () {
                    $(this).parent().find("ul.son_ul2").slideUp();
                }
            );
        });
        $('ul.son_ul1>li').click(function () {
            $(this).parents('li').find('#first').html($(this).html());
            $(this).parents('li').find('ul').slideUp();
        });
        $('ul.son_ul2>li').click(function () {
            $(this).parents('li').find('#second').html($(this).html());
            $(this).parents('li').find('ul').slideUp();
        });
        var $page = $("#bp-3-element-test");
        var options = {
            bootstrapMajorVersion:3,
            currentPage:${currentPage},
            numberOfPages:5,
            totalPages:${totalPages == 0?1:totalPages},
            onPageClicked:function (event,originalEvent,type,page) {
                location.href = "<%=request.getContextPath()%>/course.html?page="+page+"&cate="+$("#first")[0].innerText+"&func="+$("#second")[0].innerText;
            }
        };
        $page.bootstrapPaginator(options);
        $("#subBtn").click(function () {
            var cate = $("#first")[0].innerText;
            var func = $("#second")[0].innerText;
            var $form = $("#searchForm");
            $form.attr("method","post");
            $form.attr("action","/course.html?page=1&cate="+cate+"&func="+func);
            $form.submit();
        });
    });
</script>
</body>
</html>

