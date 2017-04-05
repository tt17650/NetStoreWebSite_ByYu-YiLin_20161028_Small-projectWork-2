<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
    <h3>排行榜 Top10</h3>
    <p>排行榜內容</p>
    <asp:DataList ID="DataList1" runat="server" CellPadding="10" DataKeyField="Product_id" DataSourceID="SqlDataSource1" RepeatColumns="3" RepeatDirection="Horizontal" Font-Size="20px">
        <ItemTemplate>
            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Product_id", "covers/{0}.png") %>' Height="163px" Width="100px" />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Product_id", "Detail.aspx?qid={0}") %>' Text='<%# Eval("Product_name", "{0}") %>'></asp:HyperLink>
            <br />
<%--            <asp:Label ID="Product_nameLabel" runat="server" Text='<%# Eval("Product_name") %>' />
            <br />--%>
            編號:
            <asp:Label ID="Product_idLabel" runat="server" Text='<%# Eval("Product_id") %>' />
            <br />
            價格:
            <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price") %>' />
            <br />
<br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT TOP (10) Product_id, Product_name, Price, ytd_sales FROM Product ORDER BY ytd_sales DESC"></asp:SqlDataSource>
</asp:Content>

