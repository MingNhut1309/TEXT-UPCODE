using System;
using System.Web.UI.WebControls;

public partial class AdminPhim : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) Bind();
    }

    void Bind()
    {
        rpt.DataSource = Db.Query("SELECT MaPhim, TenPhim, NamPhatHanh, NhanPhim, DoTuoi, An FROM Phim ORDER BY MaPhim");
        rpt.DataBind();
    }

    static object Vn(string s) { return string.IsNullOrWhiteSpace(s) ? null : s.Trim(); }

    protected void btnThem_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtTen.Text)) { lblMsg.Text = "Vui lòng nhập tên phim."; return; }

        object nam = null, tl = null;
        int v;
        if (!string.IsNullOrWhiteSpace(txtNam.Text))
        {
            if (!int.TryParse(txtNam.Text, out v) || v < 1900 || v > 2100) { lblMsg.Text = "Năm phát hành không hợp lệ."; return; }
            nam = v;
        }
        if (!string.IsNullOrWhiteSpace(txtTL.Text))
        {
            if (!int.TryParse(txtTL.Text, out v) || v <= 0) { lblMsg.Text = "Thời lượng không hợp lệ."; return; }
            tl = v;
        }

        int ma = Convert.ToInt32(Db.Query("SELECT ISNULL(MAX(MaPhim), 0) + 1 FROM Phim").Rows[0][0]);
        Db.Exec(
            "INSERT INTO Phim (MaPhim, ThuongHieu, TenPhim, TheLoai, NhanPhim, NamPhatHanh, LopPoster, ThoiLuong, DaoDien, MoTa, DoTuoi, DuongDanPoster, DangChieu, An) " +
            "VALUES (@ma, N'Marvel', @ten, @loai, @nhan, @nam, @lop, @tl, @dd, @mt, @tuoi, @poster, 1, 0)",
            Db.P("@ma", ma), Db.P("@ten", txtTen.Text.Trim()), Db.P("@loai", Vn(txtLoai.Text)),
            Db.P("@nhan", Vn(ddlNhan.SelectedValue)), Db.P("@nam", nam), Db.P("@lop", ddlPoster.SelectedValue),
            Db.P("@tl", tl), Db.P("@dd", Vn(txtDaoDien.Text)), Db.P("@mt", Vn(txtMoTa.Text)),
            Db.P("@tuoi", ddlTuoi.SelectedValue), Db.P("@poster", Vn(txtPoster.Text)));

        txtTen.Text = txtLoai.Text = txtDaoDien.Text = txtNam.Text = txtTL.Text = txtMoTa.Text = txtPoster.Text = "";
        lblMsg.Text = "";
        Bind();
    }

    protected void rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int ma;
        if (e.CommandName == "an" && int.TryParse(Convert.ToString(e.CommandArgument), out ma))
            Db.Exec("UPDATE Phim SET An = CASE WHEN An = 1 THEN 0 ELSE 1 END WHERE MaPhim=@id", Db.P("@id", ma));
        Bind();
    }
}
