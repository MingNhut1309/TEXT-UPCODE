using System;
using System.Data;
using System.Web.UI;

public partial class DangNhap : Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        DataTable dt = Db.Query(
            "SELECT TenDangNhap, HoTen, QuyenHan FROM TaiKhoan WHERE TenDangNhap=@u AND MatKhau=@p AND HoatDong=1",
            Db.P("@u", txtUser.Text.Trim()), Db.P("@p", txtPass.Text));

        if (dt.Rows.Count == 0)
        {
            lblMsg.Text = "Sai tên đăng nhập hoặc mật khẩu.";
            return;
        }

        DataRow r = dt.Rows[0];
        Session["user"] = Convert.ToString(r["TenDangNhap"]);
        Session["hoten"] = Convert.ToString(r["HoTen"]);
        Session["quyen"] = Convert.ToInt32(r["QuyenHan"]);

        string back = Request.QueryString["returnUrl"];
        bool noiBo = !string.IsNullOrEmpty(back) && back.StartsWith("/") && !back.StartsWith("//") && !back.StartsWith("/\\");
        if (noiBo) Response.Redirect(back);
        else if (Convert.ToInt32(r["QuyenHan"]) == 1) Response.Redirect("~/Admin/Phim.aspx");
        else Response.Redirect("~/Default.aspx");
    }
}
