<%@ Page Title="ZANEPN CINEMA" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ContentPlaceHolderID="main" runat="server">

    <section class="hero">
        <div class="wrap">
            <div class="eyebrow">ZANEPN CINEMA PRESENTS</div>
            <h1>Trải nghiệm<br />điện ảnh<br /><em>đỉnh cao</em></h1>
            <p class="sub">Khám phá những bộ phim mới nhất tại ZANEPN Cinema.</p>
            <div class="cta">
                <a class="btn" href="#phim">Xem phim đề xuất</a>
                <a class="btn outline" href="~/LichSuDat.aspx" runat="server">Vé của tôi</a>
            </div>
        </div>
        <a class="scroll" href="#phim">↓ Khám phá</a>
    </section>

    <div class="wrap" id="phim">
        <div class="sec-head">
            <div>
                <div class="eyebrow">GỢI Ý CHO BẠN</div>
                <h2>Phim đề xuất</h2>
            </div>
            <span class="note">3 bộ phim được chọn ngẫu nhiên · Khám phá thêm bên dưới</span>
        </div>

        <div class="grid" id="gridPhim">
            <asp:Repeater ID="rptPhim" runat="server">
                <ItemTemplate>
                    <a class="card<%# Extra(Container.ItemIndex) %>" href="PhimChiTiet.aspx?id=<%# Eval("MaPhim") %>">
                        <div class="poster <%# Eval("LopPoster") %>" style="<%# PosterStyle(Eval("DuongDanPoster")) %>">
                            <%# Badge(Eval("NhanPhim")) %>
                            <span class="age"><%#: Eval("DoTuoi") %></span>
                            <div class="ptitle"><%#: Eval("TenPhim") %>
                                <small><%# Eval("NamPhatHanh") %> · <%# Eval("ThoiLuong") %> phút</small>
                            </div>
                        </div>
                        <div class="cinfo">
                            <p class="genre"><%#: Eval("TheLoai") %></p>
                            <p class="blurb"><%#: Eval("MoTa") %></p>
                            <span class="btn sm">Đặt vé</span>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Panel ID="pnlMore" runat="server" CssClass="morewrap">
            <button type="button" id="btnMore" class="btn outline big">Hiện tất cả phim</button>
        </asp:Panel>
    </div>

    <section class="promo">
        <div class="eyebrow light">ƯU ĐÃI ĐẶC BIỆT</div>
        <h2>Thứ 4 hàng tuần</h2>
        <p>Vé chỉ từ 90.000đ</p>
        <a class="btn white" href="#phim">Xem chi tiết</a>
    </section>

    <div class="wrap feats">
        <div class="feat"><div class="ico">🎬</div><h4>Phòng chiếu hiện đại</h4><p>Hệ thống phòng chiếu 2D, 3D và IMAX chất lượng cao.</p></div>
        <div class="feat"><div class="ico">🔊</div><h4>Âm thanh đỉnh cao</h4><p>Trải nghiệm âm thanh sống động.</p></div>
        <div class="feat"><div class="ico">💺</div><h4>Ghế ngồi cao cấp</h4><p>Ghế thường, VIP và ghế đôi thoải mái cho mọi khán giả.</p></div>
    </div>

    <script>
    (function () {
        var btn = document.getElementById('btnMore');
        var grid = document.getElementById('gridPhim');
        if (!btn) return;
        btn.addEventListener('click', function () {
            var open = grid.classList.toggle('open');
            btn.textContent = open ? 'Thu gọn danh sách' : 'Hiện tất cả phim';
            if (!open) document.getElementById('phim').scrollIntoView();
        });
    })();
    </script>
</asp:Content>
