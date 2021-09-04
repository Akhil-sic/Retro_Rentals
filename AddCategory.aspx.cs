using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class AddCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] != null)
        {
            if (!IsPostBack)
            {
                BindCategoryReapter();
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }

    }

    

    private void BindCategoryReapter()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select * from tblCategory", con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrCategory.DataSource = dt;
                    rptrCategory.DataBind();
                }
            }
        }
    }

  

    protected void btnAddtxtCategory_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Insert into tblCategory(CatName) Values('" + txtCategory.Text + "')", con);
            cmd.ExecuteNonQuery();

            Response.Write("<script> alert('Category Added Successfully ');  </script>");
            txtCategory.Text = string.Empty;

            con.Close();
            //lblMsg.Text = "Registration Successfully done";
            //lblMsg.ForeColor = System.Drawing.Color.Green;
            txtCategory.Focus();


        }
        BindCategoryReapter();
    }
}