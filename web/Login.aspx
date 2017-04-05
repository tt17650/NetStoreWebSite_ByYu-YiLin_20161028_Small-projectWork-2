<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e) {
        if (NetStoreMembership.VerifyUser(Login1.UserName, Login1.Password)) {
            //產生驗證Cookie
            //FormsAuthentication.RedirectFromLoginPage(userName,false)            
            e.Authenticated = true; //轉址到DestinationPageUrl
        }
        else {
            e.Authenticated = false; //自動顯示錯誤訊息
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>會員登入</h3>
    <p>歡迎使用會員登入系統！</p>
    <asp:Login ID="Login1" runat="server" 
        OnAuthenticate="Login1_Authenticate"
        DestinationPageUrl="Default.aspx" Font-Size="20px" >       
    </asp:Login>        
    <br/>
    <br/>
    <P> ↓ ↓ ↓ 還不是本站會員？那來註冊吧！ ↓ ↓ ↓ <br/>
        <asp:ImageButton ID="ImgBtn_Register" runat="server" ImageUrl="~/images/btn/btn_Register.png" onmouseover="this.src='images/btn/btn_Register_lt.png'" onmouseout="this.src='images/btn/btn_Register.png'" PostBackUrl="~/Register.aspx" Height="30px" Width="108px" /></P>
</asp:Content>

