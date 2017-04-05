<%@ Page Title="" Language="C#" MasterPageFile="~/backyard/admin.master" %>

<script runat="server">

    protected void dsFormView_Updated(object sender, SqlDataSourceStatusEventArgs e) {
        if (e.Exception==null) { //更新成功
            GridView1.DataBind(); //再次資料繫結,顯示更新結果
            FormView1.Visible = false;
        } else { //更新失敗
            lblMessage.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e){
        FormView1.Visible = true;
    }

    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e){

    }

    protected void btnInsert_Click(object sender, EventArgs e){
        FormView1.Visible = true;
        FormView1.ChangeMode(FormViewMode.Insert);
    }

    protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e){
        //Response.Write(e.CommandName);
        if (e.CommandName=="Cancel") {
            FormView1.Visible = false;
        }
    }

    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e){
        GridView1.DataBind(); //再次資料繫結,顯示更新結果
        FormView1.Visible = false;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" Runat="Server">
    <h3>產品</h3>
    <asp:Button ID="btnInsert" runat="server" OnClick="btnInsert_Click" Text="新增" />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="Product_id" DataSourceID="dsProduct" ForeColor="Black" GridLines="Horizontal" AllowPaging="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" PageSize="5">
        <Columns>
            <asp:BoundField DataField="Product_id" HeaderText="編號" InsertVisible="False" ReadOnly="True" SortExpression="Product_id" />
            <asp:BoundField DataField="Product_name" HeaderText="名稱" SortExpression="Product_name" />
            <asp:BoundField DataField="Price" HeaderText="價格" SortExpression="Price" />
            <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" />
        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
</asp:GridView>
    <br />
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Product_id" DataSourceID="dsFormView" DefaultMode="Edit" OnItemCommand="FormView1_ItemCommand" OnItemInserted="FormView1_ItemInserted" OnItemUpdating="FormView1_ItemUpdating" Width="321px">
        <EditItemTemplate>
            產品編號:
            <asp:Label ID="Product_idLabel1" runat="server" Text='<%# Eval("Product_id") %>' />
            <br />
            產品名稱:
            <asp:TextBox ID="Product_nameTextBox" runat="server" Text='<%# Bind("Product_name") %>' Width="150px" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Product_nameTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            出品社:
            <asp:DropDownList ID="ListPublishers" runat="server" AutoPostBack="True" DataSourceID="dsPublishers" DataTextField="pub_name" DataValueField="pub_id" />
            <br />
            數量:
            <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="QuantityTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            類型:
            <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CategoryTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            價格:
            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="priceTextBox" ErrorMessage="價格要小於2000!" Operator="LessThan" Type="Double" ValueToCompare="2000"></asp:CompareValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="PriceTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            notes:
            <asp:TextBox ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            產品名稱:
            <asp:TextBox ID="Product_nameTextBox" runat="server" Text='<%# Bind("Product_name") %>' Width="150px" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Product_nameTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            出品社:
            <asp:DropDownList ID="ListPublishers" runat="server" AutoPostBack="True" DataSourceID="dsPublishers" DataTextField="pub_name" DataValueField="pub_id" />
            <br />
            數量:
            <asp:TextBox ID="QuantityTextBox" runat="server" Text='<%# Bind("Quantity") %>' />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="QuantityTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            類型:
            <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CategoryTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            價格:
            <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="priceTextBox" ErrorMessage="價格要小於2000!" Operator="LessThan" Type="Double" ValueToCompare="2000"></asp:CompareValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="PriceTextBox" ErrorMessage="此欄位必填"></asp:RequiredFieldValidator>
            <br />
            notes:
            <asp:TextBox ID="notesTextBox" runat="server" Text='<%# Bind("notes") %>' />
            <br />
            
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
        <ItemTemplate>
            產品編號:
            <asp:Label ID="Product_idLabel" runat="server" Text='<%# Eval("Product_id") %>' />
            <br />
            產品名稱:
            <asp:Label ID="Product_nameLabel" runat="server" Text='<%# Bind("Product_name") %>' />
            <br />
            Quantity:
            <asp:Label ID="QuantityLabel" runat="server" Text='<%# Bind("Quantity") %>' />
            <br />
            Category:
            <asp:Label ID="CategoryLabel" runat="server" Text='<%# Bind("Category") %>' />
            <br />
            Price:
            <asp:Label ID="PriceLabel" runat="server" Text='<%# Bind("Price") %>' />
            <br />
            notes:
            <asp:Label ID="notesLabel" runat="server" Text='<%# Bind("notes") %>' />
            <br />
            pub_id:
            <asp:Label ID="pub_idLabel" runat="server" Text='<%# Bind("pub_id") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="編輯" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="刪除" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="新增" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="dsFormView" runat="server" 
        ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" 
        DeleteCommand="DELETE FROM [Product] WHERE [Product_id] = @Product_id" 
        InsertCommand="INSERT INTO [Product] ([Product_name], [Quantity], [Category], [Price], [notes], [pub_id]) VALUES (@Product_name, @Quantity, @Category, @Price, @notes, @pub_id)" 
        SelectCommand="SELECT [Product_id], [Product_name], [Quantity], [Category], [Price], [notes], [pub_id] FROM [Product] WHERE ([Product_id] = @Product_id)" 
        UpdateCommand="UPDATE [Product] SET [Product_name] = @Product_name, [Quantity] = @Quantity, [Category] = @Category, [Price] = @Price, [notes] = @notes, [pub_id] = @pub_id WHERE [Product_id] = @Product_id"
        OnUpdated="dsFormView_Updated">
        <DeleteParameters>
            <asp:Parameter Name="Product_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Product_name" Type="String" />
            <asp:Parameter Name="Quantity" Type="Int32" />
            <asp:Parameter Name="Category" Type="String" />
            <asp:Parameter Name="Price" Type="Int32" />
            <asp:Parameter Name="notes" Type="String" />
            <asp:Parameter Name="pub_id" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="Product_id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Product_name" Type="String" />
            <asp:Parameter Name="Quantity" Type="Int32" />
            <asp:Parameter Name="Category" Type="String" />
            <asp:Parameter Name="Price" Type="Int32" />
            <asp:Parameter Name="notes" Type="String" />
            <asp:Parameter Name="pub_id" Type="String" />
            <asp:Parameter Name="Product_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="dsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT [Product_id], [Product_name], [Price] FROM [Product]" DeleteCommand="DELETE FROM [Product] WHERE [Product_id] = @Product_id" InsertCommand="INSERT INTO [Product] ([Product_name], [Price]) VALUES (@Product_name, @Price)" UpdateCommand="UPDATE [Product] SET [Product_name] = @Product_name, [Price] = @Price WHERE [Product_id] = @Product_id">
    <DeleteParameters>
        <asp:Parameter Name="Product_id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Product_name" Type="String" />
        <asp:Parameter Name="Price" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Product_name" Type="String" />
        <asp:Parameter Name="Price" Type="Int32" />
        <asp:Parameter Name="Product_id" Type="Int32" />
    </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsPublishers" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT [pub_id], [pub_name] FROM [publishers]"></asp:SqlDataSource>
    </asp:Content>

