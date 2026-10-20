using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class ThanhToan : Page
{
    int maDon;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null) { Response.Redirect("~/DangNhap.aspx"); return; }
        if (!int.TryParse(Request.QueryString["madon"], out maDon)) { Response.Redirect("~/Default.aspx"); return; }

        if (!IsPostBack)
        {
            LoadDonHang();
        }
    }

    void LoadDonHang()
    {
        DataTable dt = Db.Query(
            "SELECT d.*, p.TenPhim, s.GioBatDau, pc.TenPhong, " +
            "(SELECT COUNT(*) FROM ChiTietDatVe c WHERE c.MaDon = d.MaDon) AS SoLuongVe, " +
            "STUFF((SELECT ', ' + g.Hang + CAST(g.SoGhe AS varchar(3)) FROM ChiTietDatVe c JOIN Ghe g ON g.MaGhe = c.MaGhe WHERE c.MaDon = d.MaDon ORDER BY g.Hang, g.SoGhe FOR XML PATH('')), 1, 2, '') AS DanhSachGhe " +
            "FROM DonDatVe d JOIN SuatChieu s ON s.MaSuat=d.MaSuat JOIN Phim p ON p.MaPhim=s.MaPhim JOIN PhongChieu pc ON pc.MaPhong=s.MaPhong WHERE d.MaDon=@id", Db.P("@id", maDon));

        if (dt.Rows.Count > 0)
        {
            DataRow r = dt.Rows[0];
            litTenPhim.Text = Server.HtmlEncode(r["TenPhim"].ToString());
            litSuatChieu.Text = ((DateTime)r["GioBatDau"]).ToString("HH:mm, dd/MM/yyyy");
            litPhong.Text = Server.HtmlEncode(r["TenPhong"].ToString());

            int sl = Convert.ToInt32(r["SoLuongVe"]);
            string ghe = Convert.ToString(r["DanhSachGhe"]);
            litSoLuong.Text = sl + " vé (" + ghe + ")";

            int tongTien = Convert.ToInt32(r["TongTien"]);
            litTienVe.Text = tongTien.ToString("N0") + "đ";
            litTongCong.Text = (tongTien + 10000).ToString("N0") + "đ";
        }
    }

    protected void btnThanhToanNgay_Click(object sender, EventArgs e)
    {
        // Sử dụng Db.Exec (đúng với lớp Db của dự án)
        Db.Exec("UPDATE DonDatVe SET TrangThai='DaThanhToan', TongTien = TongTien + 10000 WHERE MaDon=@id AND TrangThai='ChoThanhToan'", Db.P("@id", maDon));
        Response.Redirect("~/DatVeThanhCong.aspx?madon=" + maDon, true);
    }
}