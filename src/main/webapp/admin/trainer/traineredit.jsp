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
    <input type="hidden" name="eid" value="${trainer.eid}">
    <div class="layui-form-item">
        <label class="layui-form-label">教练姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="ename" lay-verify="required" autocomplete="off" class="layui-input" value="${trainer.ename}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <input type="radio" name="egender" value="0" title="女" <c:if test="${trainer.egender == 0}">checked="checked"</c:if>>
            <input type="radio" name="egender" value="1" title="男" <c:if test="${trainer.egender == 1}">checked="checked"</c:if>>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="tel" name="ephone" lay-verify="required|phone" autocomplete="off" class="layui-input" value="${trainer.ephone}">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">教练职务</label>
            <div class="layui-input-inline">
                <select name="epostId" lay-verify="required">
                    <option value="1" name="epostId" selected>教练</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">教练住址</label>
        <div class="layui-input-inline">
            <input type="text" name="eadd" lay-verify="required" autocomplete="off" class="layui-input" value="${trainer.eadd}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">入职日期</label>
        <div class="layui-input-inline">
            <input type="text" id="time" name="time" lay-verify="required"  class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">工作状态</label>
            <div class="layui-input-inline">
                <select name="estate" lay-verify="required">
                    <option value="1" <c:if test="${trainer.estate ==1}">selected</c:if>>在职</option>
                    <option value="0" <c:if test="${trainer.estate ==0}">selected</c:if>>离职</option>
                </select>
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
    //对laydate的默认时间 初始化CST字符串 转化为GMT在转化为date对象
    function dateToGMT(strDate){
        var dateStr=strDate.split(" ");
        var strGMT = dateStr[0]+" "+dateStr[1]+" "+dateStr[2]+" "+dateStr[5]+" "+dateStr[3]+" GMT+0800";
        var date = new Date(Date.parse(strGMT));
        return date;
    }
    layui.use(['form','laydate'], function(){
        var form = layui.form
            ,laydate = layui.laydate
            ,$ = layui.jquery;
        //监听提交
        form.on('submit(formDemo)', function(data){
            $.ajax({
                url:'<%=request.getContextPath()%>/admin/trainer/doaddorupdate.html',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (res) {
                    if(res.status == 1){
                        alert(res.msg);
                    }else{
                        alert(res.msg);
                    }
                    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                    parent.layer.close(index);  // 关闭layer
                    window.parent.location.reload(); //刷新父页面
                }
            });
            return false;//一定加上这个 不让form跳转提交
        });
        //日期选择器
        if(${!empty trainer.ehire}){//编辑
            laydate.render({
                elem:'#time',
                type:'datetime',
                value:dateToGMT('${trainer.ehire}')
            });
        }else{//添加
            laydate.render({
                elem:'#time',
                type:'datetime',
                value:new Date()
            });
        }
    });
</script>
</body>
</html>
