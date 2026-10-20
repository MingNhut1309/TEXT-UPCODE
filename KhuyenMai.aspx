<%@ Page Title="Khuyến Mãi & Ưu Đãi" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="KhuyenMai.aspx.cs" Inherits="KhuyenMai" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <div class="wrap" style="padding-top: 30px; padding-bottom: 50px;">
        <div class="sec-head">
            <div>
                <span class="eyebrow">Ưu đãi hấp dẫn</span>
                <h2>Khuyến Mãi & Ưu Đãi Đặc Biệt</h2>
            </div>
            <div class="note">Khám phá hàng loạt voucher giảm giá vé xem phim, combo bắp nước và các ưu đãi dành riêng mỗi ngày.</div>
        </div>

        <!-- Banner nổi bật đầu trang -->
        <div class="promo" style="border-radius: 10px; margin-top: 20px; margin-bottom: 35px; text-align: left; padding: 40px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px;">
            <div>
                <span class="badge" style="position: static; display: inline-block; margin-bottom: 10px;">ĐÃI LỚN HÀNG THÁNG</span>
                <h2 style="font-size: 32px; margin: 0 0 10px;">THỨ 4 HÀNG TUẦN - VÉ CHỈ TỪ 59.000Đ</h2>
                <p style="color: #ddd; max-width: 600px; margin: 0; font-weight: normal; font-size: 14px; text-transform: none;">
                    Thỏa sức thưởng thức mọi bộ phim bom tấn đỉnh cao tại tất cả các cụm rạp ZANEPN Cinema với mức giá không thể tuyệt vời hơn.
                </p>
            </div>
            <div style="display: flex; gap: 10px;">
                <a href="#" class="btn white">🎟️ Nhận Mã Ưu Đãi</a>
                <a href="#" class="btn ghost">Xem Chi Tiết</a>
            </div>
        </div>

        <!-- Bộ lọc tab khuyến mãi -->
        <div style="display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; border-bottom: 1px solid var(--line); padding-bottom: 15px;">
            <a href="#" class="btn sm" style="background: var(--r);">Tất Cả</a>
            <a href="#" class="btn sm outline" style="background: var(--card2);">Vé Xem Phim</a>
            <a href="#" class="btn sm outline" style="background: var(--card2);">Bắp Nước (Combo)</a>
            <a href="#" class="btn sm outline" style="background: var(--card2);">Thành Viên VIP</a>
            <a href="#" class="btn sm outline" style="background: var(--card2);">Sự Kiện Đặc Biệt</a>
        </div>

        <!-- Lưới danh sách các ưu đãi -->
        <div class="grid">
            <!-- Card 1 -->
            <div class="card">
                <div class="poster poster-1" style="height: 220px;">
                    <span class="badge b-new">VÉ XEM PHIM</span>
                    <span class="age" style="position: absolute; top: 10px; right: 10px;">Hạn: 30/10/2026</span>
                </div>
                <div class="cinfo">
                    <p class="genre" style="color: var(--r);">GIẢM GIÁ ĐẶC BIỆT</p>
                    <h3 style="margin: 0 0 8px; font-size: 18px; text-transform: uppercase;">Học Sinh - Sinh Viên Giảm 20% Mỗi Ngày</h3>
                    <p class="blurb">Đồng giá vé và ưu đãi đặc quyền dành riêng cho học sinh, sinh viên và giảng viên khi xuất trình thẻ tại quầy hoặc trực tuyến.</p>
                    <div style="display: flex; gap: 10px; margin-top: 15px;">
                        <a href="#" class="btn sm full" style="text-align: center;">Chi Tiết & Nhận Mã</a>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="card">
                <div class="poster poster-3" style="height: 220px;">
                    <span class="badge b-3d">BẮP NƯỚC</span>
                    <span class="age" style="position: absolute; top: 10px; right: 10px;">Hạn: 15/11/2026</span>
                </div>
                <div class="cinfo">
                    <p class="genre" style="color: var(--r);">COMBO TIẾT KIỆM</p>
                    <h3 style="margin: 0 0 8px; font-size: 18px; text-transform: uppercase;">Combo ZANEPN FAMILY - Tiết Kiệm 35%</h3>
                    <p class="blurb">Bao gồm 1 bắp lớn phô mai, 1 bắp caramel và 3 nước ngọt lớn. Thỏa sức xem phim cùng gia đình mà không lo về giá.</p>
                    <div style="display: flex; gap: 10px; margin-top: 15px;">
                        <a href="#" class="btn sm full" style="text-align: center;">Chi Tiết & Nhận Mã</a>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="card">
                <div class="poster poster-2" style="height: 220px;">
                    <span class="badge" style="background: #7c3aed;">THÀNH VIÊN VIP</span>
                    <span class="age" style="position: absolute; top: 10px; right: 10px;">Dài Hạn</span>
                </div>
                <div class="cinfo">
                    <p class="genre" style="color: var(--r);">ĐẶC QUYỀN HẠNG THẺ</p>
                    <h3 style="margin: 0 0 8px; font-size: 18px; text-transform: uppercase;">Nhân Đôi Điểm Tích Lũy Ngày Sinh Nhật</h3>
                    <p class="blurb">Tất cả thành viên VIP khi phát sinh giao dịch vé xem phim trong tháng sinh nhật sẽ được nhân đôi điểm thưởng vào tài khoản.</p>
                    <div style="display: flex; gap: 10px; margin-top: 15px;">
                        <a href="#" class="btn sm full" style="text-align: center;">Chi Tiết & Nhận Mã</a>
                    </div>
                </div>
            </div>

            <!-- Card 4 -->
            <div class="card">
                <div class="poster poster-4" style="height: 220px;">
                    <span class="badge" style="background: #0284c7;">SỰ KIỆN ĐẶC BIỆT</span>
                    <span class="age" style="position: absolute; top: 10px; right: 10px;">Hạn: 20/10/2026</span>
                </div>
                <div class="cinfo">
                    <p class="genre" style="color: var(--r);">CÔNG CHIẾU ĐẶC BIỆT</p>
                    <h3 style="margin: 0 0 8px; font-size: 18px; text-transform: uppercase;">Đêm Hội Cosplay Phim Bom Tấn Sci-Fi</h3>
                    <p class="blurb">Tham gia sự kiện công chiếu đặc biệt, hóa thân thành nhân vật yêu thích, nhận quà tặng poster giới hạn của phim.</p>
                    <div style="display: flex; gap: 10px; margin-top: 15px;">
                        <a href="#" class="btn sm full" style="text-align: center;">Chi Tiết & Nhận Mã</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>