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
        DataTable dt = Db.Query(Db.DonSelect + "WHERE d.TenDangNhap=@u ORDER BY d.MaDon DESC",
                                Db.P("@u", (string)Session["user"]));
        rpt.DataSource = dt;
        rpt.DataBind();
        lblTrong.Visible = dt.Rows.Count == 0;
    }

    protected void rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int ma;
        if (int.TryParse(Convert.ToString(e.CommandArgument), out ma))
            Db.XuLyDon(e.CommandName, ma, (string)Session["user"]);
        Bind();
    }
}
