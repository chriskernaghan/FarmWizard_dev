<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="HybridAppWeb.LoginPage" %>

<!DOCTYPE html>

<html>
<head>
    <title>FarmWizard - Login</title>
    <link href="includes/iphone.css" type="text/css" rel="STYLESHEET" />
    <meta name="viewport" content="user-scalable=no, width=device-width" />
    <meta name="theme-color" content="#337ab7">
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400italic,400,700|Roboto:400,700,400italic' rel='stylesheet' type='text/css'>


    <link href="/includes/font-awesome.min.css" rel="stylesheet">


    <!--<link href="includes/bootstrap.min.css" rel="stylesheet">-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="includes/materialize.css" rel="stylesheet">
    <link href="includes/style.css" rel="stylesheet">
</head>
<body class="login-page" onload="initPage()" style="padding-top: 0px !important;">

    <script type="text/javascript">
        function initPage() {
            var ua = navigator.userAgent.toLowerCase();
            // We need this offline link for Android 4 running the app
            // document.getElementById("OfflineLink").style.display = 'none';
        }
    </script>
    <div class="outercontainer">
        <div class="container-fluid">
            <div align="center">
                <div class="row">
                    <div class="col-xs-12">
                        <h1 class="loginlogo" style="padding-right: 10px; padding-left: 10px;">
                                <img src="images/logo.png" style="max-height: 100%; max-width:100%;" />
                        </h1>
                        <div id="text">Please enter your Username and Password below, if you dont have one yet please click on Register me Now button below. </div>

                        <form role="form" runat="server">

                            <div class="form-group">

                                <div class="input-field">
                                    <label for="Email" id="usernamelable">User Name :</label>


                                    <asp:TextBox ID="UserName" class="form-control" runat="server"></asp:TextBox>

                                </div>
                            </div>



                            <div class="form-group">

                                <div class="input-field">
                                    <label for="pwd" id="passwordlabel">Password :</label>

                                    <asp:TextBox ID="Password" class="form-control " runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                            <p align="center">
                                <asp:LinkButton  class="btn btn-primary waves-effect waves-light" ID="LoginBtn" OnClick="LoginBtn_Click" runat="server" Width="100%" Text="Login"></asp:LinkButton>
                            </p>
                            <p align="center">
                                <asp:Label ID="Msg" runat="server" ForeColor="red" CssClass="val-error"></asp:Label>
                            </p>
                            <p align="center">
                                <h1></h1>
                            </p>

                            <a href="/public/preregistration.aspx" id="RegisterButton" class="btn-flat">Register Me Now</a>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="Script/jquery.min.js"></script>
    <script src="Script/materialize.min.js"></script>
    <!--<script src="Script/bootstrap.min.js"></script>-->
    <style>
        body {
            background: url(images/loginback.jpg) center center no-repeat;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
            //background-color:#663399;
        }

        #usernamelable {
            color: #333;
        }

        #passwordlabel {
            color: #333;
        }

        #text {
            color: #333;
        }
    </style>
</body>
</html>

