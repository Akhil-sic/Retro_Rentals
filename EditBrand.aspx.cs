using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class EditBrand : System.Web.UI.Page
{
    String CS = ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

         if(Session["UserName"]!=null)
        {
            String Bid = Request.QueryString["bid"];
            if(!IsPostBack)
            {
                SqlConnection con = new SqlConnection(CS);
                if (con.State == ConnectionState.Closed) { con.Open(); }
                SqlCommand cmd = new SqlCommand("select Name from tblBrands where BrandID=@ID", con);
                cmd.Parameters.AddWithValue("@ID", Convert.ToInt32(Bid));
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds, "dt");
                con.Close();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    btnUpdateBrand.Enabled = true;
                    txtID.Text = Bid;
                    txtUpdateBrandName.Text = ds.Tables[0].Rows[0]["Name"].ToString();

                }
                else
                {
                    btnUpdateBrand.Enabled = false;
                    txtUpdateBrandName.Text = string.Empty;
                }
                con.Close();
                BindGridview();
            }
        }
        else{
            Response.Redirect("Login.aspx");
        }
    }

    private void BindGridview()
    {

        SqlConnection con = new SqlConnection(CS);
        if (con.State == ConnectionState.Closed) { con.Open(); }
        SqlDataAdapter da = new SqlDataAdapter("select * from tblBrands", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }

    protected void btnUpdateBrand_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(CS);
        if (con.State == ConnectionState.Closed) { con.Open(); }
        SqlCommand cmd = new SqlCommand("update tblBrands set Name=UPPER(@Name) where BrandID=@ID", con);
        cmd.Parameters.AddWithValue("@ID", Convert.ToInt32(txtID.Text));
        cmd.Parameters.AddWithValue("@Name", txtUpdateBrandName.Text);
        cmd.ExecuteNonQuery();
        con.Close();
        Response.Write("<script>alert('Update successfully')</script>");
        BindGridview();
        txtID.Text = string.Empty;
        txtUpdateBrandName.Text = string.Empty;
    }
}