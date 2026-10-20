<%@ Page Title="Thanh toán đơn hàng" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ThanhToan.aspx.cs" Inherits="ThanhToan" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
<div class="wrap thanh-toan-page" style="padding-bottom: 60px;">
    
    <!-- Tiêu đề đỏ đầu trang -->
    <div style="background: #e50914; padding: 18px 20px; text-align: center; margin: 20px 0 35px 0; border-radius: 4px;">
        <h1 style="margin: 0; color: #fff; font-size: 26px; font-weight: 900; letter-spacing: 1px; text-transform: uppercase;">THANH TOÁN ĐƠN HÀNG</h1>
    </div>

    <div class="checkout-container" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; max-width: 1050px; margin: 0 auto;">
        
        <!-- BÊN TRÁI: Thông tin vé & QR Code từ file ảnh -->
        <div class="checkout-box" style="background: #18181c; border: 1px solid #2a2a30; border-radius: 8px; overflow: hidden;">
            <div style="background: #e50914; color: #fff; padding: 12px 20px; font-weight: bold; font-size: 16px; text-transform: uppercase;">
                Thông Tin Vé
            </div>
            
            <div style="padding: 20px;">
                <div style="display: flex; flex-direction: column; gap: 8px; margin-bottom: 15px; font-size: 14px; color: #ddd;">
                    <div>Phim: <b style="color: #fff;"><asp:Literal ID="litTenPhim" runat="server" /></b></div>
                    <div>Suất Chiếu: <asp:Literal ID="litSuatChieu" runat="server" /></div>
                    <div>Phòng: <asp:Literal ID="litPhong" runat="server" /></div>
                    <div>Số lượng: <asp:Literal ID="litSoLuong" runat="server" /></div>
                </div>

                <hr style="border: 0; border-top: 1px solid #2a2a30; margin: 15px 0;" />

                <div style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 14px; color: #ccc;">
                    <span>Tổng Tiền Vé:</span>
                    <b style="color: #fff;"><asp:Literal ID="litTienVe" runat="server" /></b>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 14px; color: #ccc;">
                    <span>Phí Dịch Vụ:</span>
                    <b style="color: #fff;">10.000đ</b>
                </div>
                <div style="display: flex; justify-content: space-between; font-size: 18px; font-weight: bold; border-top: 1px solid #2a2a30; padding-top: 12px;">
                    <span style="color: #fff;">Tổng Cộng:</span>
                    <span style="color: #e50914;"><asp:Literal ID="litTongCong" runat="server" /></span>
                </div>
                
                <!-- Khu vực Mã QR từ file ảnh thực tế -->
                <div style="text-align: center; margin-top: 20px; border-top: 1px dashed #333; padding-top: 15px;">
                    <div style="background: #fff; display: inline-block; padding: 10px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.4);">
                        <img src="Content/images/qrcode.png" alt="QR Code Thanh Toán" style="width: 140px; height: 140px; display: block;" />
                    </div>

                    <p style="color: #bbb; font-size: 13px; margin: 12px 0 15px 0;">Quét mã QR để thanh toán</p>
                    
                    <div style="display: flex; justify-content: center; gap: 8px; align-items: center; flex-wrap: wrap;">
                        <span style="background: #ae1153; color: #fff; padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: bold;">momo</span>
                        <span style="background: #0068ff; color: #fff; padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: bold;">ZaloPay</span>
                        <span style="background: #00377b; color: #fff; padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: bold;">VNPay</span>
                        <span style="background: #006b3f; color: #fff; padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: bold;">Vietcombank</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- BÊN PHẢI: Chọn Phương Thức Thanh Toán -->
        <div class="checkout-box" style="background: #18181c; border: 1px solid #2a2a30; border-radius: 8px; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between;">
            <div>
                <div style="background: #e50914; color: #fff; padding: 12px 20px; font-weight: bold; font-size: 16px; text-transform: uppercase;">
                    Chọn Phương Thức Thanh Toán
                </div>

                <div style="padding: 20px;">
                    <div class="payment-methods" style="display: flex; flex-direction: column; gap: 10px;">
                        <label class="pm-item" style="background: #222228; padding: 12px 15px; border-radius: 6px; cursor: pointer; display: flex; align-items: center; gap: 12px; color: #fff; border: 1px solid #333;">
                            <input type="radio" name="payment" checked="checked" /> 💳 Thẻ Quốc tế (Visa/Mastercard)
                        </label>
                        <label class="pm-item" style="background: #222228; padding: 12px 15px; border-radius: 6px; cursor: pointer; display: flex; align-items: center; gap: 12px; color: #fff; border: 1px solid #333;">
                            <input type="radio" name="payment" /> 🏧 Thẻ ATM nội địa (Internet Banking)
                        </label>
                        <label class="pm-item" style="background: #222228; padding: 12px 15px; border-radius: 6px; cursor: pointer; display: flex; align-items: center; gap: 12px; color: #fff; border: 1px solid #333;">
                            <input type="radio" name="payment" /> 📱 Ví MoMo
                        </label>
                        <label class="pm-item" style="background: #222228; padding: 12px 15px; border-radius: 6px; cursor: pointer; display: flex; align-items: center; gap: 12px; color: #fff; border: 1px solid #333;">
                            <input type="radio" name="payment" /> 📱 Ví ZaloPay
                        </label>
                        <label class="pm-item" style="background: #222228; padding: 12px 15px; border-radius: 6px; cursor: pointer; display: flex; align-items: center; gap: 12px; color: #fff; border: 1px solid #333;">
                            <input type="radio" name="payment" /> 📱 Ví VNPT Money
                        </label>
                        <label class="pm-item" style="background: #222228; padding: 12px 15px; border-radius: 6px; cursor: pointer; display: flex; align-items: center; gap: 12px; color: #fff; border: 1px solid #333;">
                            <input type="radio" name="payment" /> 🎟️ Thanh toán tại quầy
                        </label>
                    </div>
                </div>
            </div>

            <div style="padding: 20px; border-top: 1px solid #2a2a30;">
                <div style="margin-bottom: 15px; text-align: right;">
                    <div style="color: #888; font-size: 14px; text-decoration: line-through;"><asp:Literal ID="litTienVeBot" runat="server" /></div>
                    <div style="color: #e50914; font-size: 24px; font-weight: bold;"><asp:Literal ID="litTongCongBot" runat="server" /></div>
                </div>

                <asp:Button ID="btnThanhToanNgay" runat="server" Text="THANH TOÁN NGAY" CssClass="btn full red-btn" OnClick="btnThanhToanNgay_Click" style="width: 100%; background: #e50914; color: #fff; font-weight: bold; padding: 14px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-transform: uppercase;" />
                <p style="text-align: center; color: #888; font-size: 12px; margin-top: 12px;">🔒 Đảm bảo an toàn và bảo mật 100%</p>
            </div>
        </div>
    </div>
</div>
</asp:Content>