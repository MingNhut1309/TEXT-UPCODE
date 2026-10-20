<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DangNhap.aspx.cs" Inherits="DangNhap" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <div class="wrap narrow">
        <asp:Panel runat="server" DefaultButton="btnLogin" CssClass="panel">
            <h2>Đăng nhập tài khoản</h2>
            <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
            
            <label>Tên đăng nhập hoặc Email</label>
            <asp:TextBox ID="txtUser" runat="server" MaxLength="50" placeholder="Email hoặc Số điện thoại" />
            
            <label>Mật khẩu</label>
            <div class="password-container">
                <asp:TextBox ID="txtPass" runat="server" TextMode="Password" MaxLength="50" placeholder="Mật khẩu" />
                <button type="button" class="eye-btn" onclick="togglePassVisibility(this)" title="Hiện/Ẩn mật khẩu">
                    <!-- Icon Mắt Nhắm (Mặc định khi ẩn) -->
                    <svg class="eye-closed" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                        <line x1="1" y1="1" x2="23" y2="23"></line>
                    </svg>
                    <!-- Icon Mắt Mở (Khi hiện mật khẩu) -->
                    <svg class="eye-open" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                        <circle cx="12" cy="12" r="3"></circle>
                    </svg>
                </button>
            </div>
            
            <div style="text-align: right; margin-top: 6px;">
                <a href="#" style="font-size: 12px; color: var(--mut);">Quên mật khẩu?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn full" OnClick="btnLogin_Click" />
            
            <p class="hint" style="text-align: center; margin-top: 16px;">
                Bạn chưa có tài khoản? <a href="DangKy.aspx" style="color: var(--r); font-weight: 700;">ĐĂNG KÝ NGAY</a>
            </p>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        function togglePassVisibility(btn) {
            // Tìm ô input mật khẩu nằm ngay trước nút bấm trong cùng container
            var container = btn.closest('.password-container');
            var txtPass = container.querySelector('input[type="password"], input[type="text"]');
            var eyeClosed = btn.querySelector('.eye-closed');
            var eyeOpen = btn.querySelector('.eye-open');

            if (txtPass.type === "password") {
                txtPass.type = "text";
                eyeClosed.style.display = "none";
                eyeOpen.style.display = "block";
            } else {
                txtPass.type = "password";
                eyeClosed.style.display = "block";
                eyeOpen.style.display = "none";
            }
        }
    </script>
</asp:Content>