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
    <style type="text/css">
        .table>tbody>tr>td{
            border:0px;
        }
        .receive {
            position:relative;
            width:150px;
            /*height:35px;*/
            background:#1b6aaa;
            border-radius:5px; /* 圆角 */
            /*margin:0px auto 0;*/
        }

        .receive>.arrow {
            position:absolute;
            top:4px;
            right:150px; /* 圆角的位置需要细心调试哦 */
            width:0;
            height:0;
            font-size:0;
            border:solid 6px;
            border-color:transparent #1b6aaa transparent transparent;
        }
        .send {
            position:relative;
            width:150px;
            /*height:35px;*/
            background:#F8C301;
            border-radius:5px; /* 圆角 */
            /*margin:0px auto 0;*/
        }

        .send>.arrow {
            position:absolute;
            top:4px;
            right:-12px; /* 圆角的位置需要细心调试哦 */
            width:0;
            height:0;
            font-size:0;
            border:solid 6px;
            border-color:transparent transparent transparent #F8C301;
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
            查看留言
        </div>
    </div>
    <div class="row-fluid col-md-8">
        <div class="span12 newstable">
            <table class="table table-hover table-condensed">
                <%--<thead>--%>
                <%--<tr>--%>

                    <%--<th>--%>
                        <%--回复--%>
                    <%--</th>--%>
                    <%--<th>--%>
                        <%--回复日期--%>
                    <%--</th>--%>
                    <%--<th>--%>
                        <%--留言--%>
                    <%--</th>--%>
                    <%--<th>--%>
                        <%--留言日期--%>
                    <%--</th>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <tbody>
                <c:forEach items="${messages}" var="message">
                    <tr>
                        <td width="202px"></td>
                        <td width="162px"></td>
                        <td>
                            <div class="send">
                                    ${message.msgContent}
                                <div class="arrow"></div>
                            </div>
                        </td>
                        <td style="font-size: 10px; color: #aab0a6">
                            <fmt:formatDate value="${message.msgDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                        </td>
                    </tr>

                        <tr>
                            <td>
                    <c:if test="${!empty message.reply}">
                                <div class="receive">
                                        ${message.reply.rcontent}
                                    <div class="arrow"></div>
                                </div>
                    </c:if>
                            </td>
                            <td style="font-size: 10px; color: #aab0a6">
                                <fmt:formatDate value="${message.reply.rdate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>

                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
