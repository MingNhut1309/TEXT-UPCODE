using System;
using System.Data;
using System.Web.UI;

public partial class DangKy : Page
{
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string user = txtUser.Text.Trim();
        string hoTen = txtHoTen.Text.Trim();
        string emailOrPhone = txtEmail.Text.Trim();
        string pass = txtPass.Text;
        string confirmPass = txtConfirmPass.Text;

        // 1. Kiểm tra các trường trống
        if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(emailOrPhone) || string.IsNullOrEmpty(pass))
        {
            lblMsg.Text = "Vui lòng điền đầy đủ tất cả các thông tin.";
            return;
        }

        // 2. Kiểm tra khớp mật khẩu
        if (pass != confirmPass)
        {
            lblMsg.Text = "Mật khẩu nhập lại không khớp.";
            return;
        }

        // 3. Kiểm tra xem TenDangNhap đã tồn tại trong CSDL chưa
        DataTable dtCheck = Db.Query("SELECT TenDangNhap FROM TaiKhoan WHERE TenDangNhap = @u", Db.P("@u", user));
        if (dtCheck.Rows.Count > 0)
        {
            lblMsg.Text = "Tên đăng nhập này đã tồn tại. Vui lòng chọn tên khác.";
            return;
        }

        // 4. Phân loại Email hoặc Số điện thoại để lưu vào đúng cột tương ứng
        string emailVal = emailOrPhone.Contains("@") ? emailOrPhone : null;
        string phoneVal = !emailOrPhone.Contains("@") ? emailOrPhone : null;

        try
        {
            // Thêm tài khoản mới với quyền mặc định là 0 (khách hàng)
            int rowsAffected = Db.Exec(
                "INSERT INTO TaiKhoan (TenDangNhap, MatKhau, HoTen, QuyenHan, Email, SoDienThoai, HoatDong, NgayTao) " +
                "VALUES (@u, @p, @name, 0, @email, @phone, 1, GETDATE())",
                Db.P("@u", user),
                Db.P("@p", pass),
                Db.P("@name", hoTen),
                Db.P("@email", emailVal ?? (object)DBNull.Value),
                Db.P("@phone", phoneVal ?? (object)DBNull.Value)
            );

            if (rowsAffected > 0)
            {
                // Đăng ký thành công -> Tự động đăng nhập vào session và chuyển về trang chủ
                Session["user"] = user;
                Session["hoten"] = hoTen;
                Session["quyen"] = 0;

                Response.Redirect("~/Default.aspx", true);
            }
            else
            {
                lblMsg.Text = "Đăng ký không thành công. Vui lòng thử lại.";
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Lỗi hệ thống: " + ex.Message;
        }
    }
}