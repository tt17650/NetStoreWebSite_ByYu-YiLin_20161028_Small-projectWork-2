<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">
    string CheckPrice(object fld) {
        string s = "";
        if (Convert.IsDBNull(fld)) { //判斷是否為資料庫的Null
            s = "試閱";
        }
        else {
            s = ((decimal)fld).ToString("c2"); //格式化為c2格式
        }
        return s;
    }

    protected void btnMyFavorite_Click(object sender, EventArgs e) {
        //取得這本書的編號
        Label lbl_id = (Label)FormView1.FindControl("Product_idLabel");
        //判斷FindControl是否成功(測試用)
        //if (lbl_id != null){Response.Write("<script language=javascript>alert('成功');</" + "script>");}
        //else {Response.Write("<script language=javascript>alert('不成功');</" + "script>");}
        string tid = lbl_id.Text; //將lbl_id的Text屬性值給tid

        //在Cookie中記錄這個的編號
        HttpCookie cookie = new HttpCookie("myFavorite"); //宣告一個Cookie，名字叫做"myFavorite"
        cookie.Value = tid; //令cookie的Valuet屬性值為字串變數tid的內容值
        cookie.Expires = DateTime.Now.AddDays(7);//指定過期時間(未過期Browser會用檔案儲存)
        Response.Cookies.Add(cookie); //加入瀏覽器的Cookies之中
    }

    protected void btnAddtoCart_Click(object sender, EventArgs e) {
        //取得產品採購資訊(編號,價格,數量)
        CartItem item = new CartItem() ;
        //Label lbl = (Label)FormView1.FindControl("Product_idLabel");
        ////string tid = lbl.Text;
        //item.Product_Id = lbl.Text;
        //lbl = (Label)FormView1.FindControl("PriceLabel");
        ////decimal price = Convert.ToDecimal(lbl.Text);
        //item.Price = Convert.ToDecimal(lbl.Text);
        ////int quanty = 1;
        //item.Quantity = 1;

        //第二次PostBack時FormView不會讀取資料(因為第一次已讀取)-->FormView1.DataItem是null
        //明確呼叫DataBind,強迫FormView再讀取資料-->FormView1.DataItem才不會null
        FormView1.DataBind();
        object product = FormView1.DataItem;  //DataItem:直接取得FormView對應的那一筆資料
        item.Product_Id =DataBinder.Eval(product, "Product_id").ToString();
        item.ProductName = (string)DataBinder.Eval(product,"Product_name");
        item.Price = Convert.ToDecimal(DataBinder.Eval(product, "Price"));
        item.Quantity = 1;
        Response.Write(item.SubTotal);

        //取得現有購物車內容(Session變數記錄)
        //CartItem[] cart = new CartItem[100]; //不用陣列因為固定大小
        List<CartItem> cart; //用List比較彈性
        if (Session["Cart"]==null) {
            cart = new List<CartItem>(); //建立全新的集合
        }
        else {
            cart =(List<CartItem>) Session["Cart"];
        }

        //購物車中已有的產品?
        bool exists = false; //已存在
        for (int i = 0; i < cart.Count; i++) {
            if (cart[i].Product_Id==item.Product_Id) {
                cart[i].Quantity = cart[i].Quantity+1; //已存在,數量加1
                exists = true;
            }
        }
        if (!exists) {//新的產品
            cart.Add(item);//加入購物車
        }

        //更新購物車(Session變數記錄)
        Session["Cart"] = cart;
        Response.Redirect("Cart.aspx");//前往購物車顯示畫面
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Product_id" DataSourceID="SqlDataSource1" Font-Size="20px">
                <ItemTemplate>
            <h3>&nbsp;<asp:Label ID="Product_nameLabel" runat="server" Font-Size="24pt" Text='<%# Bind("Product_name") %>' />&nbsp;- 詳細資訊</h3>
            <br />
            <asp:Image ID="Image1" runat="server" Height="244px" ImageUrl='<%# Eval("Product_id", "covers/{0}.png") %>' Width="150px" />
            <br />
            商品編號:
            <asp:Label ID="Product_idLabel" runat="server" Text='<%# Eval("Product_id") %>' />
            <br />
            類型:
            <asp:Label ID="CategoryLabel" runat="server" Text='<%# Bind("Category") %>' />
            <br />
            價格:
            <asp:Label ID="PriceLabel" runat="server" Text='<%# Bind("Price", "{0:C2}") %>' />
            <br />
            <br />
            簡介:
            <br />
            <asp:Label ID="notesLabel" runat="server" Text='<%# Bind("notes") %>' />
            <br />
        </ItemTemplate>
        <EditItemTemplate>
            商品編號:
            <asp:Label ID="Product_idLabel1" runat="server" Text='<%# Eval("Product_id") %>' />
            <br />
            商品名稱:
            <asp:TextBox ID="Product_nameTextBox" runat="server" Text='<%# Bind("Product_name") %>' />
            <br />
            類型:
            <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' />
            <br />
            價格:
            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
            <br />
            notes:
            <asp:TextBox ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            Product_name:
            <asp:TextBox ID="Product_nameTextBox" runat="server" Text='<%# Bind("Product_name") %>' />
            <br />
            Category:
            <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' />
            <br />
            Price:
            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
            <br />
            notes:
            <asp:TextBox ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
    </asp:FormView>
    <asp:Button ID="btnMyFavorite" runat="server" Text="設為我的最愛" 
        OnClick="btnMyFavorite_Click" />
    <asp:Button ID="btnAddtoCart" runat="server" Text="加入購物車" OnClick="btnAddtoCart_Click" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT Product_id, Product_name, Category, Price, notes FROM Product WHERE (Product_id = @tid)">
        <SelectParameters>
            <asp:QueryStringParameter Name="tid" QueryStringField="qid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

