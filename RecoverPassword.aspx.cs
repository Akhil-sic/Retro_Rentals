using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class RecoverPassword : System.Web.UI.Page
{
    String GUIDvalue;

    int Uid;
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString)) 
        {

            GUIDvalue = Request.QueryString["id"];

            if (GUIDvalue != null)
            {
                SqlCommand cmd = new SqlCommand("Select * from ForgotPass where Id=@Id", con);
                con.Open();
                cmd.Parameters.AddWithValue("@Id", GUIDvalue);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                sda.Fill(dt);
                if (dt.Rows.Count != 0)
                {
                    Uid = Convert.ToInt32(dt.Rows[0][1]);
                }
                else
                {
                    lblmsg.Text = "Your Password Reset Link is Expired or Invalid...try again";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }

        }

        if (!IsPostBack)
        {
            if (dt.Rows.Count != 0)
            {
                txtconfirmpass1.Visible = true;
                txtpass1.Visible = true;
                Recoverpass.Visible = true;
            }
            else
            {
                lblmsg.Text = "Your Password Reset Link is Expired or Invalid...try again";
                lblmsg.ForeColor = System.Drawing.Color.Red;

            }

        }

    }
    protected void Recoverpass_Click(object sender, EventArgs e)
    {
         if (txtpass1.Text != "" && txtconfirmpass1.Text != "" && txtpass1.Text == txtconfirmpass1.Text)
            {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString)) 
                {
           
               
                    con.Open();
                    SqlCommand cmd = new SqlCommand("Update tblusers set Password=@p where Uid=@Uid", con);
                    cmd.Parameters.AddWithValue("@p", txtpass1.Text);
                    cmd.Parameters.AddWithValue("@Uid", Uid);
                    cmd.ExecuteNonQuery();

                    SqlCommand cmd2 = new SqlCommand("delete from ForgotPass Where uid='"+ Uid +"'", con);
                    cmd2.ExecuteNonQuery();
                    Response.Write("<script> alert('Password Reset Successfully done');  </script>");
                    Response.Redirect("~/Login.aspx");
                }
            }
            
        
    }
}