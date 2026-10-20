using System.Configuration;

namespace QLMENUSS6
{
    // Bổ sung constructor không tham số cho NEWSDataContext.
    // Phải nằm CÙNG project với NEWS.designer.cs (partial class không thể
    // nằm ở 2 assembly khác nhau).
    public partial class NEWSDataContext
    {
        public NEWSDataContext() :
            base(ConfigurationManager.ConnectionStrings["NEWS5ConnectionString"].ConnectionString, mappingSource)
        {
            OnCreated();
        }
    }
}
