<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>


<!DOCTYPE html>

<html > <%--xmlns="http://www.w3.org/1999/xhtml"--%>
<head id="Head1" runat="server">
    <title>Login</title>
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
          <!----Middle contents start--->
        <div>
                <div class="form-body">
                    <div class="row">
                        <div class="form-holder">
                            <div class="form-content">
                                <div class="form-items">
                                    <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
                                    <h3>Login</h3>
                                    <p>Enter Credentials</p>
                                    <form class="requires-validation" >


                                        <div class="col-md-12">
                                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" type="email" name="email" placeholder="Username/E-mail Address"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" CssClass ="text-danger " ErrorMessage="*plz Enter Username" ControlToValidate="txtemail" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <%--<input class="form-control" type="email" name="email" placeholder="E-mail Address" required>--%>
                                            
                                        </div>


                                        <div class="col-md-12">
                                            <asp:TextBox ID="txtpass" runat="server" CssClass="form-control" type="password" name="password" placeholder="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" CssClass ="text-danger " runat="server" ErrorMessage="*the password field is required" ControlToValidate="txtpass" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>
                                           
                                        </div>
                                        
                                        <br />
                                        <div class="form-check">
                                            
                                           &nbsp <asp:CheckBox ID="Checkcookie" runat="server" CssClass="form-check-input" value="" />
                                            <%-- <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>--%>
                                            &nbsp
                                            <label class="form-check-label">Remember Me</label>
                                            <div class="invalid-feedback">Please confirm that the entered data are all correct!</div>
                                        </div>
                                        <asp:Label ID="lblError" CssClass ="text-danger " runat="server" ></asp:Label>

                                        <div class="form-button mt-3">
                                     <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="Button1_Click" />
                                            <%--<button id="submit" type="submit" class="btn btn-primary">Register</button>--%>
                                              &nbsp &nbsp
                                             <asp:HyperLink ID="registerlink" runat="server" NavigateUrl="~/Register.aspx">Create Account</asp:HyperLink>
                                        </div>
                                        <div class="form-button mt-3">
                                            <asp:HyperLink ID="forgotpasslink1" runat="server" NavigateUrl="~/ForgotPassword.aspx">Forgot Password</asp:HyperLink>
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