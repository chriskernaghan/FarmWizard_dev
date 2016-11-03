<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="True" CodeBehind="LamenessHomePage.aspx.cs" Inherits="HybridAppWeb.LamenessHomePage" %>

<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ Register TagPrefix="dotnet" Namespace="dotnetCHARTING" Assembly="dotnetCHARTING" %>
<%@ MasterType VirtualPath="_App.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

    <link href="includes/ticker-style.css" rel="stylesheet" type="text/css" />
    <link href="includes/jquerysctipttop.css" rel="stylesheet" type="text/css">
    <script src="Script/jquery.mousewheel.min.js"></script>
    <script src="Script/jquery.event.drag.min.js"></script>
    <script src="Script/jquery.newstape.js"></script>
    <%--<script src="Script/jquery.ticker.js" type="text/javascript"></script>--%>
    <%--<script src="Script/notify.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="Script/jquery.youtubepopup.min.js"></script>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div runat="server" id="icons">
                <div class="container">
		            <div class="row">     
                        <div class="col s12">
                            <strong>Seasonal Lameness advice: Pre Tupping</strong>
                            <ul>
                                <li class="news-item"><a href="#">Treat lame ewes and rams now!</a></li>
                                <li class="news-item"><a href="#">Catch and examine all lame sheep before tupping starts</a></li>
                                <li class="news-item"><a href="#">Catch lame sheep within 3 days of seeing lame</a></li>
                                <li class="news-item"><a href="#">Diagnose cause of lameness (see lesion checker)</a></li>
                                <li class="news-item"><a href="#">Treat all sheep with footrot and scald with antibiotic injection and spray all four feet; spray (all four feet) alone for lambs for scald</a></li>
                                <li class="news-item"><a href="#">DO NOT TRIM</a></li>
                                <li class="news-item"><a href="#">Record all treatments and the cause of lameness (see lesion checker)</a></li>
                                <li class="news-item"><a href="#">Do not breed ewes which you have treated twice in the previous year or which are chronically lame.</a></li>
                                <li class="news-item"><a href="#">Lame ewes are more likely to be barren</a></li>
                                <li class="news-item"><a href="#">Lame rams will not serve as many ewes so make sure you have enough rams so even if one becomes lame during tupping there is adequate cover.</a></li>
                            </ul>
                            <%--                        <ul id="js-news" class="js-hidden">
                                                        <li class="news-item"><a href="#">Treat lame ewes and rams now!</a></li>
                                                        <li class="news-item"><a href="#">Catch and examine all lame sheep before tupping starts</a></li>
                                                        <li class="news-item"><a href="#">Catch lame sheep within 3 days of seeing lame</a></li>
                                                        <li class="news-item"><a href="#">Diagnose cause of lameness (see lesion checker)</a></li>
                                                        <li class="news-item"><a href="#">Treat all sheep with footrot and scald with antibiotic injection and spray all four feet; spray (all four feet) alone for lambs for scald</a></li>
                                                        <li class="news-item"><a href="#">DO NOT TRIM</a></li>
                                                        <li class="news-item"><a href="#">Record all treatments and the cause of lameness (see lesion checker)</a></li>
                                                        <li class="news-item"><a href="#">Do not breed ewes which you have treated twice in the previous year or which are chronically lame.</a></li>
                                                        <li class="news-item"><a href="#">Lame ewes are more likely to be barren</a></li>
                                                        <li class="news-item"><a href="#">Lame rams will not serve as many ewes so make sure you have enough rams so even if one becomes lame during tupping there is adequate cover.</a></li>
                                                    </ul>--%>
                        </div> <!-- /span12 -->
                    </div> <!-- /row -->
                    <br />
               
                    <div id="wrapper">
                       <%-- <div class="row">
                            <div class="col s12">
                            <h3 class="text-center">Lameness Protocols Static Report:</h3>
                            <div class="newstape col s12">
                                <div class="newstape-content">
                                    <div class="news-block">
                                        By NOT catching and treating lameness early(giving antibiotic injection and antibiotic spary to all sheep with
                                        footrot or scald(only antibiotic spray to lambs with scald) you will have
                                        <p class="text-justify">
                                        •	Large number of lame ewes in your flock.
                                        </p>
                                        <p class="text-justify">
                                        •	Ewes lame for longer and thus lose body condition.
                                        </p>
                                        <p class="text-justify">
                                        •	More outbreaks of scald in flock.
                                        </p>
                                        <p class="text-justify">
                                        •	Poor production : low lambing percentage, poor lamb survival , poor lamb growth rate.

                                        </p>

                                        <hr />
                                    </div>
                                </div>
                            </div>
                            <script type="text/javascript">
                                var _gaq = _gaq || [];
                                _gaq.push(['_setAccount', 'UA-36251023-1']);
                                _gaq.push(['_setDomainName', 'jqueryscript.net']);
                                _gaq.push(['_trackPageview']);

                                (function () {
                                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'https://www') + '.google-analytics.com/ga.js';
                                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                                })();

                            </script>
                        </div>
                        </div>--%>
                    </div>
                    <br />
                    <div class="row">
                        <p><strong>Please click Refresh if record may not updated</strong></p>
                    </div>

                    <div class="row">
                        <div class="col s6" >              
                            <a href="#" onclick="clickUrl();" class="btn btn-danger">Refresh</a>							
                        </div> <!-- /span12 -->
                        <div class="col s3" >
                            <p id="state">
                            </p>
                        </div>
                    </div>
                    <br />              
                    <div class="row">

                   </div>
                
                    <div class="row">
                        <div class="col s6">
                            <%--<input type="submit" name="Button1" value="Cull Alert Footrot" id="Button1" class="btn btn-primary waves-effect waves-light" />--%>
                            <asp:LinkButton ID="Button1" name="Button1"  CssClass="btn btn-primary" runat="server" class="btn btn-primary waves-effect waves-light" Text="Cull Alert Footrot" OnClick="FootrotAnimals_Click" />
                        </div>
                    </div>
                    <br />
                    <div class="row">      
			            <div class="col s6" >
                            <a href="#"  onclick="scoreVideos()" class="btn btn-primary waves-effect waves-light" >Mobility Score Videos</a>		
			            </div> <!-- /span12 -->                      
                    </div>
       
                    <div id="scoreTable" >
                        <div class="divTable" >
                            <div class="headRow">
                                <div class="divCell" align="center">Scores</div>
                                <div class="divCell">VideoLink</div>
                            </div>
                            <div class="divRow">
                                <div class="divCell"> <a class="waves-effect waves-light btn teal youtube" href="https://www.youtube.com/watch?v=ljgOzNbrsQw">Score 0</a></div>
                            </div>
                            <div class="divRow">
                                <div class="divCell"><a class="waves-effect waves-light btn teal youtube" href="https://www.youtube.com/watch?v=hLptrH03XE0">Score 1</a></div>
                            </div>
                            <div class="divRow">
                                <div class="divCell"><a class="waves-effect waves-light btn teal youtube" href="https://www.youtube.com/watch?v=wRmvPqAK9mY">Score 2</a></div>
                            </div>
                            <div class="divRow">
                                <div class="divCell"><a class="waves-effect waves-light btn teal youtube" href="https://www.youtube.com/watch?v=plqAUQc0egk">Score 3</a></div>
                            </div>
                            <div class="divRow">
                                <div class="divCell"><a class="waves-effect waves-light btn teal youtube" href="https://www.youtube.com/watch?v=ZCaNKfT60AI">Score 4</a></div>
                            </div>
                            <div class="divRow">
                                <div class="divCell"><a class="waves-effect waves-light btn teal youtube" href="https://www.youtube.com/watch?v=ZBw9xyiHfGE">Score 5</a></div>
                            </div>
                        </div>
                    </div>

                    <br />
                    <div class="row">
                        <div class="col s6">
                            <a href="#"  onclick="lesionImage()" class="btn btn-primary waves-effect waves-light" >Lesion Checker</a>
                        </div>
                    </div>
       
                    <div id="lesionTable" >
                        <div class="divTable" >
                            <div class="headRow">
                                <div class="divCell" align="center">Lesion</div>           
                            </div>
                            <div class="divRow">               
                                <div class="divCell"> <a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/CODD2.JPG','Codd');">CODD</a></div>
                            </div>
                            <div class="divRow">             
                                <div class="divCell"><a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/FA-imoroved2.JPG','Foot');">Foot abscess</a></div>
                            </div>
                            <div class="divRow">          
                                <div class="divCell"><a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/footrot.JPG','Footrot');">Footrot</a></div>
                            </div>
                            <div class="divRow">              
                                <div class="divCell"><a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/CODD2.JPG','Other');">Other Cause</a></div>
                            </div>
                            <div class="divRow">             
                                <div class="divCell"><a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/Scald.JPG','Scald');">Scald</a></div>
                            </div>
                            <div class="divRow">             
                                <div class="divCell"><a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/shelly hoof.JPG','ShellyHoof');">Shelly Hoof</a></div>
                            </div>
                            <div class="divRow">        
                                <div class="divCell"><a class="waves-effect waves-light btn teal" onclick="openImage('img/lesion/Toegranuloma.JPG','Toe');">Toe granuloma</a></div>
                            </div>
                        </div>
                    </div>


                    <ul class="dashdata" id='ul01'>
                        <div class="row">
                            <div class="col s12">
                                <strong>Mobility Scores 2 or more, This month vs Last : </strong>
                                <div class="row">
                                    <div class="form-group col s6"> 
                                    <div class="span3" id="first" >		      
                                        <li>
                                            <div onclick="returnUrl(1);">
                                                <strong><span id="TypeName0" runat="server">Castrated Male</span></strong><br />
                                                <img id="Img0" src="img/heading-tick-icon.png" style="height:60px;width:60px;" /><br />
                                                <span class="desc"><strong> This : </strong></span><span class="desc"><strong><span id="labelThismonth1">0</span>%</strong></span><br/>
                                                <span class="desc"> <strong> Last : </strong></span><span class="desc"><strong><span id="labelLastmonth1">0</span>%</strong></span><br/>
                                            </div>
                                        </li>
                                    </div>
                                </div>

                                    <div class="form-group col s6"> 
                                    <div class="span3" >
                                        <li>
                                            <div onclick="returnUrl(2)">
                                                <strong><span id="TypeName1" runat="server">Ewe</span></strong><br />
                                                <img id="Img1" src="img/heading-tick-icon.png" style="height:60px;width:60px;" /><br />
                                                <span class="desc"><strong> This : </strong></span><span class="desc"><strong><span id="labelThismonth2">0</span>%</strong></span><br/>
                                                <span class="desc"> <strong> Last : </strong></span><span class="desc"><strong><span id="labelLastmonth2">0</span>%</strong></span><br/>
                                            </div>
                                        </li>     
                                    </div>
                                </div>
                                </div>
                            
                                <div class="row">
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li> 
                                                <div onclick="returnUrl(3)">
                                                    <strong><span id="TypeName2" runat="server">Ewe/Lamb</span></strong>  <br />        	     
                                                    <img id="Img2" src="img/heading-tick-icon.png" style="height:60px;width:60px;" /><br />
                                                    <span class="desc"><strong> This : </strong></span><span class="desc"><strong><span id="labelThismonth3">0</span>%</strong></span><br/>
                                                    <span class="desc"> <strong> Last : </strong></span><span class="desc"><strong><span id="labelLastmonth3">0</span>%</strong></span><br/>
                                                </div>
                                            </li>  
                                        </div>
                                    </div>
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li>  
                                                <div onclick="returnUrl(4)">
                                                    <strong><span id="TypeName3" runat="server">Lamb</span></strong><br />
                                                    <img id="Img3" src="img/heading-tick-icon.png" style="height:60px;width:60px;" /><br />
                                                    <span class="desc"> <strong> This : </strong></span><span class="desc"><strong><span id="labelThismonth4">0</span>%</strong></span><br/>
                                                    <span class="desc"> <strong> Last : </strong></span><span class="desc"><strong><span id="labelLastmonth4">0</span>%</strong></span><br/>
                                                </div>
                                            </li> 
                                        </div>
                                    </div>
                                </div>
                            
                                <div class="row">
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li>   
                                                <div onclick="returnUrl(5)">     
                                                    <strong><span id="TypeName4" runat="server">Ram</span></strong>    <br />  
                                                    <img id="Img4" src="img/heading-tick-icon.png" style="height:60px;width:60px;" /><br />
                                                    <span class="desc"><strong> This : </strong></span><span class="desc"><strong><span id="labelThismonth5">0</span>%</strong></span><br/>
                                                    <span class="desc"> <strong> Last : </strong></span><span class="desc"><strong><span id="labelLastmonth5">0</span>%</strong></span><br/>
                                                </div>
                                            </li>  
                                        </div>
                                    </div>
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li>        
                                                <div onclick="returnUrl(6)">
                                                    <strong><span id="TypeName5" runat="server">Unspecified</span></strong>  <br />    
                                                    <img id="Img5" src="img/heading-tick-icon.png" style="height:60px;width:60px;" /><br />
                                                    <span class="desc"><strong> This : </strong></span><span class="desc"><strong><span id="labelThismonth6">0</span>%</strong></span><br/>
                                                    <span class="desc"> <strong> Last : </strong></span><span class="desc"><strong><span id="labelLastmonth6">0</span>%</strong></span><br/>
                                                </div>
                                            </li>  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>             
                    </ul>
                        
                    <ul class="dashdata">
                        <div class="row">
                            <div class="col s12">
                                <strong>Lesion Cases : </strong>
                            
                                <div class="row">
                                    <div class="form-group col s6"> 
                                        <div class="span3">                                 
                                            <li>
                                                <div onclick="lesionCodd()">
                                                    <img id="LesionImg0" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                                </div>
                                                <div id="Codd" style="display:none">    
                                                    <b>Signs:</b>
       
                                                    Starts at the top of the hoof, coronary band
                                                    Under-running of hoof capsule downwards toward the toe
                                                    Whole hoof may fall off. 
                                                    <strong>Cause:</strong> Bacteria Treponemes along with other bacteria            
                                                    <br />
                                                    <b>Treatment :</b>
                                                    1.Antibiotic injection and spray (consult vet).
                                                    2.In advance cases gently remove loose horn and disinfect clippers between sheep.
                                                    3.Quarantine all incoming sheep for at least 28 days.                                
                                                </div>                            
                                                <strong><span id="LesionName0">CODD</span></strong><br />
                                                <span class="desc">This : <span id="lesionThismonth1">0</span></span>
                                                <span class="desc">Last : <span id="lesionLastmonth1">0</span></span>
                                            </li>
                                        </div>
                                    </div>
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                        <li>
                                            <div onclick="lesionFoot()">
                                                <img id="LesionImg1" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                            </div>
                                            <div id="Foot" style="display:none">
                                                <b>Signs :</b>
                                                Affected hoof painful and hot to touch.Pus may appear at the coronary band.           

                                                <strong>Cause:</strong> Foreign material tracks up the white line. Physical injury or Puncture of the hoof.
                                                <b>Treatment: </b>1.Drain the abscess by carefully trimming the sole. 
                                                2.Use injectable antibiotics.
                                            </div>
                                            <strong><span id="LesionName1">Foot abscess</span></strong><br/>
                                            <span class="desc">This : <span id="lesionThismonth2">0</span></span>
                                            <span class="desc">Last : <span id="lesionLastmonth2">0</span></span>
                                        </li>     

                                        </div>
                                    </div>
                                </div>
                            
                                <div class="row">
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li> 
                                                <div onclick="lesionFootrot()">        	     
                                                    <img id="LesionImg2" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                                </div>  
                                                <div id="Footrot" style="display:none">
                                                    <b>Signs : </b>
                                                    A grey oozing pus with characteristic smell.
                                                    Separation of hoof horn from underlying tissue – starting at the interdigital space.
                                                    <strong>Cause:</strong> bacteria D.nodosus
                                                    <b> Treatment: </b>
                                                    1.Treat immediately within 3 days of becoming lame.
                                                    2.Long acting antibiotic injection for correct weight (discuss with vet). 
                                                    3.Apply Antibiotic spray to all feet.
                                                    4.DO NOT TRIM.
                                                    5.Cull sheep that been lame twice.
                                                    6.Quarantine all incoming sheep for at least 28 days.
                                                </div>
                                                <strong><span id="LesionName2">Footrot</span></strong><br />
                                                <span class="desc">This : <span id="lesionThismonth3">0</span></span>
                                                <span class="desc">Last: <span id="lesionLastmonth3">0</span></span>
                                            </li>  
                                        </div>
                                    </div>
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li>  
                                                <div onclick="lesionOther()">
                                                    <img id="LesionImg3" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                                </div>
                                                <div id="Other" style="display:none">
                                                    <b>Signs :</b>Take a Picture , add a description.
                                                    <b>Treatment :</b>
                                                    Consult the vet                                
                                                </div>
                                                <strong><span id="LesionName3">Other cause</span></strong><br />
                                                <span class="desc">This : <span id="lesionThismonth4">0</span></span>
                                                <span class="desc">Last : <span id="lesionLastmonth4">0</span></span>
                                            </li> 
                                        </div>
                                    </div>
                                </div>
                            
                                <div class="row">
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li>  
                                                <div onclick="lesionScald()">        	     
                                                    <img id="LesionImg4" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                                </div> 
                                                <div id="Scald" style="display:none">
                                                    <b> Signs :</b> Red /pink inflammation between claws with grey/white scum.
                                                    Early stage of footrot.
                                                    <strong>Cause:</strong>bacteria D.nodosus
                                                    <b>Treatment :</b>
                                                    1.Treat immediately within 3 days of  becoming lame.
                                                    2.Long acting antibiotic injection for correct weight (discuss with vet) .
                                                    3.Apply Antibiotic spray to all feet.
                                                    4.DO NOT TRIM.
                                                    5.Cull sheep that have been lame twice.
                                                </div>
                                                <strong><span id="LesionName4">Scald</span></strong><br />
                                                <span class="desc">This : <span id="lesionThismonth5">0</span></span>
                                                <span class="desc">Last:<span id="lesionLastmonth5">0</span></span>
                                            </li>  
                                        </div>
                                    </div>
                                
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                        <li>     
                                            <div onclick="lesionShellyHoof()">     	     
                                                <img id="LesionImg5" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                            </div> 
                                            <div id="ShellyHoof" style="display:none">
                                                Separation of wall horn and sole horn to form a pocket
                                                Sheep may not appear lame.
                                                <strong>Cause:</strong> Not fully understood, possible causes: damage from wet/rough ground, stony surfaces, nutritional imbalance
                                                <b>Treatment :</b> Careful trim away the loose horn flap if lame 
                                            </div>
                                            <strong><span id="LesionName5">Shelly Hoof</span></strong><br />
                                            <span class="desc">This: <span id="lesionThismonth6">0</span></span>
                                            <span class="desc">Last: <span id="lesionLastmonth6">0</span></span>                            
                                        </li>  
                                        </div>
                                    </div>
                                    <div class="form-group col s6"> 
                                        <div class="span3">
                                            <li>    
                                                <div onclick="lesionToe()">   
                                                    <img id="LesionImg6" src="img/heading-tick-icon.png" style="height:50px;width:50px;" />
                                                </div>
                                                <div id="Toe" style="display:none">
                                                    <b>Signs : </b>Fleshy tissue often under sole horn as red pea sized ball.
                                                    Very sensitive bleeds easily.
                                                    Possible overgrown wall.
                                                    <strong>Cause:</strong> Foot damage by  excessive foot trimming or a severe footrot or CODD that is left untreated for long.
                                                    <b>Treatment : </b>
                                                    1.Consult your vet.
                                                    2.Painkillers and Antibiotics if signs of infection.
                                                    3.Consider culling as regrowth can occur.
                                                </div>
                                                <strong><span id="LesionName6">Toe granuloma</span></strong><br />
                                                <span class="desc">This : <span id="lesionThismonth7">0</span></span>
                                                <span class="desc">Last : <span id="lesionLastmonth7">0</span></span>
                                            </li>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>        
                    </ul>  
                   
	            </div>
             
                <%--<div class="col s12">
                      <strong> Lesion Cases</strong>
                       <asp:datagrid class="table table-blue" runat="server" id="LamenessLesionGrid"  AllowPaging="False"  AutoGenerateColumns="True"></asp:datagrid>
			       </div>--%>
                <!-- /row -->
                <div class="row">
                    <div class="form-group col s12">
                        <strong>Batch Lameness Control Event</strong>
                        <asp:DataGrid class="table table-blue" runat="server" ID="LamenessControl" AllowPaging="False" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundColumn DataField="DoneDateText" HeaderText="Date"></asp:BoundColumn>
                                <asp:BoundColumn DataField="TreatmentTypeText" HeaderText="Treatment Type"></asp:BoundColumn>
                                <asp:BoundColumn DataField="LamenessCauseText" HeaderText="Lameness Cause"></asp:BoundColumn>
                                <asp:BoundColumn DataField="SheepCategoriesText" HeaderText="Sheep Category"></asp:BoundColumn>
                            </Columns>
                        </asp:DataGrid>
                    </div>
                </div>
                <!-- /row -->
            </div>

            <%--style="margin-top:100px;"--%>

            <div id="charts" runat="server">
                <div class="breadheader">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col s12">
                                <h3><a href="#" class="btn btn-success" onclick="returnToBack();">Back</a>&raquo; Lameness Dashboard</h3>

                            </div>
                        </div>
                    </div>
                </div>
                <strong>
                    <asp:Label ID="FootrotHeader" Text="Cull Alert at time of Culling" runat="server"></asp:Label></strong>
                <asp:DataGrid class="table table-blue" runat="server" ID="LamenessFootrot" AllowPaging="False" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundColumn DataField="NationalID" HeaderText="Animal NO"></asp:BoundColumn>
                        <asp:BoundColumn DataField="SheepCategoryName" HeaderText="Category"></asp:BoundColumn>
                        <asp:BoundColumn DataField="Times" HeaderText="Total"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
                <dotnet:Chart ID="Chart" runat="server" rotate="120" />
            </div>
            <!-- The Modal -->
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span onclick="document.getElementById('myModal').style.display='none'" class="close">&times;</span>
                    <img id="img01">
                    <div id="caption"></div>
                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        var Alert1 = "";
        var flockAlert = "";
        var batchAlert = "";

        //function checkProcessInput() {
        //}
        //function readTag(tag) {
        //}


        function openImage(url, id) {
            //var modal = document.getElementById('myModal');
            //var modalImg = document.getElementById("img01");
            //var captionText = document.getElementById("caption");
            //modal.style.display = "block";
            //modalImg.src = url;
            //captionText.innerHTML = document.getElementById(id).innerText;
            //$('#myModal').openModal();
            imagePopUp(id, url);
        }

        function returnUrl(chartNo) {
            window.location.href = "LamenessHomePage.aspx?Chart=" + chartNo;
        }

        function clickUrl() {
            var d = new Date();
            var file = "LamenessHomePage.aspx?TimeStamp=" + d;
            window.location.href = file;
        }

        function initPage() {
            if (document.getElementById("scoreTable"))
                document.getElementById("scoreTable").style.display = 'none';
            if (document.getElementById("lesionTable"))
                document.getElementById("lesionTable").style.display = 'none';

            var hreffile = window.location.href;
            if (hreffile.indexOf("TimeStamp") != -1) {
                var pageHtml = document.body.innerHTML;
                localStorage.setItem("LamenessPage", pageHtml);
            }
            if (localStorage.getItem("LamenessPage") != null) {

                var value = localStorage.getItem("LamenessPage");
                document.body.innerHTML = value;
            }
            var alert1 = Alert1;
            var flockAlert = flockAlert;
            var batchAlert = batchAlert;
            var loc = window.location.href;
            if (loc.indexOf("Chart") == -1) {
                if (alert1 != '') {
                    //$.notify(alert1, { position: "top left", autoHide: false });
                }
                if (flockAlert != "") {
                    //$.notify(flockAlert, { position: "top left", autoHide: false });
                }
                if (batchAlert != "") {
                   // $.notify(batchAlert, { position: "top left", autoHide: false });
                }
            }

            //$('#js-news').ticker(
            //    {
            //        controls: false,
            //        titleText: ''
            //    });

            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Lameness Dashboard");
            //
        }

        function returnToMain() {
            window.location = "iHerd.aspx?";
        }

        function returnToBack() {
            window.location = "LamenessHomePage.aspx?";
        }

        function scoreVideos() {
            $("#scoreTable").toggle();
        }

        function lesionImage() {
            $("#lesionTable").toggle();
        }

        $(function () {
            $("a.youtube").YouTubePopup({ width: 350, height: 300 });
        });

        function navigate() {
            document.getElementById("Img0").click();
        }

        $(function () {
            $('.newstape').newstape();
        });

        function lesionCodd() {
            $("#Codd").toggle();
        }

        function lesionFoot() {
            $('#Foot').toggle();
        }

        function lesionFootrot() {
            $("#Footrot").toggle();
        }

        function lesionOther() {
            $("#Other").toggle();
        }

        function lesionScald() {
            $("#Scald").toggle();
        }

        function lesionScaldLamb() {
            $("#ScaldLamb").toggle();
        }

        function LesionEwe() {
            $("#Eweram").toggle();
        }

        function lesionShellyHoof() {
            $('#ShellyHoof').toggle();
        }

        function lesionToe() {
            $('#Toe').toggle();
        }


        function imagePopUp(caption, img)
        {         
            $("<div title='" + caption + "'><img width='75%' height='75%' align='center' src='" + img + "' ></div>").dialog({
                resizable: false,
                height: "auto",
                modal: true,
                buttons: {
                    OK: function () {
                        $(this).dialog("close");
                        $(this).dialog("destroy").remove()
                    }
                }
            });
            
            return false;
        }
    </script>

</asp:Content>
