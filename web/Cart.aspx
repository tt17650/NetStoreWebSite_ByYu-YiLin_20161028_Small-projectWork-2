<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">
    void DisplayCart() {

        if (Session["Cart"]==null) {
            lblMessage.Text = "購物車中尚未有產品!";
        }
        else {
            List<CartItem> cart;
            cart =(List<CartItem>) Session["Cart"];
            if (cart.Count==0) {  //判斷購物車筆數等於0
                lblMessage.Text = "購物車中尚未有產品!";
            }
            GridView1.DataSource = cart;
            GridView1.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack) { //第一次進入
            DisplayCart();
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        string tid = (string)e.Keys["Product_Id"];
        //Response.Write(tid);

        //刪除Session購物車中對應的產品
        if (Session["Cart"]==null) {
            lblMessage.Text = "購物車中尚未有產品!";
        }
        else {
            List<CartItem> cart;
            cart =(List<CartItem>) Session["Cart"];
            for (int i = 0; i < cart.Count; i++) {
                if (cart[i].Product_Id == tid) {
                    cart.RemoveAt(i);//移除這筆產品
                    break; //跳出for迴圈
                }
            }
            DisplayCart(); //顯示購物車內容
        }
    }

    decimal total = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType== DataControlRowType.DataRow) {
            object item = e.Row.DataItem;
            decimal subtotal= (decimal) DataBinder.Eval(item, "SubTotal");
            //Response.Write(subtotal + ", ");
            total = total + subtotal;
        }
        if (e.Row.RowType== DataControlRowType.Footer) {
            //e.Row.Cells.RemoveAt(3);
            //e.Row.Cells.RemoveAt(2);
            //e.Row.Cells.RemoveAt(1);
            //e.Row.Cells.RemoveAt(0);
            //e.Row.Cells[0].ColumnSpan = 4;
            //e.Row.Cells[0].Text = "總金額:";
            //e.Row.Cells[1].Text = total.ToString();
            e.Row.Cells[3].Text = "總金額:";
            e.Row.Cells[4].Text = total.ToString();
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>購物車</h3>
    <p>歡迎使用會員購物車系統！</p>
    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        OnRowDeleting="GridView1_RowDeleting" DataKeyNames="Product_Id" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Product_Id" HeaderText="編號" />
            <asp:HyperLinkField DataNavigateUrlFields="Product_Id" DataNavigateUrlFormatString="Detail.aspx?qid={0}" DataTextField="ProductName" HeaderText="書名" />
            <asp:BoundField DataField="Price" HeaderText="單價" DataFormatString="{0:c2}" />
            <asp:BoundField DataField="Quantity" HeaderText="數量" />
            <asp:BoundField DataField="SubTotal" HeaderText="小計" DataFormatString="{0:c2}" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>

</asp:Content>

