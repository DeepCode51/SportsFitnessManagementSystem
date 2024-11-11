<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<div class="demoTable">
    搜索新闻标题：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off" >
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<a href="<%=request.getContextPath()%>/admin/news/goaddorupdate.html" class="layui-btn"><i class="layui-icon">&#xe608;</i> 添加</a>

<table class="layui-table" id="test" lay-data="{height: 'full-25'}" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit" href="<%=request.getContextPath()%>/admin/news/goaddorupdate.html?nid={{d.nid}}">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="kindParse">
    <c:forEach items="${newskinds}" var="kind">
        {{# if(d.nkId!=null&&d.nkId === ${kind.nkid}){  }}
        ${kind.nkname}
        {{# } }}
    </c:forEach>
</script>
<script type="text/html" id="timeParse">
    {{# return util.toDateString(d.ncreatetime)}}
</script>
<script>
    var util;
    layui.use(['table','util'], function(){
        var table = layui.table;
        util = layui.util;
        //监听表格复选框选择
        table.on('checkbox(demo)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
//                layer.msg('ID：'+ data.cid + ' 的查看操作');
                layer.open({
                    type:2,
                    title:'查看新闻详情',
                    area:['800px','300px'],
                    contenteditable:false,
                    content:'<%=request.getContextPath()%>/admin/newsinfo.html?nid='+data.nid,
                });
            } else if(obj.event === 'del'){
                layer.confirm('真的删除该新闻么', function(index){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/admin/news/del.html",
                        type:"post",
                        data:"nid="+data.nid,
                        success:function (data) {
                            if(data.status == 1){
                                obj.del();//删除对应行（tr）的DOM结构，并更新缓存
                                layer.close(index);//关闭弹框
                                layer.msg("删除成功",{icon:6});
                            }else{
                                layer.msg("删除失败",{icon:5});
                            }
                        }
                    });
                });
            } else if(obj.event === 'edit'){
//                layer.alert('编辑行：<br>'+ JSON.stringify(data))
//                layer.open({
//                    type:2,
//                    content:'/admin/goaddorupdate.html?cid='+data.cid,
//                });
            }
        });
        table.render({
            id:"newstable",
            elem:"#test",
            url:'<%=request.getContextPath()%>/admin/newslist.html',
            cols:[
                [
                    {field:'nid', width:80, sort: true, title:'新闻ID'},
                    {field:'ntitle', width:100,title:'新闻标题'},
                    {field:'ncontent', width:300,title:'新闻内容'},
                    {field:'nkId', width:90,title:'新闻类型',templet:'#kindParse'},
                    {field:'ncreatetime', width:180,title:'发布时间',templet:'#timeParse'},
                    {width:178, align:'center', toolbar: '#barDemo',title:'操作'}
                ]
            ],
            page:true,
        });
        var $ = layui.$, active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('newstable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        ntitle: demoReload.val()
                    }
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
</body>
</html>


