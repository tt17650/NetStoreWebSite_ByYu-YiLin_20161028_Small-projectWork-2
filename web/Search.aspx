<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        lblMessage.Text = string.Format("查詢到{0}筆資料.", e.AffectedRows);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>商品查詢</h3>
    <p>
        關鍵字：<asp:TextBox ID="TextKeyWord" runat="server"></asp:TextBox>
        <asp:ImageButton ID="ImageButton1" runat="server" Height="20px" ImageUrl="~/images/Search.png" Width="20px" />
    </p>
    <p>
        <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
    </p>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Product_id" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" Font-Size="20px">
        <Columns>
            <asp:BoundField DataField="Product_id" HeaderText="產品編號" InsertVisible="False" ReadOnly="True" SortExpression="Product_id" />
            <asp:HyperLinkField DataNavigateUrlFields="Product_id" DataNavigateUrlFormatString="Detail.aspx?qid={0}" DataTextField="Product_name" HeaderText="產品名稱" />
            <asp:BoundField DataField="Category" HeaderText="類型" SortExpression="Category" />
            <asp:BoundField DataField="Price" HeaderText="售價" SortExpression="Price" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#330099" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <SortedAscendingCellStyle BackColor="#FEFCEB" />
        <SortedAscendingHeaderStyle BackColor="#AF0101" />
        <SortedDescendingCellStyle BackColor="#F6F0C0" />
        <SortedDescendingHeaderStyle BackColor="#7E0000" />
</asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT [Product_id], [Product_name], [Category], [Price] FROM [Product] WHERE ([Product_name] LIKE '%' + @Product_name + '%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextKeyWord" Name="Product_name" PropertyName="Text" Type="String" />
        </SelectParameters>
</asp:SqlDataSource>
    </asp:Content>

