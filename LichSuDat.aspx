<%@ Page Title="Quản lý vé của tôi" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LichSuDat.aspx.cs" Inherits="LichSuDat" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
<div class="wrap" style="padding-top: 30px; padding-bottom: 50px;">
    
    <div style="margin-bottom: 25px;">
        <h2 style="font-size: 28px; font-weight: 900; text-transform: uppercase; margin: 0 0 5px 0;">QUẢN LÝ VÉ CỦA TÔI</h2>
        <p class="muted" style="margin: 0; font-size: 14px;">Xem lại lịch sử đặt vé và mã QR soát vé tại rạp của bạn.</p>
    </div>

    <div style="display: flex; gap: 15px; margin-bottom: 30px; align-items: center; justify-content: space-between; flex-wrap: wrap;">
        <div style="display: flex; gap: 12px;">
            <a href="LichSuDat.aspx" class="btn red-btn sm" style="display: inline-flex; align-items: center; gap: 8px;">🎟️ Vé Sắp Chiếu (<asp:Literal ID="litCountActive" runat="server" Text="1" />)</a>
            <a href="LichSuDat.aspx" class="btn outline sm" style="display: inline-flex; align-items: center; gap: 8px; background: #18181c; border-color: #2a2a30;">🕒 Lịch Sử Cũ (0)</a>
        </div>
    </div>

    <asp:Label ID="lblTrong" runat="server" CssClass="muted" Text="Bạn chưa có đơn đặt vé nào." Visible="false" style="display: block; padding: 40px 0; text-align: center;" />

    <asp:Repeater ID="rpt" runat="server" OnItemCommand="rpt_ItemCommand">
        <ItemTemplate>
            <div class="e-ticket-card" style="margin-bottom: 25px;">
                <div class="ticket-header">
                    <div>
                        <span class="badge-red">E-TICKET</span> Mã Đặt Vé: <b>ZNP-<%# Eval("MaDon") %></b>
                    </div>
                    <span class="status-right">Trạng thái: <span class="green-text">✓ <%# Db.TrangThaiText(Eval("TrangThai")) %></span></span>
                </div>
                
                <div class="ticket-body" style="display: flex; gap: 25px; align-items: center; flex-wrap: wrap;">
                    <div class="poster <%# Eval("LopPoster") %>" style="width: 140px; height: 200px; border-radius: 6px; flex: none; background-size: cover; background-position: center; position: relative; border: 1px solid #333;">
                        <div style="position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.8), transparent); display: flex; align-items: flex-end; padding: 10px;">
                            <span style="font-size: 11px; font-weight: bold; color: #fff; text-transform: uppercase;"><%# Eval("TheLoai") %></span>
                        </div>
                    </div>

                    <div class="ticket-info" style="flex: 1; min-width: 250px;">
                        <span class="lbl-ten">PHIM CHIẾU RẠP</span>
                        <h2 class="film-title" style="font-size: 22px; margin: 4px 0 15px 0;"><%#: Eval("TenPhim") %></h2>
                        
                        <div class="row-info" style="display: flex; gap: 30px; margin-bottom: 12px;">
                            <div>
                                <span class="muted" style="font-size: 12px;">Suất Chiếu</span>
                                <p style="margin: 2px 0 0 0; font-weight: 600; color: #fff;">🕒 <%# Eval("GioBatDau", "{0:HH:mm, dd/MM/yyyy}") %></p>
                            </div>
                            <div>
                                <span class="muted" style="font-size: 12px;">Phòng Chiếu</span>
                                <p style="margin: 2px 0 0 0; font-weight: 600; color: #fff;">🎬 <%#: Eval("TenPhong") %></p>
                            </div>
                        </div>

                        <div class="row-info" style="display: flex; gap: 30px;">
                            <div>
                                <span class="muted" style="font-size: 12px;">Ghế Đã Đặt</span>
                                <p style="margin: 2px 0 0 0;"><span class="seat-badge" style="background: #e50914; color: #fff; padding: 3px 8px; border-radius: 4px; font-size: 12px; font-weight: bold;"><%#: Eval("DanhSachGhe") %></span></p>
                            </div>
                            <div>
                                <span class="muted" style="font-size: 12px;">Tổng Tiền</span>
                                <p style="margin: 2px 0 0 0; font-size: 18px; font-weight: bold; color: #e50914;"><%# Eval("TongTien", "{0:N0}") %>đ</p>
                            </div>
                        </div>
                    </div>

                    <div style="display: flex; flex-direction: column; gap: 10px; min-width: 160px; justify-content: center;">
                        <a href="DatVeThanhCong.aspx?madon=<%# Eval("MaDon") %>" class="btn red-btn sm" style="text-align: center; padding: 10px 14px; font-size: 12px;">🎟️ Xem Mã QR Vé</a>
                        <asp:LinkButton runat="server" CommandName="cancel" CommandArgument='<%# Eval("MaDon") %>'
                            Visible='<%# Eval("TrangThai").ToString() == "ChoThanhToan" %>' CssClass="btn outline sm"
                            OnClientClick="return confirm('Bạn có chắc muốn hủy đơn này không?');" style="text-align: center; padding: 10px 14px; color: #ff6b6b; border-color: #ff6b6b;">Hủy đơn vé</asp:LinkButton>
                    </div>
                </div>

                <div class="ticket-footer-note" style="padding: 10px 20px; background: #121215; font-size: 12px; color: #f39c12; border-top: 1px solid #2a2a30;">
                    ⚠️ Vui lòng có mặt tại rạp trước giờ chiếu 15 phút. Xuất trình mã QR tại cửa soát vé.
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
</asp:Content>