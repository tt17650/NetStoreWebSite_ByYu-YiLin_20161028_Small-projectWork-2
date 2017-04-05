<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>首頁</h3>
    <p>NetStore小小商店-首頁(產品)</p>
    <br />
    <P>管理工具：       
        <asp:ImageButton ID="ImgBtn_Backyard" runat="server" ImageUrl="~/images/btn/btn_Backyard.png" onmouseover="this.src='images/btn/btn_Backyard_lt.png'" onmouseout="this.src='images/btn/btn_Backyard.png'" PostBackUrl="~/backyard/Product.aspx" Height="30px" Width="108px" /></P>
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Product_id" DataSourceID="SqlDataSource1" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="5px" CellPadding="3" CellSpacing="2" Font-Size="20px">
        <Columns>
            <asp:BoundField DataField="Product_id" HeaderText="產品編號" InsertVisible="False" ReadOnly="True" SortExpression="Product_id" />
            <asp:HyperLinkField DataNavigateUrlFields="Product_id" DataNavigateUrlFormatString="Detail.aspx?qid={0}" DataTextField="Product_name" HeaderText="產品名稱" />
            <asp:BoundField DataField="Category" HeaderText="類型" SortExpression="Category" />
            <asp:BoundField DataField="Price" HeaderText="售價" SortExpression="Price" />
        </Columns>
        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
        <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#FFF1D4" />
        <SortedAscendingHeaderStyle BackColor="#B95C30" />
        <SortedDescendingCellStyle BackColor="#F1E5CE" />
        <SortedDescendingHeaderStyle BackColor="#93451F" />
</asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT [Product_id], [Product_name], [Category], [Price] FROM [Product]"></asp:SqlDataSource>
    </asp:Content>

