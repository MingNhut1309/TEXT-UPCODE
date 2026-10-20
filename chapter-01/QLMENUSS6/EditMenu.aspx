<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditMenu.aspx.cs" Inherits="QUANLIMENU.EditMenu" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cập nhật menu</title>
</head>
<body>
    <form id="form1" runat="server">
    <table style="width:500px;">
        <tr><td>ID_MN:</td>
            <td><asp:TextBox ID="txtID_MN" runat="server"></asp:TextBox></td>
        </tr>
        <tr><td>Lable:</td>
            <td><asp:TextBox ID="txtLable" runat="server"></asp:TextBox></td>
        </tr>
        <tr><td>Pos:</td>
            <td><asp:TextBox ID="txtPos" runat="server"></asp:TextBox></td>
        </tr>
        <tr><td>Parent:</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>
            </td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>
                <asp:Button ID="butSave" runat="server" Text="Update" OnClick="butSave_Click" />
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
