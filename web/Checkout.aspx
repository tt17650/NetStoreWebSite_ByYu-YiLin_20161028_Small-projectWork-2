<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e) {
        //if (e.CurrentStepIndex==0) {
        if (Wizard1.WizardSteps[e.CurrentStepIndex].Title=="訂購資訊") {
            if (chkTheSameAsShipper.Checked) { //同收貨人

                txtShipAddr.Text = txtOrderAddr.Text;
                txtShipName.Text = txtOrderName.Text;
                txtShipPhone.Text = txtOrderPhone.Text;

                Wizard1.MoveTo(wStepFinish); //跳到[確認]
            }
        }
    }
    protected void Wizard1_ActiveStepChanged(object sender, EventArgs e) {
        if (Wizard1.ActiveStep.Title=="確認") { //把輸入的資料顯示在Label上
            lblOrderName.Text = txtOrderName.Text;
            lblOrderAddr.Text = txtOrderAddr.Text;
            lblOrderPhone.Text = txtOrderPhone.Text;

            lblShipName.Text = txtShipName.Text;
            lblShipAddr.Text = txtShipAddr.Text;
            lblShipPhone.Text = txtShipPhone.Text;

            DisplayCart();
        }
    }

    void DisplayCart() {
        List<CartItem> cart;
        cart = (List<CartItem>)Session["Cart"];
        GridView1.DataSource = cart;
        GridView1.DataBind();
    }

    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e) {
        //建立Order物件
        Order order = new Order();
        order.Username = User.Identity.Name; //自動取使用者的會員帳號
        order.OrderAddr = txtOrderAddr.Text;
        order.OrderPhone = txtOrderPhone.Text;
        order.ShipAddr = txtShipAddr.Text;
        order.ShipPhone = txtShipPhone.Text;
        order.CreateDate = DateTime.Now;

        //加入訂單明細
        List<CartItem> cart;
        cart = (List<CartItem>)Session["Cart"];
        Order_Details detail;
        for (int i = 0; i < cart.Count; i++) {
            detail = new Order_Details();
            detail.Product_Id = Convert.ToInt32(cart[i].Product_Id);
            detail.Qty = cart[i].Quantity;
            order.Order_Details.Add(detail);
        }

        //寫入資料庫
        NetStoreDBEntities1 db = new NetStoreDBEntities1();
        db.Orders.Add(order);
        db.SaveChanges();

        //顯示訂單編號及建立時間
        lblOrderNo.Text = order.Id.ToString();
        lblOrderCreateTime.Text = order.CreateDate.ToString();
    }

    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) { //第一次載入時
            txtOrderName.Text = User.Identity.Name;

            if (Session["Cart"] == null) {
                lblMessage.Text = "購物車中尚未有產品!";
                Wizard1.Visible = false;
            }
            else {
                List<CartItem> cart;
                cart =(List<CartItem>) Session["Cart"];
                if (cart.Count==0) {
                    lblMessage.Text = "購物車中尚未有產品!";
                    Wizard1.Visible = false;
                }
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>購物車</h3>
    <p>歡迎使用會員購物車系統！</p>
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
    <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="0" CellPadding="10" OnNextButtonClick="Wizard1_NextButtonClick" OnActiveStepChanged="Wizard1_ActiveStepChanged" OnFinishButtonClick="Wizard1_FinishButtonClick" BackColor="#FFFBD6" BorderColor="#FFDFAD" BorderWidth="1px" Font-Names="Verdana" Font-Size="Medium">
        <HeaderStyle BackColor="#FFCC66" BorderColor="#FFFBD6" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="#333333" HorizontalAlign="Center" />
        <NavigationButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" />
        <SideBarButtonStyle ForeColor="White" />
        <SideBarStyle BackColor="#990000" Font-Size="0.9em" VerticalAlign="Top" />
        <WizardSteps>
            <asp:WizardStep runat="server" title="訂購資訊">
                訂購姓名:<asp:TextBox ID="txtOrderName" runat="server"></asp:TextBox>
                <br />
                訂購地址:<asp:TextBox ID="txtOrderAddr" runat="server"></asp:TextBox>
                <br />
                訂購電話:<asp:TextBox ID="txtOrderPhone" runat="server"></asp:TextBox>
                <br />
                <asp:CheckBox ID="chkTheSameAsShipper" runat="server" Text="同收貨人" />
            </asp:WizardStep>
            <asp:WizardStep runat="server" title="收貨資訊">
                出貨姓名:<asp:TextBox ID="txtShipName" runat="server"></asp:TextBox>
                <br />
                出貨地址:<asp:TextBox ID="txtShipAddr" runat="server"></asp:TextBox>
                <br />
                出貨電話:<asp:TextBox ID="txtShipPhone" runat="server"></asp:TextBox>
            </asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Finish" Title="確認" ID="wStepFinish">
                訂購姓名:<asp:Label ID="lblOrderName" runat="server"></asp:Label>
                <br />
                訂購地址:<asp:Label ID="lblOrderAddr" runat="server"></asp:Label>
                <br />
                訂購電話:<asp:Label ID="lblOrderPhone" runat="server"></asp:Label>
                <br />
                <br />
                出貨姓名:<asp:Label ID="lblShipName" runat="server"></asp:Label>
                <br />
                出貨地址:<asp:Label ID="lblShipAddr" runat="server"></asp:Label>
                <br />
                出貨電話:<asp:Label ID="lblShipPhone" runat="server"></asp:Label>
                <br />
                <br />
                訂購清單:<br />
                <asp:GridView ID="GridView1" runat="server">
                </asp:GridView>
            </asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Complete" Title="完成">
                訂單編號:
                <asp:Label ID="lblOrderNo" runat="server"></asp:Label>
                <br />
                訂單建立時間:
                <asp:Label ID="lblOrderCreateTime" runat="server"></asp:Label>
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
</asp:Content>

