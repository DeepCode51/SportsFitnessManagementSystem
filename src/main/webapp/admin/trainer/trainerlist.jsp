<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../layui/css/layui.css" media="all">
    <script src="<%=request.getContextPath()%>/js/jquery-1.11.0.min.js"></script>
    <script src="../layui/layui.js" charset="utf-8"></script>

    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="demoTable">
    搜索教练名：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<a class="layui-btn" id="addBnt"><i class="layui-icon">&#xe608;</i> 添加</a>
<table class="layui-table" id="test" lay-data="{height: 'full-25'}" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="genderParse">
    {{# if(d.egender == 0){  }}
    {{'女'}}
    {{# }else{  }}
    {{'男'}}
    {{# }   }}
</script>
<script type="text/html" id="postParse">
        {{# if(d.epostId === 1){ }}
        {{'教练'}}
        {{# } }}
</script>
<script type="text/html" id="isHire">
    {{# if(d.estate === 1){ }}
    {{'在职'}}
    {{# }else{ }}
    {{'离职'}}
    {{# } }}
</script>
<script type="text/html" id="timeParse">
    {{# return util.toDateString(d.ehire)}}
</script>
<script>
    var util;
    layui.use(['table','util'], function () {
        var table = layui.table;
        util = layui.util;
        //监听表格复选框选择
        table.on('checkbox(demo)', function (obj) {
            console.log(obj)
        });
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.msg('ID：' + data.eid + ' 的查看操作');
            } else if (obj.event === 'del') {
                layer.confirm('真的删除该教练么', function (index) {
                    $.ajax({
                        url: "<%=request.getContextPath()%>/admin/trainer/del.html",
                        type: "post",
                        data: "eid=" + data.eid,
                        success: function (data) {
                            if (data.status == 1) {
                                obj.del();//删除对应行（tr）的DOM结构，并更新缓存
                                layer.close(index);//关闭弹框
                                layer.msg("删除成功", {icon: 6});
                            } else {
                                layer.msg("删除失败", {icon: 5});
                            }
                        }
                    });


                });
            } else if (obj.event === 'edit') {
                layer.open({
                    type:2,
                    title:"修改教练信息" ,
                    area:['500px','500px'],
                    content:"<%=request.getContextPath()%>/admin/trainer/goaddorupdate.html?eid="+data.eid
                });
            }
        });
        table.render({
            id: "trainertable",
            elem: "#test",
            url: '<%=request.getContextPath()%>/admin/trainerlist.html',
            cols: [
                [
                    {field: 'eid', width:100, sort: true, fixed: true, title: '教练工号'},
                    {field: 'ename', width: 90, title: '教练姓名'},
                    {field: 'egender', width: 90, sort: true, title: '性别', templet: '#genderParse'},
                    {field: 'ephone', width: 160, title: '手机号'},
                    {field: 'epostId', width: 90, title: '职务', templet: '#postParse'},
                    {field: 'eadd', width: 200, title: '教练住址'},
                    {field: 'ehire', width: 178, title: '入职日期',templet:'#timeParse'},
                    {field: 'estate', width: 90, title: '工作状态', templet: '#isHire'},
                    {width: 178, align: 'center', toolbar: '#barDemo'}
                ]
            ],
            page: true,
        });
        var $ = layui.$, active = {
            reload: function () {
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('trainertable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
//                        key: {
                        ename: demoReload.val()
//                        }
                    }
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        //添加
        $("#addBnt").on('click',function () {
            layer.open({
                type:2,
                title:"添加教练" ,
                area:['500px','500px'],
                content:"<%=request.getContextPath()%>/admin/trainer/goaddorupdate.html"
            });
        });
    });

</script>

</body>
</html>
