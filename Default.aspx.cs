using System;
using System.Data;
using System.Web;
using System.Web.UI;

public partial class _Default : Page
{
    const int SoPhimBanDau = 3;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;

        // Xáo trộn ngẫu nhiên mỗi lần tải trang: 3 phim đầu hiện sẵn, phần còn lại ẩn đến khi bấm "Xem thêm"
        DataTable dt = Db.Query("SELECT * FROM Phim WHERE DangChieu = 1 AND An = 0 ORDER BY NEWID()");
        rptPhim.DataSource = dt;
        rptPhim.DataBind();
        pnlMore.Visible = dt.Rows.Count > SoPhimBanDau;
    }

    protected string Extra(int index)
    {
        return index >= SoPhimBanDau ? " more" : "";
    }

    protected string PosterStyle(object path)
    {
        string s = Convert.ToString(path);
        if (string.IsNullOrWhiteSpace(s)) return "";
        return "background-image:url('" + HttpUtility.HtmlAttributeEncode(ResolveUrl(s)) + "')";
    }

    protected string Badge(object nhan)
    {
        string s = Convert.ToString(nhan);
        return s == "" ? "" : "<span class='badge b-" + s.ToLower() + "'>" + s + "</span>";
    }
}