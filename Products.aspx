<%@ Page Title="" Language="C#" MasterPageFile="~/User.master" AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
    <br />
    <br />
    <div class="row">
      <div class="col-md-12">
          <%--<button id="btnCart2" runat="server" class="btn btn-primary navbar-btn pull-right" onserverclick="btnCart2_ServerClick" type="button">
                        Cart <span id="CartBadge" runat="server" class="badge"> 0 </span>
                    </button>--%>
                    <h4>
                        <asp:Label ID="Label1" runat="server" Text="Showing All Products"></asp:Label>
                    </h4>
                    <hr />
                    
      </div>
    </div> 

    <div class="row" style="padding-top:50px">
         <asp:TextBox ID="txtFilterGrid1Record" CssClass="form-control" runat="server" 
              placeholder="Search Products...." AutoPostBack="true" 
              ontextchanged="txtFilterGrid1Record_TextChanged" ></asp:TextBox>
      <br />
      <hr />
       <asp:repeater ID="rptrProducts" runat="server">
           <ItemTemplate>
        <div class="col-sm-3 col-md-3">
            <a href="ProductView.aspx?PID=<%# Eval("PID") %>" style="text-decoration:none;">
          <div class="thumbnail">              
              <img src="Images/ProductImages/<%# Eval("PID") %>/<%# Eval("ImageName") %><%# Eval("Extention") %>" alt="<%# Eval("ImageName") %>"/>
              <div class="caption"> 
                   <div class="probrand"><%# Eval ("BrandName") %>  </div>
                   <div class="proName"> <%# Eval ("PName") %> </div>
                   <div class="proPrice"> <span class="proOgPrice" >Retail Price <%# Eval ("RetailPrice","{0:c}") %> </span> </div> 
                  <div class="proPrice">Rent Price <%# Eval ("RentPrice","{0:c}") %> </div> 
                   <div class="proPrice"><span class="proPriceDiscount"> (Security Price:<%# Eval ("SecurityPrice","{0:0,00}") %> Refundable) </span> </div> 
              </div>
          </div>
                </a>
        </div>
               </ItemTemplate>
       </asp:repeater>
    </div>

</asp:Content>

