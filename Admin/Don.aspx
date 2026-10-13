<%@ Page Title="Đơn đặt vé" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Don.aspx.cs" Inherits="AdminDon" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
<div class="wrap">
    <div class="subnav"><a href="Phim.aspx">Phim</a><a class="on" href="Don.aspx">Đơn đặt vé</a></div>
    <h2 class="sec">Đơn đặt vé</h2>
    <table class="tbl">
        <tr><th>Mã</th><th>Khách</th><th>Phim / suất</th><th>Ghế</th><th>Tổng tiền</th><th>Trạng thái</th><th></th></tr>
        <asp:Repeater ID="rpt" runat="server" OnItemCommand="rpt_ItemCommand">
            <ItemTemplate>
                <tr>
                    <td>#<%# Eval("MaDon") %></td>
                    <td><%#: Eval("TenDangNhap") %></td>
                    <td><%#: Eval("TenPhim") %><br /><span class="muted"><%#: Eval("TenPhong") %> · <%# Eval("GioBatDau", "{0:HH:mm dd/MM/yyyy}") %></span></td>
                    <td><%#: Eval("DanhSachGhe") %></td>
                    <td><%# Eval("TongTien", "{0:N0}") %>đ</td>
                    <td><span class="status st-<%# Eval("TrangThai") %>"><%# Db.TrangThaiText(Eval("TrangThai")) %></span></td>
                    <td>
                        <asp:LinkButton runat="server" CommandName="pay" CommandArgument='<%# Eval("MaDon") %>'
                            Visible='<%# Eval("TrangThai").ToString() == "ChoThanhToan" %>' CssClass="btn sm">Xác nhận TT</asp:LinkButton>
                        <asp:LinkButton runat="server" CommandName="cancel" CommandArgument='<%# Eval("MaDon") %>'
                            Visible='<%# Eval("TrangThai").ToString() == "ChoThanhToan" %>' CssClass="btn sm ghost"
                            OnClientClick="return confirm('Hủy đơn này?');">Hủy</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</div>
</asp:Content>
