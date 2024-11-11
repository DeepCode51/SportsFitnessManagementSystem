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
    搜索留言内容：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off" >
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<%--<a href="<%=request.getContextPath()%>/admin/news/goaddorupdate.html" class="layui-btn"><i class="layui-icon">&#xe608;</i> 添加</a>--%>

<table class="layui-table" id="test" lay-data="{height: 'full-25'}" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
    {{#  if(d.reply!=null){       }}
            <a class="layui-btn layui-btn-xs" lay-event="delReply">删除回复</a>
    {{#  }else{  }}
            <a class="layui-btn layui-btn-xs" lay-event="reply">点击回复</a>
    {{#  }       }}
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delMsg">删除留言</a>
</script>
<script type="text/html" id="msgtimeParse">
    {{# return util.toDateString(d.msgDate)}}
</script>
<script type="text/html" id="replytimeParse">
    {{# if(d.reply!=null){           }}
    {{# return util.toDateString(d.reply.rdate);}else{     }}
    {{# return "";}}}
</script>
<script type="text/html" id="rcontentParse">
    {{# if(d.reply!=null){           }}
    {{# return d.reply.rcontent} }}
</script>
<script type="text/html" id="mnameParse">
    {{# return d.member.mname}}
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
//            if(obj.event === 'detail'){
////                layer.msg('ID：'+ data.cid + ' 的查看操作');
//                layer.open({
//                    type:2,
//                    title:'查看新闻详情',
//                    area:['800px','300px'],
//                    contenteditable:false,
//                    content:'/admin/newsinfo.html?nid='+data.nid,
//                });
//            }
            if(obj.event === 'delReply'){
                layer.confirm('真的删除该回复么', function(index){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/admin/message/delReply.html",
                        type:"post",
                        data:"rid="+data.reply.rid,
                        success:function (data) {
                            if(data.status == 1){
                                obj.tr[0].children[4].children[0].innerText="";
                                obj.tr[0].children[5].children[0].innerText="";
                                layer.close(index);//关闭弹框
                                layer.msg("删除成功",{icon:6});
                                window.location.reload();
                            }else{
                                layer.msg("删除失败",{icon:5});
                            }
                        }
                    });
                });
            }else if(obj.event === 'delMsg'){
                layer.confirm('该留言下的回复也将删除，真的删除该留言么？', function(index){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/admin/message/delMsg.html",
                        type:"post",
                        data:"msgid="+data.msgId,
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
            }
//            else if(obj.event === 'edit'){
//                layer.alert('编辑行：<br>'+ JSON.stringify(data))
//                layer.open({
//                    type:2,
//                    content:'/admin/goaddorupdate.html?cid='+data.cid,
//                });
//            }
            else if(obj.event === 'reply'){
                layer.open({
                    type:2,
                    title:"回复留言" ,
                    area:['500px','300px'],
                    content:"<%=request.getContextPath()%>/admin/message/goreply.html?msgid="+data.msgId
                });
            }
        });
        table.render({
            id:"messagetable",
            elem:"#test",
            url:'<%=request.getContextPath()%>/admin/messagelist.html',
            cols:[
                [
                    {field:'msgId', width:80, sort: true, title:'ID'},
                    {field:'mname', width:100,title:'用户',templet:'#mnameParse'},
                    {field:'msgContent', width:200,title:'留言内容'},
                    {field:'msgDate',width:180,title:'留言时间',templet:'#msgtimeParse'},
                    {field:'rcontent', width:200,title:'回复内容',templet:'#rcontentParse'},
                    {field:'rdate', width:180,title:'回复时间',templet:'#replytimeParse'},
                    {width:178, align:'center', toolbar: '#barDemo',title:'操作'}
                ]
            ],
            page:true,
        });
        var $ = layui.$, active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('messagetable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        msgcontent: demoReload.val()
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


