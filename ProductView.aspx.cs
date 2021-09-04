using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ProductView : System.Web.UI.Page
{
    public static String CS = ConfigurationManager.ConnectionStrings["retrorentalsdbconnectionstring"].ConnectionString;
    readonly Int32 myQty = 1;
    string delidate = string.Empty;
    string retndate = string.Empty;
    TimeSpan diff2;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] != null)
        {
            if (Request.QueryString["PID"] != null)
            {
                if (!IsPostBack)
                {
                    BindProductImage();
                    BindProductDetails();
                }
               
            }
            else
            {
                Response.Redirect("~/Products.aspx");
            }
          
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }

    private void BindProductDetails()
    {
        Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SP_BindProductDetails", con)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@PID", PID);
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                rptrProductDetails.DataSource = dt;
                rptrProductDetails.DataBind();
                Session["CartPID"] = Convert.ToInt32(dt.Rows[0]["PID"].ToString());
                Session["myPName"] = dt.Rows[0]["PName"].ToString();
                Session["myRentPrice"] = dt.Rows[0]["RentPrice"].ToString();
                Session["myPSecurPrice"] = dt.Rows[0]["SecurityPrice"].ToString();
            }

        }
    }

    private void BindProductImage()
    {
        Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
        using (SqlConnection con = new SqlConnection(CS))
        {
            using (SqlCommand cmd = new SqlCommand("select * from tblProductImages where PID='" + PID + "'", con))
            {
                cmd.CommandType = CommandType.Text;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptrImage.DataSource = dt;
                    rptrImage.DataBind();
                }
            }
        }
    }

    protected string GetActiveImgClass(int ItemIndex)
    {
        if (ItemIndex == 0)
        {
            return "active";
        }
        else
        {
            return "";

        }
    }

    protected void rptrProductDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string BrandID = (e.Item.FindControl("hfBrandID") as HiddenField).Value;
            string CatID = (e.Item.FindControl("hfCatID") as HiddenField).Value;
            string SubCatID = (e.Item.FindControl("hfSubCatID") as HiddenField).Value;
            TextBox ddate= e.Item.FindControl("TextBox1") as TextBox;
            
            TextBox retdate = e.Item.FindControl("retdate") as TextBox;
           

            RadioButtonList rblSize = e.Item.FindControl("rblSize") as RadioButtonList;

            using (SqlConnection con = new SqlConnection(CS))
            {
                using (SqlCommand cmd = new SqlCommand("select * from tblSizes where BrandID='" + BrandID + "' and CategoryID=" + CatID + " and SubCategoryID=" + SubCatID + "", con))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rblSize.DataSource = dt;
                        rblSize.DataTextField = "sizename";
                        rblSize.DataValueField = "sizeid";
                        rblSize.DataBind();
                    }
                }
            }
        }
    }

    protected void btnAddtoCart_Click(object sender, EventArgs e)
    {
        string SelectedSize = string.Empty;

        foreach (RepeaterItem item in rptrProductDetails.Items)
        {
            
            if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
            {
                var rbList = item.FindControl("rblSize") as RadioButtonList;
                SelectedSize = rbList.SelectedValue;
                var retdate1 = item.FindControl("retdate") as TextBox;
                retndate = retdate1.Text;
                var detdate1 = item.FindControl("TextBox1") as TextBox;
                delidate = detdate1.Text;
                
                var lblError = item.FindControl("lblError") as Label;

                lblError.Text = "";
            }
        }

        if (SelectedSize != "" && retndate != string.Empty && delidate != string.Empty)
        {
            Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
            AddToCartProduction();
            Response.Redirect("ProductView.aspx?PID=" + PID);
            
            
            
        }
        else
        {
            foreach (RepeaterItem item in rptrProductDetails.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    var lblError = item.FindControl("lblError") as Label;
                    lblError.Text = "Please select a size";
                }
            }

        }

    }

    public void BindCartNumber()
    {
        if (Session["USERID"] != null)
        {
            string UserIDD = Session["USERID"].ToString();
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SP_BindCartNumberz", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@UserID", UserIDD);
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    sda.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        string CartQuantity = dt.Compute("Sum(Qty)", "").ToString();
                        CartBadge.InnerText = CartQuantity;

                    }
                    else
                    {
                        CartBadge.InnerText = 0.ToString();
                    }
                }
            }
        }
    }

    private void AddToCartProduction()
    {
        if (Session["Username"] != null)
        {
            Int32 UserID = Convert.ToInt32(Session["USERID"].ToString());
            Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_IsProductExistInCart", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@UserID", UserID);
                cmd.Parameters.AddWithValue("@PID", PID);
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        Int32 updateQty = Convert.ToInt32(dt.Rows[0]["Qty"].ToString());
                        SqlCommand myCmd = new SqlCommand("SP_UpdateCart", con)
                        {
                            CommandType = CommandType.StoredProcedure
                        };
                        myCmd.Parameters.AddWithValue("@Quantity", updateQty + 1);
                        myCmd.Parameters.AddWithValue("@CartPID", PID);
                        myCmd.Parameters.AddWithValue("@UserID", UserID);
                        myCmd.Parameters.AddWithValue("@DeliveryDate", delidate);
                        myCmd.Parameters.AddWithValue("@ReturnDate", retndate);
                        DateDiff();
                        myCmd.Parameters.AddWithValue("@Totaldays", diff2.Days);

                        Int64 CartID = Convert.ToInt64(myCmd.ExecuteScalar());
                        BindCartNumber();
                        //divSuccess.Visible = true;
                    }
                    else
                    {
                        SqlCommand myCmd = new SqlCommand("SP_InsertCart", con)
                        {
                            CommandType = CommandType.StoredProcedure
                        };
                        myCmd.Parameters.AddWithValue("@UID", UserID);
                        myCmd.Parameters.AddWithValue("@PID", Session["CartPID"].ToString());
                        myCmd.Parameters.AddWithValue("@PName", Session["myPName"].ToString());
                        myCmd.Parameters.AddWithValue("@RentPrice", Session["myRentPrice"].ToString());
                        myCmd.Parameters.AddWithValue("@SecurityPrice", Session["myPSecurPrice"].ToString());
                        myCmd.Parameters.AddWithValue("@Qty", myQty);
                        myCmd.Parameters.AddWithValue("@DeliveryDate", delidate);
                        myCmd.Parameters.AddWithValue("@ReturnDate", retndate);
                        DateDiff(); 
                        myCmd.Parameters.AddWithValue("@Totaldays", diff2.Days);
                       
                        Int64 CartID = Convert.ToInt64(myCmd.ExecuteScalar());
                        con.Close();
                        BindCartNumber();
                        divSuccess.Visible = true;
                    }
                }
            }
        }
        else
        {
            Int64 PID = Convert.ToInt64(Request.QueryString["PID"]);
            Response.Redirect("Login.aspx?rurl=" + PID);
        }
    }

    public void DateDiff()
    {
        DateTime d1 = new DateTime();
        DateTime d2 = new DateTime();

        d1 = DateTime.Parse(delidate);
        d2 = DateTime.Parse(retndate);
        diff2 = d2 - d1;
    }
    protected void btnCart2_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("Cart.aspx");
    }

}