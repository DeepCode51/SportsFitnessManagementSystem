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
    <link rel="stylesheet" href="css/newsinfo.css" type="text/css">
    <!--width = device-width：宽度等于当前设备的宽度
    initial-scale：初始的缩放比例（默认设置为1.0，即代表不缩放）
    user-scalable：用户是否可以手动缩放（默认设置为no，因为我们不希望用户放大缩小页面）
    -->
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style>
        .newscontent {
            background-color:#f5fafe;
            border:1px solid #becde5;
            border-radius: 4px;
            width: 100%;
            margin-bottom: 20px;
        }
        @media (max-width: 1440px){
            .newscontent {
                min-height: 700px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container">
    <div class="col-md-12">
        <div class="alert alert-info">
            <a href="<%=request.getContextPath()%>/index.html"><b>sport健身俱乐部</b></a>
            &gt;
            <a href="<%=request.getContextPath()%>/news.html"><b>新闻活动</b></a>
            &gt;
            正文
        </div>
    </div>
    <div class="row-fluid col-md-12" >
        <div class="col-md-12 newscontent">
            <div class="col-md-12 show-header">
                <h2>
                    <c:forEach items="${newskinds}" var="kind">
                        <c:if test="${kind.nkid == news.nkId}">
                            [${kind.nkname}]
                        </c:if>
                    </c:forEach>${news.ntitle}
                </h2>
                <p> <fmt:formatDate value="${news.ncreatetime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></p>
            </div>
            <div class="col-md-12 show-body">
                ${news.ncontent}
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</body>
</html>
