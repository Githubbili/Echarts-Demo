<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet"  href="/css/verifyCode.css" media="all">
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
</head>
<body>
<div class="demoTable" style="margin-left:40%;margin-top: 10%;">
    <div class="layui-form-item">
<label class="layui-form-label">用户名:</label>
<div class="layui-inline">
    <input class="layui-input" type="text" id="login" value="1">
</div><br>
<label class="layui-form-label">密码:</label>
<div class="layui-inline">
    &nbsp;&nbsp; <input class="layui-input" type="text" id="pass" value="1">
</div><br>
<label class="layui-form-label">验证码:</label>
<div class="layui-inline">
    <section class="content">
    <span class="input input--hideo input--verify_code">
								<input class="layui-input"  type="text" id="login-verify-code"
                                       autocomplete="off" placeholder="请输入验证码" tabindex="3" maxlength="4" />
							</span>
        &nbsp;&nbsp;&nbsp;
    <canvas class="verify-code-canvas" id="login-verify-code-canvas"></canvas>
    </section>
</div>
<div class="layui-inline">
    <button id="login" name="login" class="layui-btn layui-btn-radius layui-btn-normal"  data-type="login"><i class="layui-icon layui-icon-search"></i>登录</button>
</div>
</div>
</div>
</body>

<script src="/js/jquery-3.3.1.min.js"></script>
<script src="/layui/layui.js"></script>
<script src="/js/verifyCode.js"></script>
<script>
    layui.use(['table', 'form','layer','laydate','jquery'], function (){
        var table = layui.table, form = layui.form,laydate=layui.laydate,layer =layui.layer,$ = layui.$;
        active = {
            login:function(){
                $.ajax({
                    type:"post",
                    url:"/loginController/login.do",
                    data:{user:$("#login").val(),pass:$("#pass").val()},
                    success:function(df){
                      if(df==2){
                          window.location ="/loginController/list.do"
                      }else{
                          window.location ="/"
                      }
                    }
                });
            }
        };
            $('.demoTable .layui-btn').on('click', function() {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
    });
</script>
</html>