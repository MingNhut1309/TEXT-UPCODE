<%@ Page Title="Đặt Vé Thành Công" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DatVeThanhCong.aspx.cs" Inherits="DatVeThanhCong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="Server">
    <div class="wrap success-page" style="max-width: 950px; padding-top: 30px;">
        <div class="success-circle">✓</div>
        <div class="success-title">ĐẶT VÉ THÀNH CÔNG!</div>
        <div class="success-sub">Cảm ơn quý khách đã lựa chọn dịch vụ của <span class="red-text">ZANEPN CINEMA</span>. Chúc quý khách xem phim vui vẻ!</div>

        <div class="e-ticket-card">
            <div class="ticket-header">
                <span><span class="badge-red">E-TICKET</span> Mã Đặt Vé: <b style="color:#fff;">ZNP-<asp:Literal ID="litMaDon" runat="server" /></b></span>
                <span class="green-text">✓ Đã thanh toán</span>
            </div>
            <div class="ticket-body">
                <div class="ticket-info">
                    <span class="lbl-ten">TÊN PHIM</span>
                    <div class="film-title"><asp:Literal ID="litTenPhim" runat="server" /></div>
                    
                    <div class="row-info">
                        <div>
                            <span class="muted">Suất Chiếu</span>
                            <p>🕒 <asp:Literal ID="litSuatChieu" runat="server" /></p>
                        </div>
                        <div>
                            <span class="muted">Phòng Chiếu</span>
                            <p>🎥 <asp:Literal ID="litPhong" runat="server" /></p>
                        </div>
                    </div>

                    <div class="row-info">
                        <div>
                            <span class="muted">Ghế Đã Chọn</span>
                            <p><span class="seat-badge"><asp:Literal ID="litDanhSachGhe" runat="server" /></span></p>
                        </div>
                        <div>
                            <span class="muted">Phương Thức Thanh Toán</span>
                            <p>💳 Ví MoMo / Thẻ ATM</p>
                        </div>
                    </div>

                    <div class="total-row-pay">
                        <span class="muted" style="color:#fff;">Tổng Tiền Đã Thanh Toán:</span>
                        <span class="price-highlight"><asp:Literal ID="litTongTien" runat="server" /></span>
                    </div>
                </div>

                <div class="ticket-qr">
                    <div class="qr-big">
                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=ZANEPN-CINEMA-TICKET-%23<%= Request.QueryString["madon"] %>" alt="QR Code" style="width:100%; height:100%; border-radius:4px;" />
                    </div>
                    <p>Quét mã QR tại cửa soát vé</p>
                </div>
            </div>
            <div class="ticket-footer-note">
                ⚠ Vui lòng có mặt tại rạp trước giờ chiếu 15 phút. Vé đã mua không thể hoàn hoặc đổi trả.
            </div>
        </div>

        <div class="success-actions">
            <a href="Default.aspx" class="btn outline">🏠 Về Trang Chủ</a>
            <a href="LichSuDat.aspx" class="btn">🎫 Lịch Sử Đặt Vé</a>
        </div>
    </div>
</asp:Content>