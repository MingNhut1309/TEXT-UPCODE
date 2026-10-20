using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LichSuDat : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("~/DangNhap.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl), true);
            return;
        }
        if (!IsPostBack) Bind();
    }

    void Bind()
    {
        DataTable dt = Db.Query(
            "SELECT d.MaDon, d.TenDangNhap, d.ThoiGianDat, d.TongTien, d.TrangThai, " +
            "p.TenPhim, p.LopPoster, p.TheLoai, s.GioBatDau, pc.TenPhong, " +
            "STUFF((SELECT ', ' + g.Hang + CAST(g.SoGhe AS varchar(3)) " +
            "       FROM ChiTietDatVe c JOIN Ghe g ON g.MaGhe = c.MaGhe " +
            "       WHERE c.MaDon = d.MaDon ORDER BY g.Hang, g.SoGhe FOR XML PATH('')), 1, 2, '') AS DanhSachGhe " +
            "FROM DonDatVe d " +
            "JOIN SuatChieu s ON s.MaSuat = d.MaSuat " +
            "JOIN Phim p ON p.MaPhim = s.MaPhim " +
            "JOIN PhongChieu pc ON pc.MaPhong = s.MaPhong " +
            "WHERE d.TenDangNhap=@u ORDER BY d.MaDon DESC",
            Db.P("@u", (string)Session["user"]));

        rpt.DataSource = dt;
        rpt.DataBind();
        lblTrong.Visible = dt.Rows.Count == 0;
        litCountActive.Text = dt.Rows.Count.ToString();
    }

    protected void rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int ma;
        if (int.TryParse(Convert.ToString(e.CommandArgument), out ma))
            Db.XuLyDon(e.CommandName, ma, (string)Session["user"]);
        Bind();
    }
}