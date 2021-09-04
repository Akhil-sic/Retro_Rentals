using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Products : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

            if (!IsPostBack)
            {
                BindProductRepeater();

            }

    }
    private void BindProductRepeater()
    {
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("procBindAllProducts", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrProducts.DataSource = dt;
                    rptrProducts.DataBind();
                    if (dt.Rows.Count <= 0)
                    {
                        Label1.Text = "Sorry! Currently no products in this category.";
                    }
                    else
                    {
                        Label1.Text = "Showing All Products";
                    }
                }
            }
        }
    }

    protected void txtFilterGrid1Record_TextChanged(object sender, EventArgs e)
    {
        if (txtFilterGrid1Record.Text != string.Empty)
        {
            SqlConnection con = new SqlConnection(CS);
            con.Open();
            string qr = "select A.*,B.*,C.Name,B.Name as ImageName, C.Name as BrandName from tblProducts A inner join tblBrands C on C.BrandID =A.PBrandID  cross apply( select top 1 * from tblProductImages B where B.PID= A.PID order by B.PID desc )B where  A.PName like '" + txtFilterGrid1Record.Text + "%' order by A.PID desc";
            SqlDataAdapter da = new SqlDataAdapter(qr, con);
            string text = ((TextBox)sender).Text;
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                rptrProducts.DataSource = ds.Tables[0];
                rptrProducts.DataBind();
            }
            else
            {

            }
        }
        else
        {
            BindProductRepeater();
        }

    }

    protected void btnCart2_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("~/Cart.aspx");
    }
}