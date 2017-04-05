<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void btnGenHash_Click(object sender, EventArgs e) {
        string salt = BCrypt.Net.BCrypt.GenerateSalt(12);
        string hash = BCrypt.Net.BCrypt.HashPassword(TextBox1.Text, salt);
        Response.Write(string.Format("salt: {0}<br/>hash: {1}<br/>hash長度:{2}<hr/>",
            salt,hash,hash.Length));
    }

    protected void btnVerify_Click(object sender, EventArgs e) {
        bool result= BCrypt.Net.BCrypt.Verify(txtPass.Text, txtHash.Text);
        //Response.Write(result ? "成功" : "失敗" );
        if (result==true) {
            Response.Write("成功");
        }
        else {
            Response.Write("失敗");
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
    <div>
    
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="btnGenHash" runat="server" OnClick="btnGenHash_Click" Text="GenHash" />
    
        <br />
        <br />
        輸入密碼:
        <asp:TextBox ID="txtPass" runat="server"></asp:TextBox>
        <br />
        原密碼的Hash:
        <asp:TextBox ID="txtHash" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnVerify" runat="server" OnClick="btnVerify_Click" Text="驗證" />
    
    </div>
    </form>
</body>
</html>
