<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckBoxList.aspx.cs" Inherits="QUANLIMENU.CheckBoxListPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CheckBoxList</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:CheckBoxList ID="CheckBoxList1" runat="server">
        </asp:CheckBoxList>
        <br />
        <asp:Button ID="butSelect" runat="server" Text="Select" OnClick="butSelect_Click" />
        <br />
        Danh sách đã chọn:<br />
        <asp:CheckBoxList ID="CheckBoxList2" runat="server">
        </asp:CheckBoxList>
    </div>
    </form>
</body>
</html>
