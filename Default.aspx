<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head runat="server">
   <title>Online Store</title>
    <script src="http://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
        crossorigin="anonymous">   </script>
	<meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
   <meta http-equiv="X-UA-Compatible" content="IE-edge"/>
    <link href="css3/Custome.css" rel="stylesheet" media="screen" type="text/css"/>
    <link href="css3/bootstrap.min.css" rel="stylesheet" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="script3/bootstrap.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function myfunction() {
            $("#btnCart").click(function myfunction() {
                window.location.href = "Cart.aspx";
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <!---Navbar start--->
            <div class ="navbar navbar-inverse navbar-fixed-top " role ="navigation"  >
                <div class ="container ">
                    <div class ="navbar-header">
                        <button type="button" class ="navbar-toggle " data-toggle="collapse" data-target=".navbar-collapse">
                            <span class ="sr-only">Toggle navigation</span> <span class ="icon-bar"></span><span class ="icon-bar"></span><span class ="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" style="float: left;" href="Default.aspx"><span><img src="icons/retrofit.jpg"alt="Retrofit Rentals" height="30" /> Retrofit Rentals</span></a>
                    </div>
                    <div class ="navbar-collapse collapse">
                        <ul class ="nav navbar-nav navbar-right">
                            <%--<li ><a href ="Default.aspx">Home</a> </li>
                            <li ><a href ="#">About</a> </li>
                            <li ><a href ="#">Contact US</a> </li>
                            <li ><a href ="#">Blog-</a> </li>--%>
                            <li class ="drodown"><a href ="#" class ="dropdown-toggle" data-toggle="dropdown">Products<b class ="caret"></b></a>
                                <ul class ="dropdown-menu ">
                                    <li><a href ="Products.aspx">Products</a></li>
                                </ul>
                            </li>
                            <li class ="drodown" ><a href ="#" class ="dropdown-toggle" data-toggle="dropdown">Category <b class ="caret"></b></a>
                                <ul class ="dropdown-menu">
                                    <%--<li ><a href ='#'>Add Brand</a> </li>
                                    <li ><a href ='#'>Add Category</a> </li>
                                    <li ><a href ='#'>Add SubCategory</a> </li>
                                    <li ><a href ='#'>Add Size</a> </li>--%>
                                </ul>
                            </li>
                            <li>
                            <button id="btnCart" class="btn btn-primary navbar-btn " type="button">
                                Cart <span class="badge " id="pCount" runat="server"></span>
                            </button>
                        </li>
                            <li id="btnSignUP" runat="server"><a href="Register.aspx">Register</a> </li>
                        <li id="btnSignIN" runat="server"><a href="Login.aspx">Login</a> </li>
                         <li>
                            <asp:Button ID="btnlogout" CssClass="btn btn-default navbar-btn " runat="server"
                                Text="Sign Out" OnClick="btnlogout_Click" />
                        </li>
                    </div>
                </div>
            </div>
        <!---navbar end--->
  
        <div class="container">
            <h2>
                Carousel Example</h2>
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="ImgSlider/1.jpg" alt="Los Angeles" style="width: 100%;">
                        <div class="carousel-caption">
                            <h3>
                                Women Shopping</h3>
                            <p>
                                50% off</p>
                            <p>
                                <a class="btn btn-lg btn-primary" href="Products.aspx" role="button">Buy Now</a></p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="ImgSlider/2.png" alt="Chicago" style="width: 100%;"/>
                        <div class="carousel-caption">
                            <h3>
                                Acce moble Shopping</h3>
                            <p>
                                20% off</p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="ImgSlider/3.png" alt="New york" style="width: 100%;"/>
                        <div class="carousel-caption">
                            <h3>
                                On mobile you can get</h3>
                            <p>
                                25% off</p>
                        </div>
                    </div>
                </div>
                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left">
                </span><span class="sr-only">Previous</span> </a><a class="right carousel-control"
                    href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right">
                    </span><span class="sr-only">Next</span> </a>
            </div>
        </div>
        <!---image slider End---->
        <hr />
    <div class="container center ">
        <div class="panel panel-primary">
            <div class="panel-heading">
                BEST DEAL</div>
            <div class="panel-body">
                <div class="row" style="padding-top: 50px">
                    <asp:Repeater ID="rptrProducts" runat="server">
                        <ItemTemplate>
                            <div class="col-sm-3 col-md-3">
                                <a href="ProductView.aspx?PID=<%# Eval("PID") %>" style="text-decoration: none;">
                                    <div class="thumbnail">
                                        <img src="Images/ProductImages/<%# Eval("PID") %>/<%# Eval("ImageName") %><%# Eval("Extention") %>"
                                            alt="<%# Eval("ImageName") %>" />
                                        <div class="caption">
                                            <div class="probrand">
                                                <%# Eval ("BrandName") %>
                                            </div>
                                            <div class="proName">
                                                <%# Eval ("PName") %>
                                            </div>
                                            <div class="proPrice"> <span class="proOgPrice" >Retail Price <%# Eval ("RetailPrice","{0:c}") %> </span> </div> 
                                            <div class="proPrice">Rent Price <%# Eval ("RentPrice","{0:c}") %> </div> 
                                            <div class="proPrice"><span class="proPriceDiscount"> (Security Price:<%# Eval ("SecurityPrice","{0:0,00}") %> Refundable) </span> </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="panel-footer">
                Buy 50 mobiles and get a gift card</div>
        </div>
        </div>
    </div>
    </form>
    <footer>
            <div class ="container ">
      
                <p class ="pull-right "><a href ="#">Back to top</a></p>
                <p>&copy;Retro Rentals &middot; <a href ="Default.aspx">Home</a>&middot;<a href ="#">About</a>&middot;<a href ="#">Contact</a>&middot;<a href ="#">Products</a> </p>
            </div>
         
        </footer>
</body>
</html>
