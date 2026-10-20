using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

public partial class PhimChiTiet : Page
{
    int maPhim, maSuat;
    DataRow suat;   // suất chiếu đang chọn

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!int.TryParse(Request.QueryString["id"], out maPhim))
        {
            Response.Redirect("~/Default.aspx", true);
            return;
        }
        DataTable p = Db.Query("SELECT * FROM Phim WHERE MaPhim=@id AND An=0", Db.P("@id", maPhim));
        if (p.Rows.Count == 0)
        {
            Response.Redirect("~/Default.aspx", true);
            return;
        }
        DataRow f = p.Rows[0];
        Title = Convert.ToString(f["TenPhim"]);
        litInfo.Text = BuildInfo(f);
        BuildShowtimes();

        if (suat != null)
        {
            pnlSeat.Visible = true;
            BuildSeats();
            litSumHead.Text = "<p class='sumhead'><b>" + Db.H(f["TenPhim"]) + "</b><br />" +
                Db.H(suat["TenPhong"]) + " · " + ((DateTime)suat["GioBatDau"]).ToString("HH:mm dd/MM/yyyy") + "</p>";
        }
    }

    string BuildInfo(DataRow f)
    {
        var sb = new StringBuilder();
        string poster = Convert.ToString(f["DuongDanPoster"]);
        string style = poster == "" ? "" :
            " style=\"background-image:url('" + System.Web.HttpUtility.HtmlAttributeEncode(ResolveUrl(poster)) + "')\"";
        sb.Append("<div class='detail'>");
        sb.Append("<div class='poster big " + Db.H(f["LopPoster"]) + "'" + style + "></div>");
        sb.Append("<div class='dinfo'>");
        sb.Append("<h1>" + Db.H(f["TenPhim"]) + "</h1>");
        sb.Append("<p class='meta'><span class='age'>" + Db.H(f["DoTuoi"]) + "</span> · " + Db.H(f["NamPhatHanh"]) +
                  " · " + Db.H(f["ThoiLuong"]) + " phút · " + Db.H(f["TheLoai"]) + "</p>");
        sb.Append("<p><span class='muted'>Đạo diễn:</span> " + Db.H(f["DaoDien"]) + "</p>");
        sb.Append("<p class='desc'>" + Db.H(f["MoTa"]) + "</p>");
        string tr = Convert.ToString(f["DuongDanTrailer"]);
        if (tr.StartsWith("http://") || tr.StartsWith("https://"))
            sb.Append("<a class='btn ghost' target='_blank' rel='noopener' href=\"" +
                      System.Web.HttpUtility.HtmlAttributeEncode(tr) + "\">▶ Xem trailer</a>");
        sb.Append("</div></div>");
        return sb.ToString();
    }

    void BuildShowtimes()
    {
        int.TryParse(Request.QueryString["suat"], out maSuat);
        DataTable s = Db.Query(
            "SELECT s.MaSuat, s.MaPhong, s.GioBatDau, s.GiaVe, s.DinhDang, pc.TenPhong " +
            "FROM SuatChieu s JOIN PhongChieu pc ON pc.MaPhong = s.MaPhong " +
            "WHERE s.MaPhim=@id ORDER BY s.GioBatDau", Db.P("@id", maPhim));

        if (s.Rows.Count == 0)
        {
            litSuat.Text = "<p class='muted'>Phim chưa có suất chiếu.</p>";
            return;
        }

        var sb = new StringBuilder();
        DateTime? ngay = null;
        foreach (DataRow r in s.Rows)
        {
            DateTime t = (DateTime)r["GioBatDau"];
            if (ngay == null || ngay.Value != t.Date)
            {
                if (ngay != null) sb.Append("</div>");
                sb.Append("<div class='dayrow'><span class='day'>" + t.ToString("dddd, dd/MM/yyyy") + "</span>");
                ngay = t.Date;
            }
            int ms = (int)r["MaSuat"];
            bool act = ms == maSuat;
            if (act) suat = r;
            sb.AppendFormat("<a class='slot{0}' href='PhimChiTiet.aspx?id={1}&amp;suat={2}'><b>{3:HH:mm}</b><small>{4} · {5} · {6:N0}đ</small></a>",
                act ? " active" : "", maPhim, ms, t, Db.H(r["TenPhong"]), Db.H(r["DinhDang"]), r["GiaVe"]);
        }
        sb.Append("</div>");
        litSuat.Text = sb.ToString();
    }

    void BuildSeats()
    {
        int giaSuat = (int)suat["GiaVe"];
        DataTable g = Db.Query(
            "SELECT g.MaGhe, g.Hang, g.SoGhe, g.LoaiGhe, " +
            "CASE WHEN c.MaGhe IS NULL THEN 0 ELSE 1 END AS DaDat " +
            "FROM Ghe g LEFT JOIN ChiTietDatVe c ON c.MaGhe = g.MaGhe AND c.MaSuat = @s " +
            "WHERE g.MaPhong = @p ORDER BY g.Hang, g.SoGhe",
            Db.P("@s", maSuat), Db.P("@p", (int)suat["MaPhong"]));

        var sb = new StringBuilder();
        string hangCu = null;
        foreach (DataRow r in g.Rows)
        {
            string hang = Convert.ToString(r["Hang"]);
            if (hang != hangCu)
            {
                if (hangCu != null) sb.Append("</div>");
                sb.Append("<div class='srow'><span class='rl'>" + hang + "</span>");
                hangCu = hang;
            }
            string loai = Convert.ToString(r["LoaiGhe"]);
            int gia = Db.GiaGhe(giaSuat, loai);
            string cls = "seat " + loai.ToLower();
            string ten = hang + r["SoGhe"];
            if (Convert.ToInt32(r["DaDat"]) == 1)
                sb.AppendFormat("<span class='{0} taken' title='{1} · đã đặt'>{2}</span>", cls, ten, r["SoGhe"]);
            else
                sb.AppendFormat("<button type='button' class='{0}' data-id='{1}' data-name='{2}' data-price='{3}' title='{2} · {3:N0}đ'>{4}</button>",
                    cls, r["MaGhe"], ten, gia, r["SoGhe"]);
        }
        if (hangCu != null) sb.Append("</div>");
        litGhe.Text = sb.ToString();
    }

    protected void btnDat_Click(object sender, EventArgs e)
    {
        if (Session["user"] == null)
        {
            Response.Redirect("~/DangNhap.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl), true);
            return;
        }
        if (suat == null) { lblMsg.Text = "Vui lòng chọn suất chiếu."; return; }

        var ids = new List<int>();
        foreach (string x in hfGhe.Value.Split(','))
        {
            int v;
            if (int.TryParse(x, out v) && !ids.Contains(v)) ids.Add(v);
        }
        if (ids.Count == 0) { lblMsg.Text = "Vui lòng chọn ít nhất một ghế."; return; }
        if (ids.Count > 8) { lblMsg.Text = "Tối đa 8 ghế mỗi đơn."; return; }

        int maPhong = (int)suat["MaPhong"], giaSuat = (int)suat["GiaVe"];
        string user = (string)Session["user"];
        int maDonMoi = 0;

        using (var cn = new SqlConnection(Db.ConnStr))
        {
            cn.Open();
            using (SqlTransaction tx = cn.BeginTransaction())
            {
                try
                {
                    var gia = new List<int>();
                    int tong = 0;
                    foreach (int id in ids)
                    {
                        var c = new SqlCommand("SELECT LoaiGhe FROM Ghe WHERE MaGhe=@g AND MaPhong=@p", cn, tx);
                        c.Parameters.AddWithValue("@g", id);
                        c.Parameters.AddWithValue("@p", maPhong);
                        object loai = c.ExecuteScalar();
                        if (loai == null) throw new InvalidOperationException("Ghế không hợp lệ.");
                        int gv = Db.GiaGhe(giaSuat, (string)loai);
                        gia.Add(gv);
                        tong += gv;
                    }

                    var ins = new SqlCommand(
                        "INSERT INTO DonDatVe (TenDangNhap, MaSuat, TongTien, TrangThai) " +
                        "OUTPUT INSERTED.MaDon VALUES (@u, @s, @t, 'ChoThanhToan')", cn, tx);
                    ins.Parameters.AddWithValue("@u", user);
                    ins.Parameters.AddWithValue("@s", maSuat);
                    ins.Parameters.AddWithValue("@t", tong);
                    int maDon = (int)ins.ExecuteScalar();

                    for (int i = 0; i < ids.Count; i++)
                    {
                        var d = new SqlCommand(
                            "INSERT INTO ChiTietDatVe (MaDon, MaSuat, MaGhe, GiaVe) VALUES (@d, @s, @g, @gv)", cn, tx);
                        d.Parameters.AddWithValue("@d", maDon);
                        d.Parameters.AddWithValue("@s", maSuat);
                        d.Parameters.AddWithValue("@g", ids[i]);
                        d.Parameters.AddWithValue("@gv", gia[i]);
                        d.ExecuteNonQuery();
                    }
                    tx.Commit();
                    maDonMoi = maDon;
                }
                catch (SqlException ex)
                {
                    tx.Rollback();
                    // Mã lỗi 2627 / 2601: Trùng khóa UNIQUE khi ghế vừa bị người khác đặt mất
                    lblMsg.Text = (ex.Number == 2627 || ex.Number == 2601)
                        ? "Có ghế vừa được người khác đặt. Vui lòng chọn lại."
                        : "Không thể đặt vé, vui lòng thử lại.";
                }
                catch (InvalidOperationException ex)
                {
                    tx.Rollback();
                    lblMsg.Text = ex.Message;
                }
            }
        }

        if (maDonMoi > 0)
            Response.Redirect("~/ThanhToan.aspx?madon=" + maDonMoi, true);
        else
            BuildSeats();
    }
}