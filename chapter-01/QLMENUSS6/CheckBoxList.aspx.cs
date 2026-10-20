using QLMENUSS6;
using System;
using System.Linq;

namespace QUANLIMENU
{
    public partial class CheckBoxListPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) LoadDataCheckBoxList();
        }

        private void LoadDataCheckBoxList()
        {
            NEWSDataContext context = new NEWSDataContext();
            var menus = from m in context.Menus where (m.Parent != 0) select m;
            CheckBoxList1.DataSource = menus.ToList();
            CheckBoxList1.DataTextField = "Lable";
            CheckBoxList1.DataValueField = "ID_MN";
            CheckBoxList1.RepeatColumns = 3;   // hiển thị 3 cột
            CheckBoxList1.DataBind();
        }

        protected void butSelect_Click(object sender, EventArgs e)
        {
            CheckBoxList2.Items.Clear();       // tránh bị lặp khi bấm Select nhiều lần
            for (int i = 0; i < CheckBoxList1.Items.Count; i++)
                if (CheckBoxList1.Items[i].Selected)
                    CheckBoxList2.Items.Add(new System.Web.UI.WebControls.ListItem(
                        CheckBoxList1.Items[i].Text, CheckBoxList1.Items[i].Value));
        }
    }
}
