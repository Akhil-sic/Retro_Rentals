<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RecoverPassword.aspx.cs" Inherits="RecoverPassword" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>New Password</title>
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
                <div class="form-body">
                    <div class="row">
                        <div class="form-holder">
                            <div class="form-content">
                                <div class="form-items">
                                    
                                    <h3>Reset Password</h3>
                                    <p>    <asp:Label ID="lblmsg" CssClass ="text-danger " runat="server" AssociatedControlID="Recoverpass"></asp:Label></p>
                                    <form class="requires-validation">


                                        <div class="col-md-12">
                                            <asp:TextBox ID="txtpass1" runat="server" CssClass="form-control" type="password" name="password" placeholder="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" CssClass ="text-danger " runat="server" ErrorMessage="*the password field is required" ControlToValidate="txtpass1" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="RegularExpressionValidator"  
                                                    ValidationExpression="^.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#$%^&+=]).*$"  
                                                    ControlToValidate="txtpass1"></asp:RegularExpressionValidator>
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>
             
                                        </div>
                                        
                                      <div class="col-md-12">
                                            <asp:TextBox ID="txtconfirmpass1" runat=server CssClass="form-control"  type="password" name="confirmpassword" placeholder="Confirm Password" Visible="False"></asp:TextBox>
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass ="text-danger " runat="server" ErrorMessage="*the password field is required" ControlToValidate="txtconfirmpass1" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <%--<input class="form-control" type="password" name="password" placeholder="Password" required>--%>

                                        </div>
                                        
                                     

                                        <div class="form-button mt-3">
                                            <asp:Button ID="Recoverpass" runat="server" CssClass="btn btn-primary" Text="Reset" Visible="False" OnClick="Recoverpass_Click" />
                                            <%--<button id="submit" type="submit" class="btn btn-primary">Register</button>--%>
                                    
                                        </div>
                                       
                                    </form>
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
