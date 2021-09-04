using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["UNAME"] != null && Request.Cookies["UPWD"] != null)
            {
                lblError.Text = string.Empty;
                txtemail.Text = Request.Cookies["UNAME"].Value;
                txtpass.Text = Request.Cookies["UPWD"].Value;
                Checkcookie.Checked = true;

            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Select * from tblusers where Email=@username and Password=@pwd", con);
            cmd.Parameters.AddWithValue("@username", txtemail.Text);

            cmd.Parameters.AddWithValue("@pwd", txtpass.Text);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count != 0)
            {
                Session["USERID"] = dt.Rows[0]["Uid"].ToString();
                
                Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(-1);

                if (Checkcookie.Checked)
                {
                    Response.Cookies["UNAME"].Value = txtemail.Text;
                    Response.Cookies["UPWD"].Value = txtpass.Text;

                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(10);

                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(10);

                }
                else
                {
                    Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(-1);

                    Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(-1);
                }
                string Utype;
                Utype = dt.Rows[0][8].ToString().Trim();

                if (Utype == "User")
                {
                    Session["Username"] = txtemail.Text;
                    Session["USEREMAIL"] = txtemail.Text;
                    Session["getFullName"] = dt.Rows[0]["Name"].ToString();
                    Session["Phoneno"] = dt.Rows[0]["Phoneno"].ToString();
                  
                    if (Request.QueryString["rurl"] != null)
                    {
                        if (Request.QueryString["rurl"] == "cart")
                        {
                            Response.Redirect("Cart.aspx");
                        }

                        if (Request.QueryString["rurl"] == "PID")
                        {
                            string myPID = Session["ReturnPID"].ToString();
                            Response.Redirect("ProductView.aspx?PID=" + myPID + "");
                        }
                    }

                    else
                    {
                        Response.Redirect("Products.aspx?UserLogin=YES");
                    }

                }
                if (Utype == "Admin")
                {
                    Session["Username"] = txtemail.Text;
                   
                    Response.Redirect("~/AdminHome.aspx");
                }
            }
            else
            {
                lblError.Text = "Invalid Username and password";
            }
             clr();
            con.Close();
        }
           
    }
 
     private void clr()
    {
        txtpass.Text = string.Empty;
        txtemail.Text = string.Empty;
        txtemail.Focus();

    }

}