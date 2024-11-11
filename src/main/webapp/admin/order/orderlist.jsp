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
    搜索订单会员名：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off" >
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<table class="layui-table" id="test" lay-data="{height: 'full-25'}" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="ocreatetimeParse">
    {{# return util.toDateString(d.ocreatetime)}}
</script>
<script type="text/html" id="mnameParse">
    {{# return d.member.mname}}
</script>
<script type="text/html" id="isPayParse">
    {{#  if(d.ostatus === 0){ }}
    {{'未支付'}}
    {{#}else if(d.ostatus === 1){ }}
    {{'已支付'}}
    {{# } }}
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
            if(obj.event === 'del'){
                layer.confirm('真的删除该订单么', function(index){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/admin/order/del.html",
                        type:"post",
                        data:"oid="+data.oid,
                        success:function (data) {
                            if(data.status == 1){
                                obj.del();
                                layer.close(index);//关闭弹框
                                layer.msg("删除成功",{icon:6});
                            }else{
                                layer.msg("删除失败",{icon:5});
                            }
                        }
                    });
                });
            }
        });
        table.render({
            id:"ordertable",
            elem:"#test",
            url:'<%=request.getContextPath()%>/admin/orderlist.html',
            cols:[
                [
                    {field:'oid', width:80, sort: true, title:'订单ID'},
                    {field:'member_id', width:100,title:'用户',templet:'#mnameParse'},
                    {field:'ocreatetime',width:180,title:'预订时间',templet:'#ocreatetimeParse'},
                    {field:'classId', width:200,title:'班级'},
                    {field:'ostatus', width:180,title:'订单状态',templet:'#isPayParse'},
                    {width:178, align:'center', toolbar: '#barDemo',title:'操作'}
                ]
            ],
            page:true,
        });
        var $ = layui.$, active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('ordertable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        mname: demoReload.val()
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


