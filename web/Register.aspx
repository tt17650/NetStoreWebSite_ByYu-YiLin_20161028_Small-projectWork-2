<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

    protected void btnRegister_Click(object sender, EventArgs e) {
        string errMessage;
        if(NetStoreMembership.CreateUser(txtUserName.Text, txtPassword.Text, out errMessage)) {
            lblMessage.Text = "註冊成功!";
        }
        else {
            lblMessage.Text = errMessage;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>註冊會員</h3>
    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    <p>帳號: <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox></p>
    <p>密碼: <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox></p>
    <p><asp:Button ID="btnRegister" runat="server" Text="註冊" OnClick="btnRegister_Click" /></p>
</asp:Content>

