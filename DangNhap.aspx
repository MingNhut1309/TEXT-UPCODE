<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DangNhap.aspx.cs" Inherits="DangNhap" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
    <div class="wrap narrow">
        <asp:Panel runat="server" DefaultButton="btnLogin" CssClass="panel">
            <h2>Đăng nhập</h2>
            <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
            <label>Tên đăng nhập</label>
            <asp:TextBox ID="txtUser" runat="server" MaxLength="50" />
            <label>Mật khẩu</label>
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" MaxLength="50" />
            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn full" OnClick="btnLogin_Click" />
            <p class="hint">Tài khoản mẫu: <b>admin / 123</b> (quản trị) · <b>khach01 / 123</b> (khách)</p>
        </asp:Panel>
    </div>
</asp:Content>
