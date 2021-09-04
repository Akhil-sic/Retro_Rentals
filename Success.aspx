<%@ Page Title="" Language="C#" MasterPageFile="~/User.master" AutoEventWireup="true" CodeFile="Success.aspx.cs" Inherits="Success" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="center">
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    
                    <h1>Congrats! Order Placed Successfully...</h1>
                    <br />
                    <br />
                    <br />
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" Font-Size="Large" Text="Back To Products" OnClick="LinkButton1_Click">Back To Products"</asp:LinkButton>
<%--                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Font-Size="Large" Text="Back To Products" OnClick="Button1_Click" />--%>
                </div>
</asp:Content>

