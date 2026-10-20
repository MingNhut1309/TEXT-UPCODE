<%@ Page Title="Chi tiết phim" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PhimChiTiet.aspx.cs" Inherits="PhimChiTiet" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
<div class="wrap">
    <asp:Literal ID="litInfo" runat="server" />

    <h2 class="sec">Chọn suất chiếu</h2>
    <asp:Literal ID="litSuat" runat="server" />

    <asp:Panel ID="pnlSeat" runat="server" Visible="false">
        <h2 class="sec">Chọn ghế</h2>
        <div class="booking">
            <div class="seatbox">
                <div class="screen">MÀN HÌNH</div>
                <asp:Literal ID="litGhe" runat="server" />
                <div class="legend">
                    <span><i class="seat thuong"></i> Thường</span>
                    <span><i class="seat vip"></i> VIP (+20%)</span>
                    <span><i class="seat doi"></i> Đôi (x2)</span>
                    <span><i class="seat sel"></i> Đang chọn</span>
                    <span><i class="seat taken"></i> Đã đặt</span>
                </div>
            </div>
            <aside class="summary">
                <h3>Tóm tắt đặt vé</h3>
                <asp:Literal ID="litSumHead" runat="server" />
                <dl>
                    <dt>Ghế</dt><dd id="sumSeats">—</dd>
                    <dt>Số lượng</dt><dd id="sumQty">0</dd>
                    <dt class="total">Tổng tiền</dt><dd class="total" id="sumTotal">0đ</dd>
                </dl>
                <asp:HiddenField ID="hfGhe" runat="server" />
                <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
                <asp:Button ID="btnDat" runat="server" Text="Đặt vé" CssClass="btn full" OnClick="btnDat_Click" />
                <p class="hint">Tối đa 8 ghế mỗi đơn. Đơn mới ở trạng thái "Chờ thanh toán".</p>
            </aside>
        </div>
    </asp:Panel>
</div>

<script>
(function () {
    var hf = document.getElementById('<%= hfGhe.ClientID %>');
    if (!hf) return;
    hf.value = '';
    var sel = {};
    function fmt(n) { return n.toLocaleString('vi-VN') + 'đ'; }
    function update() {
        var ids = [], names = [], total = 0;
        for (var k in sel) { ids.push(k); names.push(sel[k].n); total += sel[k].p; }
        hf.value = ids.join(',');
        document.getElementById('sumSeats').textContent = names.join(', ') || '—';
        document.getElementById('sumQty').textContent = ids.length;
        document.getElementById('sumTotal').textContent = fmt(total);
    }
    document.querySelectorAll('.seatbox button.seat').forEach(function (b) {
        b.addEventListener('click', function () {
            var id = b.getAttribute('data-id');
            if (sel[id]) { delete sel[id]; b.classList.remove('sel'); }
            else {
                if (Object.keys(sel).length >= 8) { alert('Tối đa 8 ghế mỗi đơn.'); return; }
                sel[id] = { n: b.getAttribute('data-name'), p: parseInt(b.getAttribute('data-price'), 10) };
                b.classList.add('sel');
            }
            update();
        });
    });
})();
</script>
</asp:Content>
