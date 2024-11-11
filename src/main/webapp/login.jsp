<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>sport健身</title>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

	<!-- jQuery  -->
	<script src="js/jquery-1.11.0.min.js"></script>
	<script src="js/jquery.form.js"></script>
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="js/html5shiv.min.js"></script>
	<script src="js/respond.min.js"></script>
	<![endif]-->


	<!-- 样式文件 -->
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all">

	<!--  fontawesome -->
	<link rel="stylesheet" href="font-awesome/4.2.0/css/font-awesome.min.css" />
	<!-- text fonts -->
	<link rel="stylesheet" href="fonts/fonts.googleapis.com.css" />
	<!-- ace styles -->
	<link rel="stylesheet" href="css/ace.min.css" />
	<!--[if lte IE 9]>
	<link rel="stylesheet" href="css/ace-part2.min.css" />
	<![endif]-->
	<link rel="stylesheet" href="css/ace-rtl.min.css" />
	<!--[if lte IE 9]>
	<link rel="stylesheet" href="css/ace-ie.min.css" />
	<![endif]-->
	<link href="css/loginStyle.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<!-- middle start-->
<div class="login-layout">
<div class="main-container">
	<div class="main-content">
		<div class="row">
			<div class="col-sm-10 col-sm-offset-1">
				<div class="login-container">
					<div class="space-6"></div>

					<div class="position-relative">
						<div id="login-box" class="login-box visible widget-box no-border">
							<div class="widget-body">
								<div class="widget-main">
									<h4 class="header2 blue lighter bigger">
										<i class="ace-icon fa fa-coffee green"></i>
										请输入您的信息
									</h4>

									<div class="space-6"></div>

									<form id="loginForm">
										<fieldset>
											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="用户名" name="mname" value="${mname}"/>
															<i class="ace-icon fa fa-user"></i>
														</span>
											</label>

											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="密码" name="mpassword" value="${mpassword}"/>
															<i class="ace-icon fa fa-lock"></i>
														</span>
											</label>

											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input style="width: 100px" type="text" class="form-control" placeholder="验证码" id="verifycode" name="verifycode" required/>
															<img id="kaptcha" style="cursor: pointer;cursor: hand;margin-top: -35px;margin-left: 100px"
																 onclick="this.src='<%=request.getContextPath()%>/login/captcha.html?'+Math.random();"
																 src="<%=request.getContextPath()%>/login/captcha.html">
														</span>
											</label>

											<div class="space"></div>

											<div class="clearfix">
												<label class="inline">
													<input type="checkbox" class="ace" name="isRemember"/>
													<span class="lbl"> 记住</span>
												</label>

												<button type="button" id="loginBtn" class="width-35 pull-right btn btn-sm btn-primary">
													<i class="ace-icon fa fa-key"></i>
													<span class="bigger-110">登录</span>
												</button>
											</div>

											<div class="space-4"></div>
										</fieldset>
									</form>

									<%--<div class="social-or-login center">--%>
									<%--<span class="bigger-110">第三方登录</span>--%>
									<%--</div>--%>

									<%--<div class="space-6"></div>--%>

									<%--<div class="social-login center">--%>
									<%--<a class="btn btn-primary">--%>
									<%--<i class="ace-icon fa fa-facebook"></i>--%>
									<%--</a>--%>

									<%--<a class="btn btn-info">--%>
									<%--<i class="ace-icon fa fa-twitter"></i>--%>
									<%--</a>--%>

									<%--<a class="btn btn-danger">--%>
									<%--<i class="ace-icon fa fa-google-plus"></i>--%>
									<%--</a>--%>
									<%--</div>--%>
								</div><!-- /.widget-main -->

								<div class="toolbar clearfix">
									<div>
										<a href="#" data-target="#forgot-box" class="forgot-password-link">
											<i class="ace-icon fa fa-arrow-left"></i>
											忘记密码
										</a>
									</div>
									<div>
										<a href="#" data-target="#signup-box" class="user-signup-link">
											注册
											<i class="ace-icon fa fa-arrow-right"></i>
										</a>
									</div>
								</div>
							</div><!-- /.widget-body -->
						</div><!-- /.login-box -->

						<div id="forgot-box" class="forgot-box widget-box no-border">
							<div class="widget-body">
								<div class="widget-main">
									<h4 class="header2 red lighter bigger">
										<i class="ace-icon fa fa-key"></i>
										找回密码
									</h4>

									<div class="space-6"></div>
									<p>
										输入您的电子邮件和接收指令
									</p>

									<form>
										<fieldset>
											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="email" class="form-control" placeholder="邮箱" name="forgetPwd" id="forgetPwd"/>
															<i class="ace-icon fa fa-envelope"></i>
														</span>
											</label>

											<div class="clearfix">
												<button id="sendEmail" type="button" class="width-35 pull-right btn btn-sm btn-danger">
													<i class="ace-icon fa fa-lightbulb-o"></i>
													<span class="bigger-110" >发送邮件</span>
												</button>
											</div>
										</fieldset>
									</form>
								</div><!-- /.widget-main -->

								<div class="toolbar center">
									<a href="#" data-target="#login-box" class="back-to-login-link">
										返回登录
										<i class="ace-icon fa fa-arrow-right"></i>
									</a>
								</div>
							</div><!-- /.widget-body -->
						</div><!-- /.forgot-box -->

						<div id="signup-box" class="signup-box widget-box no-border">
							<div class="widget-body">
								<div class="widget-main">
									<h4 class="header2 green lighter bigger">
										<i class="ace-icon fa fa-users blue"></i>
										用户注册
									</h4>

									<div class="space-6"></div>
									<p>填写信息: </p>

									<form id="regForm">
										<fieldset>


											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" placeholder="用户名" name="mname"/>
															<i class="ace-icon fa fa-user"></i>
														</span>
											</label>

											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="密码" name="mpassword"/>
															<i class="ace-icon fa fa-lock"></i>
														</span>
											</label>

											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" placeholder="确认密码" name="repassword"/>
															<i class="ace-icon fa fa-retweet"></i>
														</span>
											</label>
											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="tel" class="form-control" placeholder="身份证号码" name="midno"/>
															<i class="ace-icon fa fa-credit-card"></i>
														</span>
											</label>

											<label class="block">
												<input type="radio" name="gender" class="ace" value=1/>
													<span class="lbl">
															男
														</span>
												<input type="radio" name="gender" class="ace" value=0 checked/>
												<span class="lbl">
															女
														</span>
											</label>
											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="email" class="form-control" placeholder="邮箱" id="memail" name="memail"/>
															<i class="ace-icon fa fa-envelope"></i>
														</span>
											</label>
											<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="tel" class="form-control" placeholder="联系方式" id="mphone" name="mphone"/>
															<i class="ace-icon fa fa-phone"></i>
														</span>
											</label>


											<div class="space-24"></div>

											<div class="clearfix">
												<button type="reset" class="width-30 pull-left btn btn-sm">
													<i class="ace-icon fa fa-refresh"></i>
													<span class="bigger-110">重置</span>
												</button>

												<button type="button" id="regBtn" class="width-65 pull-right btn btn-sm btn-success">
													<span class="bigger-110">注册</span>

													<i class="ace-icon fa fa-arrow-right icon-on-right"></i>
												</button>
											</div>
										</fieldset>
									</form>
								</div>

								<div class="toolbar center">
									<a href="#" data-target="#login-box" class="back-to-login-link">
										<i class="ace-icon fa fa-arrow-left"></i>
										返回登录
									</a>
								</div>
							</div><!-- /.widget-body -->
						</div><!-- /.signup-box -->
					</div><!-- /.position-relative -->
				</div>
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.main-content -->
</div><!-- /.main-container -->

