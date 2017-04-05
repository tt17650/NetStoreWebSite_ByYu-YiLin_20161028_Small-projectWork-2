<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="nsMain" Runat="Server">
     <h3>出品社：  <asp:DropDownList ID="ListPublishers" runat="server" AutoPostBack="True" DataSourceID="dsPublishers" DataTextField="pub_name" DataValueField="pub_id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="dsPublishers" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT [pub_id], [pub_name] FROM [publishers]"></asp:SqlDataSource>
    </h3>
    <p>出品社產品清單內容</p>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Product_id" DataSourceID="dsProduct" CellPadding="4" Font-Size="20px" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Product_id" HeaderText="產品編號" InsertVisible="False" ReadOnly="True" SortExpression="Product_id" />
            <asp:HyperLinkField DataNavigateUrlFields="Product_id" DataNavigateUrlFormatString="Detail.aspx?qid={0}" DataTextField="Product_name" HeaderText="產品名稱" />
            <asp:BoundField DataField="Category" HeaderText="類型" SortExpression="Category" />
            <asp:BoundField DataField="Price" HeaderText="售價" SortExpression="Price" />
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <SortedAscendingCellStyle BackColor="#FDF5AC" />
        <SortedAscendingHeaderStyle BackColor="#4D0000" />
        <SortedDescendingCellStyle BackColor="#FCF6C0" />
        <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
    <asp:SqlDataSource ID="dsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:NetStoreDBConnectionString %>" SelectCommand="SELECT Product_id, Product_name, Category, Price FROM Product WHERE (pub_id = @pub_id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ListPublishers" Name="pub_id" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
</asp:SqlDataSource>
        </asp:Content>

