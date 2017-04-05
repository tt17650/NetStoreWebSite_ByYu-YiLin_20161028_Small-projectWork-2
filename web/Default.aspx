<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
</script>
<script>
    var URL = "Product.aspx";
    var speed = 3000;  //1000==1秒
 function reload() {
        location = URL
 }
 setTimeout("reload()", speed);
</script>

<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%;">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title> WELCOME歡迎光臨！ NetStore小小商店 </title>
</head>
<body style="background-image: url(../images/WELCOME.jpg);
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-size: cover;
            color:#ffffff; text-align:center;">
    <form id="form1" runat="server">
    <div position: absolute;top: 50%;left: 50%;>
        <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <h1> WELCOME！  歡迎光臨！ <br/> NetStore 小小商店 </h1>
        <br/><br/><br/>
        <p style="font-size:16px">　　　　　　　　　　(3秒內...自動轉頁)</p>
    </div>
    </form>
</body>
</html>
