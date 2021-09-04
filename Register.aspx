<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Retrofit Rentals</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE-edge" />
    <link href="css3/Custome.css" rel="stylesheet" /> 
    <link href="css3/reg_style.css" rel="stylesheet" media="screen" type="text/css"/>
    <link href="css3/bootstrap.min.css" rel="stylesheet" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="script3/bootstrap.min.js"></script>
    <style>
    body {background-color: black;} 
</style>
</head>
<body>
    
    
    <form id="form1" runat="server">
    <div>
    <div class="navbar navbar-inverse navbar-fixed-top"role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle"data-toggle="collapse"data-target=".navbar-collapse">
                    <span class="sr-only">Toggle Navigation</span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                    </button>
                <a class="navbar-brand"href="Default.aspx"><span><img src="icons/retrofit.jpg"alt="Retrofit Rentals" height="30" /> Retrofit Rentals</span></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="active"><a href="Default.aspx">Home</a></li>
                    <li><a href ="About.aspx">About</a></li>
                     <li><a href ="faq.aspx">F.A.Q</a></li>
                    <li><a href ="#">*</a></li>
                     <li class="dropdown">
                         <a href="#"class="dropdown-toggle"data-toggle="dropdown">Products<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                       <%-- <li class="dropdown-header">Vegetables</li>
                        <li role="separator"class="divider"></li>
                        <li> <a href="#">Carrot</a></li>
                        <li> <a href="#">Brocolli</a></li>
                        <li> <a href="#">Cauliflower</a></li>
                        <li role="separator"class="divider"></li>
                        <li class="dropdown-header">Fruits</li>
                        <li role="separator"class="divider"></li>
                        <li> <a href="#">Strawberry</a></li>
                        <li> <a href="#">Banana</a></li>
                        <li> <a href="#">Apple</a></li>
                        <li role="separator"class="divider"></li>
                        <li class="dropdown-header">Meat</li>
                        <li role="separator"class="divider"></li>
                        <li> <a href="#">Chicken</a></li>
                        <li> <a href="#">Beef</a></li>
                       --%>


                </ul>
                         </li>
                     <li><a href ="Register.aspx">SignUp</a></li>
                    <li><a href="Login.aspx">SignIn</a></li>
                   
                    </ul>
            </div>
        </div>
    </div>
         <!----Middle contents start--->
         <div>
                <div class="form-body">
                    <div class="row">
                        <div class="form-holder">
                            <div class="form-content" style="width: 704px;">
                                <div class="form-items">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="invalid-feedback" AssociatedControlID="form1"></asp:Label>

                                    <%--<asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>--%>
                                    <h3>Register</h3>
                                    <p>Fill in the data below.</p>
                                    <form class="requires-validation" >
                                        
                                        <div class="col-md-12">
                                            <asp:Textbox ID="txtname" runat="server" Cssclass="form-control" type="text" placeholder="Full Name"></asp:Textbox>
                               
                                        </div>
                                        <div class="col-md-12">
                                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" type="email" name="email" placeholder="E-mail Address"></asp:TextBox>
                                            <%--<input class="form-control" type="email" name="email" placeholder="E-mail Address" required>--%>
                         
                                        </div>
                                        <%--       <div class="col-md-12">
                                            <select class="form-select mt-3" required>
                                                <option selected disabled value="">Position</option>
                                                <option value="jweb">Junior Web Developer</option>
                                                <option value="sweb">Senior Web Developer</option>
                                                <option value="pmanager">Project Manager</option>
                                            </select>
                                            <div class="valid-feedback">You selected a position!</div>
                                            <div class="invalid-feedback">Please select a position!</div>
                                        </div>--%>
                                         <div class="col-md-12">
                                            <asp:TextBox ID="txtphone" runat="server" CssClass="form-control"  type="text" placeholder="Phone Number"></asp:TextBox>
                                          <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"  
                                                    ControlToValidate="txtphone"  CssClass ="text-danger " ErrorMessage="*Phone no is not valid"  
                                                    ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator> 
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>
                                            
                                        </div>
                                        <div class="col-md-12">
                                           <asp:TextBox ID="txtdob" runat="server" CssClass="form-control" TextMode="Date"  min="1900-01-01" max="2006-12-31"></asp:TextBox>  <%--<%# Bind("DateofBirth", "{dd-MM-yyyy}") %>--%>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidatordob" runat="server" CssClass ="text-danger " ErrorMessage="*plz Enter your Date of Birth" ControlToValidate="txtdob" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>
                                            
                                        </div>
                                        <div class="col-md-12">
                                            <asp:TextBox ID="txtpass" runat="server" CssClass="form-control"  type="password" name="password" placeholder="Password"></asp:TextBox>
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>
                                            
                                        </div>
                                        <div class="col-md-12">
                                            <asp:TextBox ID="txtconfirmpass" runat="server" CssClass="form-control"  type="password" name="confirmpassword" placeholder="Confirm Password"></asp:TextBox>
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>
                                            <
                                        </div>
                                        <div class="col-md-12 mt-3">
                                            <label class="mb-3 mr-1" for="gender" aria-selected="undefined">gender:</label>
                                            <asp:radiobutton id="male" runat="server" cssclass="btn-check" groupname="gender"/>
                                           <label class="btn btn-sm btn-outline-secondary" for="male">male</label>
                                            
                                            <asp:radiobutton id="female" runat="server" cssclass="btn-check" groupname="gender"/>
                                            <label class="btn btn-sm btn-outline-secondary" for="female">female</label>

                                            <asp:radiobutton id="others" runat="server" cssclass="btn-check" groupname="gender"/>
                                            <label class="btn btn-sm btn-outline-secondary" for="others">others</label>
                                            
                                        </div>
                                        <br />

                                         <div class="form-button mt-3">
                                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Register" type="submit" OnClick="button1_click"  /> 
                                            <%--<button id="submit" type="submit" class="btn btn-primary">Register</button>--%>
                                            <br />
                                             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login.aspx">I have an Account</asp:HyperLink>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


       
    </form>
   <!------footer Contents Start here---->
            <footer>
                <div class="container">
                    <p class="pull-right"><a href="#">Back to top</a></p><br /><br /><br /><br />
                    <center><p style="color:#fff">© 2021 RETROFIT RENTALS  >>>  All Rights Reserved</p></center>
                </div>
            </footer>

            <!------footer Contents Ends here---->
 
   

</body>
</html>