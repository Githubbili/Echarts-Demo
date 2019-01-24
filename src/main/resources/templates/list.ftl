<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
</head>
<body>
<input id="user" type="text" placeholder="修改的用户名" >
<input id="pass" type="text" placeholder="新密码" >
<button id="change" name="login">修改</button>
<button id="add" name="login">新增</button>
<table>
<#list resultList as list>
    <tr>
        <td>用户名：${list.user}</td>
        <td>密码：${list.password}</td>
    </tr>
</#list>
</table>
</body>
<script src="/js/jquery-3.3.1.min.js"></script>
<script>
    $('#change').click(function(){
        $.ajax({
            type:"post",
            url:"/loginController/update.do",
            data:{pass:$("#pass").val(),user:$("#user").val()},
            success:function(df){
                if(df==1){
                    alert("修改"+$("#user").val()+"密码成功");
                    window.location ="/loginController/list.do";
                }else{
                    alert("修改失败");
                }
            }
        });
    });
    $('#add').click(function(){
        $.ajax({
            type:"post",
            url:"/loginController/update.do",
            data:{pass:$("#pass").val(),user:$("#user").val(),type:2},
            success:function(df){
                if(df==1){
                    alert("新增"+$("#user").val()+"成功");
                    window.location ="/loginController/list.do";
                }else{
                    alert("修改失败");
                }
            }
        });
    });
</script>
</html>