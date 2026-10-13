<%@ Page Title="Vé của tôi" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LichSuDat.aspx.cs" Inherits="LichSuDat" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
<div class="wrap">
    <h2 class="sec">Vé của tôi</h2>
    <asp:Label ID="lblTrong" runat="server" CssClass="muted" Text="Bạn chưa có đơn đặt vé nào." Visible="false" />
    <asp:Repeater ID="rpt" runat="server" OnItemCommand="rpt_ItemCommand">
        <ItemTemplate>
            <div class="order st-<%# Eval("TrangThai") %>">
                <div>
                    <h3>#<%# Eval("MaDon") %> · <%#: Eval("TenPhim") %></h3>
                    <p><%#: Eval("TenPhong") %> · <%# Eval("GioBatDau", "{0:HH:mm dd/MM/yyyy}") %></p>
                    <p class="muted">Ghế: <%#: Eval("DanhSachGhe") %></p>
                </div>
                <div class="right">
                    <b><%# Eval("TongTien", "{0:N0}") %>đ</b>
                    <span class="status"><%# Db.TrangThaiText(Eval("TrangThai")) %></span>
                    <asp:LinkButton runat="server" CommandName="pay" CommandArgument='<%# Eval("MaDon") %>'
                        Visible='<%# Eval("TrangThai").ToString() == "ChoThanhToan" %>' CssClass="btn sm">Thanh toán</asp:LinkButton>
                    <asp:LinkButton runat="server" CommandName="cancel" CommandArgument='<%# Eval("MaDon") %>'
                        Visible='<%# Eval("TrangThai").ToString() == "ChoThanhToan" %>' CssClass="btn sm ghost"
                        OnClientClick="return confirm('Hủy đơn này?');">Hủy</asp:LinkButton>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
</asp:Content>
