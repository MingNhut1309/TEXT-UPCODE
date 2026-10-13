using System;
using System.Web.UI;

public partial class SiteMaster : MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bool dangNhap = Session["user"] != null;
        lnkLogin.Visible = !dangNhap;
        lnkLogout.Visible = dangNhap;
        lnkAdmin.Visible = Convert.ToString(Session["quyen"]) == "1";
        if (dangNhap)
            litUser.Text = "<span class='hello'>Xin chào, " + Db.H(Session["hoten"]) + "</span>";
    }
}
