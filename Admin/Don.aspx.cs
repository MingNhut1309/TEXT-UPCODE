using System;
using System.Web.UI.WebControls;

public partial class AdminDon : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) Bind();
    }

    void Bind()
    {
        rpt.DataSource = Db.Query(Db.DonSelect + "ORDER BY d.MaDon DESC");
        rpt.DataBind();
    }

    protected void rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int ma;
        if (int.TryParse(Convert.ToString(e.CommandArgument), out ma))
            Db.XuLyDon(e.CommandName, ma, null);
        Bind();
    }
}
