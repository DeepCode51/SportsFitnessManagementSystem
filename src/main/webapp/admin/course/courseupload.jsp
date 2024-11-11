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
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px">
    <legend>上传课表</legend>
</fieldset>
<div class="layui-upload">
    <button type="button" class="layui-btn" id="test3"><i class="layui-icon"></i>上传文件</button>
    <div class="layui-upload-list">
        <table class="layui-table">
            <thead>
                <tr><th>文件名</th></tr>
            </thead>
            <tbody>
            <tr><td><a  id="nameTd" href="http://www.csbishe.cn:8009/SternGym/sterngymimages/${sheetsrc}" target="_blank">${sheetsrc}</a></td></tr>
            </tbody>
        </table>
    </div>
</div>
<script>
    layui.use('upload',function () {
        var $ = layui.jquery
            ,uploadd = layui.upload;
        uploadd.render({
            elem:'#test3',
            url:'<%=request.getContextPath()%>/admin/coursesheet.html',
            accept:'file',
            exts:'pdf',
            done:function(res){
                if(res.code == 0){//上传成功
                    $("#nameTd").attr("href","http://www.csbishe.cn:8009/SternGym/sterngymimages/"+res.data.src);
                    $("#nameTd")[0].innerHTML = res.data.src;
                    layer.msg('上传成功',{icon:6});
                }else{
                    return layer.msg('上传失败');
                }
            }
        });
    })
</script>
</body>
</html>
