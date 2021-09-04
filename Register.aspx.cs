using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
    }


    protected void button1_click(object sender, EventArgs e)
    {
        lblMsg.Visible = true;
        if (isformvalid())
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString))
            {
                con.Open();
                
                    string genderid = "";
                    if (male.Checked)
                    {
                        genderid = "Male";
                    }
                    else if (female.Checked)
                    {
                        genderid = "Female";
                    }
                    else
                    {
                        genderid = "Others";
                    }

                    SqlCommand cmd = new SqlCommand("insert into tblusers(name,email,password,phoneno,dob,gender,UserType) values('" + txtname.Text + "','" + txtemail.Text + "','" + txtpass.Text + "','" + txtphone.Text + "','" + txtdob.Text + "','" + genderid + "','User')", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script> alert('registration successfully done');  </script>");
                    clr();
                    con.Close();
                    //lblmsg.text = "registration successfully done";
                    //lblmsg.forecolor = system.drawing.color.green;
                }
                Response.Redirect("~/Login.aspx");
                }
                
    
    else
    {
        Response.Write("<script> alert('registration failed');  </script>");
        lblMsg.ForeColor = System.Drawing.Color.Red;
    }
    }


    private bool isformvalid()
    {
        //if (txtuname.text == "")
        //{
        //    response.write("<script> alert('username not valid');  </script>");
        //    txtuname.focus();

        //    return false;
        //}
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString))
        {
            con.Open();
            SqlCommand cmd0 = new SqlCommand("Select * from tblusers where Email='" + txtemail.Text + "'", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd0);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count != 0)
            {
                Response.Write("<script> alert('User with the email id already exists');  </script>");
                con.Close();
                return false;
                
                //Response.Redirect("~/Register.aspx");
            }
        }
        if (txtname.Text == "" && txtphone.Text == "" && txtpass.Text == "" && txtconfirmpass.Text == "" && txtemail.Text == "" && txtdob.Text == "") 
        { 
            if(!(male.Checked || female.Checked || others.Checked))
                Response.Write("<script> alert('Enter alll fields');  </script>");  
            return false;    
        }
        else if (txtpass.Text == "")
        {
            Response.Write("<script> alert('password not valid');  </script>");
            txtpass.Focus();
            return false;
        }
        else if (txtpass.Text != "")
        {
            string pass = txtpass.Text;
            Regex regex = new Regex(@"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$");
            Match match = regex.Match(pass);
            if (!match.Success)
            {

                Response.Write("<script> alert('password muust contain between 6 to 15 characterwhich contain at least one lowercase letter, one uppercase letter one numeric digit and one special character');  </script>");
                txtpass.Focus();
                return false;
            }
        }
        
        else if (txtemail.Text == "")
        {
            Response.Write("<script> alert('email not valid');  </script>");
            txtemail.Focus();
            return false;
        }
        else if (txtemail.Text != "")
        {
            string email = txtemail.Text;
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            if (!match.Success)
            {
                Response.Write("<script> alert('email not valid');  </script>");
                txtemail.Focus();
                return false;
            }
        }
        else if (txtname.Text == "")
        {
            Response.Write("<script> alert('name not valid');  </script>");
            txtname.Focus();
            return false;
        }

        else if (!(male.Checked || female.Checked || others.Checked))
        {
            Response.Write("<script> alert('Please Enter your gender');  </script>");
            return false;
        }
        
        
        else if (txtpass.Text != txtconfirmpass.Text)
        {
            Response.Write("<script> alert('confirm password not valid');  </script>");
            txtconfirmpass.Focus();
            return false;
        }
       
        return true;
        
    }

    private void clr()
    {
        txtname.Text = string.Empty;
        txtphone.Text = string.Empty;
        txtpass.Text = string.Empty;
        //txtuname. text = string.empty;
        txtemail.Text = string.Empty;
        txtconfirmpass.Text = string.Empty;
        txtdob.Text = string.Empty;
    }
}

