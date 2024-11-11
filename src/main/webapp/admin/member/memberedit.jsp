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
<form class="layui-form">
    <input type="hidden" name="mid" value="${member.mid}">
    <div class="layui-form-item">
        <label class="layui-form-label">会员名</label>
        <div class="layui-input-inline">
            <input type="text" name="mname" lay-verify="required" autocomplete="off" class="layui-input" value="${member.mname}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <input type="radio" name="mgender" value="0" title="女" <c:if test="${member.mgender == 0}">checked="checked"</c:if>>
            <input type="radio" name="mgender" value="1" title="男" <c:if test="${member.mgender == 1}">checked="checked"</c:if>>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份证号码</label>
        <div class="layui-input-inline">
            <input type="text" name="midno" lay-verify="identity" placeholder="" autocomplete="off" class="layui-input" value="${member.midno}">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="tel" name="mphone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${member.mphone}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="memail" lay-verify="email" autocomplete="off" class="layui-input" value="${member.memail}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
            <button type="reset" class="layui-btn layui-btn-primary" >重置</button>
        </div>
    </div>
</form>

<script>
    layui.use('form', function(){
        var form = layui.form
            ,$ = layui.jquery;
        //监听提交
        form.on('submit(formDemo)', function(data){
            $.ajax({
                url:'<%=request.getContextPath()%>/admin/member/doupdate.html',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (res) {
                    if(res.status == 1){
                        alert("更新成功");
                    }else{
                        alert("更新失败");
                    }
                    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                    parent.layer.close(index);  // 关闭layer
                    window.parent.location.reload(); //刷新父页面
                }
            });
            return false;//一定加上这个 不让form跳转提交
        });
    });
</script>
</body>
</html>
