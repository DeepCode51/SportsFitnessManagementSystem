<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>sport健身</title>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <!-- jQuery  -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <!-- 样式文件 -->
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/news.css" type="text/css">
    <%--Bootstrap分页插件--%>
    <script src="js/bootstrap-paginator.js"></script>
    <!--width = device-width：宽度等于当前设备的宽度
    initial-scale：初始的缩放比例（默认设置为1.0，即代表不缩放）
    user-scalable：用户是否可以手动缩放（默认设置为no，因为我们不希望用户放大缩小页面）
    -->
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!--header start here-->
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<%--container start here--%>
<div class="container">
    <div class="col-md-12">
        <div class="alert alert-info">
            <a href="<%=request.getContextPath()%>/index.html"><b>sport健身俱乐部</b></a>
            &gt;
            <a href="<%=request.getContextPath()%>/news.html"><b>新闻活动</b></a>
        </div>
    </div>

    <div class="row-fluid col-md-8">
        <%--新闻列表 start--%>
        <div class="span12 newstable">
            <table class="table table-hover table-condensed">
                <thead>
                <tr>
                    <th>
                        标题
                    </th>
                    <th class="text-right">
                        日期
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${news}" var="nn">
                    <tr>
                        <td class="text-left">
                            <c:forEach items="${newskinds}" var="kind">
                                <c:if test="${kind.nkid == nn.nkId}">
                                    <a href="<%=request.getContextPath()%>/newsinfo.html?nid=${nn.nid}">[${kind.nkname}]${nn.ntitle}</a>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td class="text-right">
                            <fmt:formatDate value="${nn.ncreatetime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <%--新闻列表 end--%>
            <%--分页组件 start--%>
        <div class="col-md-8">
            <ul id="bp-3-element-test"></ul>
        </div>
        <%--分页组件 end--%>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
    /*ajax 分页成功之后 进行日期转换*/
    function formatDate(now) {
        var yy = now.getFullYear();      //年
        var mm = now.getMonth() + 1;     //月
        var dd = now.getDate();          //日
        var hh = now.getHours();         //时
        var ii = now.getMinutes();       //分
        var ss = now.getSeconds();       //秒
        var clock = yy + "-";
        if (mm < 10) clock += "0";
        clock += mm + "-";
        if (dd < 10) clock += "0";
        clock += dd + " ";
        if (hh < 10) clock += "0";
        clock += hh + ":";
        if (ii < 10) clock += "0";
        clock += ii + ":";
        if (ss < 10) clock += "0";
        clock += ss;
       return clock;     //获取当前日期
    }
    /*分页组件以及  ajax 分页 start*/
    var $page = $("#bp-3-element-test");
    var options = {
        bootstrapMajorVersion:3,
        currentPage:${currentPage},
        numberOfPages:5,
        totalPages:${totalPages == 0?1:totalPages},
        onPageClicked:function (event,originalEvent,type,page) {
            $.ajax({
                url:'<%=request.getContextPath()%>/newsajax.html',
                type:"post",
                data:"page="+page,
                success:function (data) {
                    $("tbody").empty();
                    $.each(data.news,function (index,item) {
                        $("tbody").append("<tr>" +
                            "<td class='text-left'><a href='/newsinfo.html?nid="+[item.nid]+"'>["+data.newskinds[item.nkId-1].nkname+"]"+item.ntitle+"</a></td>" +
                            "<td class='text-right'>"+formatDate(new Date(item.ncreatetime))+"</td>" +
                            "</tr>");
                    })
                }
            });
        }
    };
    $page.bootstrapPaginator(options);
    /*分页组件以及  ajax 分页  end*/
</script>
</html>