<!-- basic scripts -->

<!--[if !IE]> -->
<%--<script src="js/jquery.2.1.1.min.js"></script>--%>

<!-- <![endif]-->

<!--[if IE]>
<script src="js/jquery-1.11.0.min.js"></script>
<![endif]-->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='js/jquery-1.11.0.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<![endif]-->
<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>

<!-- inline scripts related to this page -->
<script type="text/javascript">
    jQuery(function($) {
        $(document).on('click', '.toolbar a[data-target]', function(e) {
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
        });
    });
	$(document).ready(function () {
	    $("#regBtn").click(function () {
			$.ajax({
				url:'<%=request.getContextPath()%>/user/verifyemailandphone.html',
				data:'memail='+$("#memail").val()+"&mphone="+$("#mphone").val(),
				type:'post',
				success:function(data){
						if(data.status == 1){
                        $("#regForm").ajaxSubmit({
                            type:"post",
                            url:"<%=request.getContextPath()%>/user/register.html",
                            success:function (res) {
                                if(res.status == "0"){
                                    alert(res.errorList.join("\n"));
                                }else if(res.status == "1") {
                                    alert(res.msg);
                                }
                            }
                        });
					}else{
					    alert(data.msg);
					}
				}
			});

        });
        $("#loginBtn").click(function () {
            //验证验证码
			$.ajax({
				url:'<%=request.getContextPath()%>/kaptchaverify.html',
				data:'code='+$("#verifycode").val(),
				success:function (data) {
					if(data.status == 1){
					    //验证码正确则进行表单提交
                        $("#loginForm").ajaxSubmit({
                            type:"post",
                            url:"<%=request.getContextPath()%>/user/login.html",
                            success:function (res) {
                                if(res.status == "1") {
                                    alert("登录成功");
                                    if(res.username == "admin"){
                                        window.location.href="<%=request.getContextPath()%>/admin/adminindex.jsp";
									}else{
                                        window.location.href = "<%=request.getContextPath()%>/index.html";
									}
                                }else{
                                    alert(res.msg);
                                    $("#verifycode")[0].value = "";
                                    $("#kaptcha").attr("src",'<%=request.getContextPath()%>/login/captcha.html?'+Math.random());
                                }
                            }
                        });
					}else {
					    alert(data.msg);
                        $("#verifycode")[0].value = "";
                        $("#kaptcha").attr("src",'<%=request.getContextPath()%>/login/captcha.html?'+Math.random());
					}
                }
			});
        });
        $("#sendEmail").on('click',function () {
			$.ajax({
				url:'<%=request.getContextPath()%>/user/resetpwd.html',
				data:'email='+$("#forgetPwd").val(),
				type:'post',
				success:function (data) {
				    alert(data.msg);
                }
			});
        });
    });
</script>
</div>
<!--middle end-->
<jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>