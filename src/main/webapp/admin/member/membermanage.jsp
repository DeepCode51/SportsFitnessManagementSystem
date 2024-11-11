<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
<%--复选框工具栏 start--%>
<%--<div class="layui-btn-group demoTable">--%>
    <%--<button class="layui-btn" data-type="getCheckData">获取选中行数据</button>--%>
    <%--<button class="layui-btn" data-type="getCheckLength">获取选中数目</button>--%>
    <%--<button class="layui-btn" data-type="isAll">验证是否全选</button>--%>
<%--</div>--%>
<%--复选框工具栏  end--%>
<div class="demoTable">
    搜索会员名：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<table class="layui-table" id="test" lay-data="{height: 'full-25'}" lay-filter="demo"></table>
<script type="text/html" id="barDemo">
    <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="genderParse">
    {{# if(d.mgender == 0){  }}
            {{'女'}}
    {{# }else{  }}
            {{'男'}}
    {{# }   }}
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //监听表格复选框选择
        table.on('checkbox(demo)', function(obj){
            console.log(obj)
        });
        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.msg('ID：'+ data.mid + ' 的查看操作');
            } else if(obj.event === 'del'){
                layer.confirm('真的删除该会员么', function(index){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/admin/del.html",
                        type:"post",
                        data:"mid="+data.mid,
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
                layer.open({
                    type:2,
                   title:"修改会员信息" ,
                    area:['500px','500px'],
                    content:"<%=request.getContextPath()%>/admin/member/goupdate.html?mid="+data.mid
                });
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
            id:"membertable",
            elem:"#test",
            url:'<%=request.getContextPath()%>/admin/userlist.html',
            cols:[
                [
//                    {type:'checkbox', fixed: 'left'},//显示复选框
                    {field:'mid', width:80, sort: true, fixed: true,title:'会员ID'},
                    {field:'mname', width:80,title:'会员名'},
                    {field:'mgender', width:80, sort: true,title:'性别',templet:'#genderParse'},
                    {field:'midno', width:200,title:'身份证号码'},
                    {field:'mphone', width:160,title:'手机号'},
                    {field:'memail', width:178,title:'邮箱'},
                    {fixed: 'right', width:178, align:'center', toolbar: '#barDemo'}
                ]
            ],
            page:true,
        });
        var $ = layui.$, active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('membertable', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
//                        key: {
                            mname: demoReload.val()
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
