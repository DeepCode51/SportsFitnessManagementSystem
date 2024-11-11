<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>sport健身</title>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <!-- jQuery  -->
    <script src="js/jquery-1.11.0.min.js"></script>
    <!-- 样式文件 -->
    <link href="css/courseinfoStyle.css" rel="stylesheet" type="text/css" media="all"/>
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen"/>

    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- 文本内容  start here-->
<div class="container col-sm-12" style="background-color: #0f0f0f">
    <div class="col-lg-6"><img src="${course.cpic}"></div>
    <div class="col-md-6"><p style="margin-top: 50px; text-indent: 2em;">${course.cdesc}</p></div>
    <c:if test="${!empty classes}">
        <div class="col-md-12" style="color: #ffffff">
        <h2>
            预订课程
        </h2>
        <table class="table" style="color: #ffffff">
            <tr>
                <th>班级编号</th>
                <th>教练</th>
                <th>开课时间</th>
                <th>课时</th>
                <th>课程总价</th>
                <th>已预订/总容量</th>
                <th></th>
            </tr>
            <c:forEach items="${classes}" var="clazz">
                <tr>
                    <td>${clazz.classid}</td>
                    <td>
                        <c:forEach items="${trainers}" var="trainer">
                            <c:if test="${clazz.emplId == trainer.eid}">
                                ${trainer.ename}
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>${clazz.classtime}</td>
                    <td>${course.ctime}</td>
                    <td>${course.cprice}</td>
                    <th>${clazz.haveOrder}/${clazz.classvolume}</th>
                    <td> <input type="button" value="预订课程" class="orderCourse"></td>
                </tr>
            </c:forEach>
        </table>
        </div>
    </c:if>
</div>
<!-- 文本内容  end here-->
<jsp:include page="footer.jsp"></jsp:include>
<script>
    $("input.orderCourse").on("click",function () {
        var classId = $(this).parent().parent().find("td")[0].innerHTML;
       $.ajax({
           url:'<%=request.getContextPath()%>/class/order.html',
           data:'classId='+classId,
           success:function (data) {
               if(data=="logout") {
                   alert("请登录后预订！");
                   window.location.href = "<%=request.getContextPath()%>/login.html";
               }else{
                    alert(data.msg);
               }
           }
       }); 
    });
</script>
</body>
</html>