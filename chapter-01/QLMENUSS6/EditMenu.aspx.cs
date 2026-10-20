using QLMENUSS6;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace QUANLIMENU
{
    public partial class EditMenu : System.Web.UI.Page
    {
        // Chạy: EditMenu.aspx?idmn=17
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadDataDropDownList();
                if (Request.QueryString["idmn"] != null)
                {
                    Session["idmn"] = Request.QueryString["idmn"];
                    loadMenu();
                }
                txtID_MN.ReadOnly = true;   // khóa khóa chính, không cho sửa
            }
        }

        private void LoadDataDropDownList()
        {
            NEWSDataContext context = new NEWSDataContext();
            var menus = from m in context.Menus where (m.Parent == 0) orderby m.OrderKey select m;
            DropDownList1.DataSource = menus.ToList();
            DropDownList1.DataTextField = "Lable";
            DropDownList1.DataValueField = "ID_MN";
            DropDownList1.DataBind();
            // Nếu thiếu mục này, sửa menu CHA sẽ bị biến thành menu con của mục đầu tiên
            DropDownList1.Items.Insert(0, new ListItem("-- Menu gốc (cha) --", "0"));
        }

        // Hàm đọc dữ liệu
        private void loadMenu()
        {
            NEWSDataContext context = new NEWSDataContext();
            int id;
            if (!int.TryParse(Convert.ToString(Session["idmn"]), out id))
            {
                lblMessage.Text = "idmn không hợp lệ!";
                return;
            }
            Menus m = context.Menus.SingleOrDefault(mu => mu.ID_MN == id);
            if (m != null)
            {
                txtID_MN.Text = m.ID_MN.ToString();
                txtLable.Text = m.Lable;
                txtPos.Text = m.Pos.ToString();
                // Menu không thể là cha của chính nó
                ListItem self = DropDownList1.Items.FindByValue(m.ID_MN.ToString());
                if (self != null) DropDownList1.Items.Remove(self);
                ListItem cur = DropDownList1.Items.FindByValue((m.Parent ?? 0).ToString());
                if (cur != null) DropDownList1.SelectedValue = cur.Value;
            }
            else
                lblMessage.Text = "Không tìm thấy menu có ID_MN = " + id;
        }

        // Hàm cập nhật dữ liệu
        protected void butSave_Click(object sender, EventArgs e)
        {
            try
            {
                NEWSDataContext context = new NEWSDataContext();
                int id = Convert.ToInt32(Session["idmn"]);
                Menus m = context.Menus.SingleOrDefault(mu => mu.ID_MN == id);
                if (m != null)
                {
                    m.Lable = txtLable.Text.Trim();
                    m.Pos = Convert.ToInt32(txtPos.Text);
                    m.Parent = Convert.ToInt32(DropDownList1.SelectedItem.Value);
                    context.SubmitChanges();
                    lblMessage.Text = "Lưu thành công!";
                }
                else
                    lblMessage.Text = "Lưu không thành công!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lưu không thành công! " + ex.Message;
            }
        }
    }
}
