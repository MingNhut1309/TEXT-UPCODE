using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

/// <summary>Lớp truy cập dữ liệu dùng chung (ADO.NET, truy vấn có tham số).</summary>
public static class Db
{
    public static string ConnStr
    {
        get { return ConfigurationManager.ConnectionStrings["CINEMA"].ConnectionString; }
    }

    public static SqlParameter P(string name, object value)
    {
        return new SqlParameter(name, value ?? DBNull.Value);
    }

    public static DataTable Query(string sql, params SqlParameter[] ps)
    {
        using (var cn = new SqlConnection(ConnStr))
        using (var cmd = new SqlCommand(sql, cn))
        {
            cmd.Parameters.AddRange(ps);
            var dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
    }

    public static int Exec(string sql, params SqlParameter[] ps)
    {
        using (var cn = new SqlConnection(ConnStr))
        using (var cmd = new SqlCommand(sql, cn))
        {
            cmd.Parameters.AddRange(ps);
            cn.Open();
            return cmd.ExecuteNonQuery();
        }
    }

    /// <summary>Giá ghế: thường = giá suất, VIP = +20%, đôi = x2.</summary>
    public static int GiaGhe(int giaSuat, string loaiGhe)
    {
        if (loaiGhe == "VIP") return giaSuat * 12 / 10;
        if (loaiGhe == "Doi") return giaSuat * 2;
        return giaSuat;
    }

    public static string H(object o)
    {
        return System.Web.HttpUtility.HtmlEncode(Convert.ToString(o));
    }

    public static string TrangThaiText(object tt)
    {
        switch (Convert.ToString(tt))
        {
            case "DaThanhToan": return "Đã thanh toán";
            case "DaHuy": return "Đã hủy";
            default: return "Chờ thanh toán";
        }
    }

    /// <summary>Truy vấn danh sách đơn (nối thêm WHERE / ORDER BY phía sau).</summary>
    public const string DonSelect =
        "SELECT d.MaDon, d.TenDangNhap, d.ThoiGianDat, d.TongTien, d.TrangThai, " +
        "p.TenPhim, s.GioBatDau, pc.TenPhong, " +
        "STUFF((SELECT ', ' + g.Hang + CAST(g.SoGhe AS varchar(3)) " +
        "       FROM ChiTietDatVe c JOIN Ghe g ON g.MaGhe = c.MaGhe " +
        "       WHERE c.MaDon = d.MaDon ORDER BY g.Hang, g.SoGhe FOR XML PATH('')), 1, 2, '') AS DanhSachGhe " +
        "FROM DonDatVe d " +
        "JOIN SuatChieu s ON s.MaSuat = d.MaSuat " +
        "JOIN Phim p ON p.MaPhim = s.MaPhim " +
        "JOIN PhongChieu pc ON pc.MaPhong = s.MaPhong ";

    /// <summary>Thanh toán hoặc hủy đơn (hủy thì giải phóng ghế). user = null nghĩa là quản trị.</summary>
    public static void XuLyDon(string lenh, int maDon, string user)
    {
        string dk = user == null ? "" : " AND TenDangNhap=@u";
        if (lenh == "pay")
        {
            Exec("UPDATE DonDatVe SET TrangThai='DaThanhToan' WHERE MaDon=@d AND TrangThai='ChoThanhToan'" + dk,
                 P("@d", maDon), P("@u", user));
        }
        else if (lenh == "cancel")
        {
            Exec("UPDATE DonDatVe SET TrangThai='DaHuy' WHERE MaDon=@d AND TrangThai='ChoThanhToan'" + dk + "; " +
                 "IF @@ROWCOUNT > 0 DELETE FROM ChiTietDatVe WHERE MaDon=@d;",
                 P("@d", maDon), P("@u", user));
        }
    }
}

/// <summary>Trang cơ sở: chỉ quản trị (QuyenHan = 1) mới vào được.</summary>
public class AdminPage : System.Web.UI.Page
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        if (Convert.ToString(Session["quyen"]) != "1")
            Response.Redirect("~/DangNhap.aspx", true);
    }
}
