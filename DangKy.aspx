<%@ Page Title="Đăng ký tài khoản" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DangKy.aspx.cs" Inherits="DangKy" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <div class="wrap narrow">
        <asp:Panel runat="server" DefaultButton="btnRegister" CssClass="panel">
            <h2>Đăng ký tài khoản</h2>
            <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
            
            <label>Tên đăng nhập</label>
            <asp:TextBox ID="txtUser" runat="server" MaxLength="50" placeholder="Nhập tên đăng nhập..." />
            
            <label>Họ và tên</label>
            <asp:TextBox ID="txtHoTen" runat="server" MaxLength="100" placeholder="Nhập họ và tên của bạn..." />
            
            <label>Email hoặc Số điện thoại</label>
            <asp:TextBox ID="txtEmail" runat="server" MaxLength="50" placeholder="Nhập email hoặc số điện thoại..." />
            
            <label>Mật khẩu</label>
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" MaxLength="50" placeholder="Nhập mật khẩu..." />
            
            <label>Nhập lại mật khẩu</label>
            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" MaxLength="50" placeholder="Xác nhận lại mật khẩu..." />
            
            <asp:Button ID="btnRegister" runat="server" Text="Đăng ký" CssClass="btn full" OnClick="btnRegister_Click" />
            
            <p class="hint" style="text-align: center; margin-top: 16px;">
                Đã có tài khoản? <a href="DangNhap.aspx" style="color: var(--r); font-weight: 700;">Đăng nhập ngay</a>
            </p>
        </asp:Panel>
    </div>
</asp:Content>