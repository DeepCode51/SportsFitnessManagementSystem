<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
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
    搜索课程名：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off" >
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
 <a href="<%=request.getContextPath()%>/admin/goaddorupdate.html" class="layui-btn"><i class="layui-icon">&#xe608;</i> 添加</a>

<table class="layui-table" id="test" lay-data="{height: 'full-25'}" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit" href="<%=request.getContextPath()%>/admin/goaddorupdate.html?cid={{d.cid}}">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="traineridParse">
    <c:forEach items="${employees}" var="em">
        {{# if(d.trainerId!=null&&d.trainerId === ${em.eid}){  }}
            ${em.ename}
        {{# } }}
    </c:forEach>
</script>
<script type="text/html" id="categoryParse">
    <c:forEach items="${coursecategories}" var="cate">
        {{# if(d.ccateId!=null&&d.ccateId === ${cate.cateId}){  }}
            ${cate.cateName}
        {{# } }}
    </c:forEach>
</script>
<script type="text/html" id="functionParse">
    <c:forEach items="${coursefunctions}" var="fun">
        {{# if(d.cfunctionId!=null&&d.cfunctionId === ${fun.fid}){  }}
        ${fun.fname}
        {{# } }}
    </c:forEach>
</script>
<script type="text/html" id="timeParse">
    {{# return util.toDateString(d.ccreatetime)}}
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
                    title:'查看课程信息',
                    area:['800px','300px'],
                    content:'<%=request.getContextPath()%>/admin/courseinfo.html?cid='+data.cid,
                });
            } else if(obj.event === 'del'){
                layer.confirm('真的删除该课程么', function(index){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/admin/course/del.html",
                        type:"post",
                        data:"cid="+data.cid,
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
        /**
         * 复选框工具栏
         */
//        var $ = layui.$, active = {
//            getCheckData: function(){ //获取选中数据
//                var checkStatus = table.checkStatus('test')
//                    ,data = checkStatus.data;
//                layer.alert(JSON.stringify(data));
//            }
//            ,getCheckLength: function(){ //获取选中数目
//                var checkStatus = table.checkStatus('test')
//                    ,data = checkStatus.data;
//                layer.msg('选中了：'+ data.length + ' 个');
//            }
//            ,isAll: function(){ //验证是否全选
//                var checkStatus = table.checkStatus('test');
//                layer.msg(checkStatus.isAll ? '全选': '未全选')
//            }
//        };
//
//        $('.demoTable .layui-btn').on('click', function(){
//            var type = $(this).data('type');
//            active[type] ? active[type].call(this) : '';
//        });
        table.render({
            id:"coursetable",
            elem:"#test",
            url:'<%=request.getContextPath()%>/admin/courselist.html',
            cols:[
                [
//                    {type:'checkbox', fixed: 'left'},//显示复选框
                    {field:'cid', width:80, sort: true, title:'课程ID'},
                    {field:'cname', width:90,title:'课程名称'},
                    {field:'trainerId', width:90,title:'教练名称',templet:'#traineridParse'},
                    {field:'ctime', width:60,title:'课时'},
                    {field:'cfunctionId', width:90,title:'课程功能',templet:'#functionParse'},
                    {field:'ccateId', width:90,title:'课程类型',templet:'#categoryParse'},
                    {field: 'cpic', width:90, title:'课程图片',templet:'<div><img src="{{ d.cpic}}"/></div>',style:'height:48px;width:48px;line-height:48px!important;'},
                    {field:'ccreatetime', width:180,title:'创建时间',templet:'#timeParse'},
                    {field:'cprice', width:60,title:'价格'},
                    {field:'cdesc', width:200,title:'描述'},
                    {width:178, align:'center', toolbar: '#barDemo',title:'操作'}
                ]
            ],
            page:true,
        });
        var $ = layui.$, active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('coursetable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
//                        key: {
                        cname: demoReload.val()
//                        }
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

