<%@ Page Title="Quản lý phim" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Phim.aspx.cs" Inherits="AdminPhim" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
<div class="wrap">
    <div class="subnav"><a class="on" href="Phim.aspx">Phim</a><a href="Don.aspx">Đơn đặt vé</a></div>

    <h2 class="sec">Thêm phim mới</h2>
    <div class="panel formgrid">
        <asp:Label ID="lblMsg" runat="server" CssClass="msg full" />
        <div><label>Tên phim *</label><asp:TextBox ID="txtTen" runat="server" MaxLength="200" /></div>
        <div><label>Thể loại</label><asp:TextBox ID="txtLoai" runat="server" MaxLength="100" /></div>
        <div><label>Đạo diễn</label><asp:TextBox ID="txtDaoDien" runat="server" MaxLength="100" /></div>
        <div><label>Năm phát hành</label><asp:TextBox ID="txtNam" runat="server" MaxLength="4" /></div>
        <div><label>Thời lượng (phút)</label><asp:TextBox ID="txtTL" runat="server" MaxLength="3" /></div>
        <div><label>Nhãn</label>
            <asp:DropDownList ID="ddlNhan" runat="server">
                <asp:ListItem Value="">(không)</asp:ListItem><asp:ListItem>NEW</asp:ListItem>
                <asp:ListItem>HOT</asp:ListItem><asp:ListItem>3D</asp:ListItem><asp:ListItem>CLASSIC</asp:ListItem>
            </asp:DropDownList></div>
        <div><label>Độ tuổi</label>
            <asp:DropDownList ID="ddlTuoi" runat="server">
                <asp:ListItem>P</asp:ListItem><asp:ListItem Selected="True">T13</asp:ListItem>
                <asp:ListItem>T16</asp:ListItem><asp:ListItem>T18</asp:ListItem>
            </asp:DropDownList></div>
        <div><label>Màu poster</label>
            <asp:DropDownList ID="ddlPoster" runat="server">
                <asp:ListItem>poster-1</asp:ListItem><asp:ListItem>poster-2</asp:ListItem>
                <asp:ListItem>poster-3</asp:ListItem><asp:ListItem>poster-4</asp:ListItem>
            </asp:DropDownList></div>
        <div class="full"><label>Đường dẫn ảnh poster (tùy chọn, vd: ~/Content/img/ironman.jpg)</label><asp:TextBox ID="txtPoster" runat="server" MaxLength="300" /></div>
        <div class="full"><label>Mô tả</label><asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" /></div>
        <div class="full"><asp:Button ID="btnThem" runat="server" Text="Thêm phim" CssClass="btn" OnClick="btnThem_Click" /></div>
    </div>

    <h2 class="sec">Danh sách phim</h2>
    <table class="tbl">
        <tr><th>Mã</th><th>Tên phim</th><th>Năm</th><th>Nhãn</th><th>Tuổi</th><th>Hiển thị</th><th></th></tr>
        <asp:Repeater ID="rpt" runat="server" OnItemCommand="rpt_ItemCommand">
            <ItemTemplate>
                <tr>
                    <td><%# Eval("MaPhim") %></td>
                    <td><%#: Eval("TenPhim") %></td>
                    <td><%# Eval("NamPhatHanh") %></td>
                    <td><%#: Eval("NhanPhim") %></td>
                    <td><%#: Eval("DoTuoi") %></td>
                    <td><%# Convert.ToBoolean(Eval("An")) ? "Đang ẩn" : "Đang hiện" %></td>
                    <td><asp:LinkButton runat="server" CommandName="an" CommandArgument='<%# Eval("MaPhim") %>' CssClass="btn sm ghost">Ẩn / Hiện</asp:LinkButton></td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</div>
</asp:Content>
