using System;
using System.Data;

public partial class DatVeThanhCong : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] == null) { Response.Redirect("~/DangNhap.aspx"); return; }
        int maDon;
        if (!int.TryParse(Request.QueryString["madon"], out maDon)) { Response.Redirect("~/Default.aspx"); return; }

        if (!IsPostBack)
        {
            DataTable dt = Db.Query(Db.DonSelect + "WHERE d.MaDon=@id", Db.P("@id", maDon));
            if (dt.Rows.Count > 0)
            {
                DataRow r = dt.Rows[0];
                litMaDon.Text = r["MaDon"].ToString();
                litTenPhim.Text = Server.HtmlEncode(r["TenPhim"].ToString());
                litSuatChieu.Text = ((DateTime)r["GioBatDau"]).ToString("HH:mm, dd/MM/yyyy");
                litPhong.Text = Server.HtmlEncode(r["TenPhong"].ToString());
                litDanhSachGhe.Text = Server.HtmlEncode(r["DanhSachGhe"].ToString());
                litTongTien.Text = Convert.ToInt32(r["TongTien"]).ToString("N0") + "đ";
            }
        }
    }
}