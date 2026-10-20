using QLMENUSS6;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace QUANLIMENU
{
    public partial class AddMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) LoadDataDropDownList();
        }

        private void LoadDataDropDownList()
        {
            NEWSDataContext context = new NEWSDataContext();
            var menus = from m in context.Menus where (m.Parent == 0) orderby m.OrderKey select m;
            DropDownList1.DataSource = menus.ToList();
            DropDownList1.DataTextField = "Lable";
            DropDownList1.DataValueField = "ID_MN";
            DropDownList1.DataBind();
            // Cho phép thêm menu CẤP CHA (Parent = 0)
            DropDownList1.Items.Insert(0, new ListItem("-- Menu gốc (cha) --", "0"));
        }

        protected void butSave_Click(object sender, EventArgs e)
        {
            try
            {
                NEWSDataContext context = new NEWSDataContext();

                int id = Convert.ToInt32(txtID_MN.Text);
                if (context.Menus.Any(x => x.ID_MN == id))
                {
                    lblMessage.Text = "ID_MN " + id + " đã tồn tại!";
                    return;
                }

                int pos = Convert.ToInt32(txtPos.Text);

                Menus menu = new Menus();
                menu.ID_MN = id;
                menu.Lable = txtLable.Text.Trim();
                menu.Pos = pos;
                menu.Parent = Convert.ToInt32(DropDownList1.SelectedItem.Value);
                // LINQ to SQL gửi NULL cho cột không gán -> không dùng DEFAULT của SQL,
                // nên phải gán giá trị mặc định ở đây.
                menu.UrlLink = "#";
                menu.OrderKey = pos;
                menu.UserAdd = "ltngoc";   // phải tồn tại trong bảng Acounts (hoặc để null)
                menu.Hide = 0;

                context.Menus.InsertOnSubmit(menu);
                context.SubmitChanges();
                lblMessage.Text = "Lưu thành công!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lưu không thành công! " + ex.Message;
            }
        }
    }
}
