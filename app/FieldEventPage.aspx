<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true"  CodeBehind="FieldEventPage.aspx.cs" Inherits="HybridAppWeb.FieldEventPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
             <div class="row">
                    <div class="form-group col-xs-6">
                    <asp:Label id="ErrorText" runat="server" font-bold="True" forecolor="Red"></asp:Label> 
                     
                    <strong>
                        <asp:Label id="TitleLabel" runat="server"></asp:Label>
                    </strong>
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="FieldList" runat="server" EnableViewState="False" ></N0:MOBILEDROPDOWNLIST>
                       
                    <asp:Label id="ActivityLabel" runat="server" font-bold="True" ><b>Activity/Application</b></asp:Label>
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="Application2" runat="server"></N0:MOBILEDROPDOWNLIST>
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="Activity" runat="server"  DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="ManureType" runat="server"  DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                    
                    <strong>                
                        <asp:Label id="CropLabel" runat="server" font-bold="True" >Crop</asp:Label>
                    </strong>    
                       
                                    
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="Crop" runat="server" DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                                  
                    <strong>
                        <asp:Label id="HarvestYearLabel" class="selectHolder" runat="server" font-bold="True">Harvest Year</asp:Label>
                    </strong> 
                                 
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="HarvestYear" runat="server" ></N0:MOBILEDROPDOWNLIST>
                                   
                    <strong>
                        <asp:Label id="TreatmentDateLabel" runat="server" font-bold="True" >Start Date</asp:Label>
                    </strong>
                    <input type="date" name="DoneDateText" id="inputstartdate" class="form-control">
                       
                    <%--<N0:MOBILEDROPDOWNLIST class="selectHolder" id="DoneDay" runat="server">
                                <asp:ListItem Value="1">01</asp:ListItem>
                                <asp:ListItem Value="2">02</asp:ListItem>
                                <asp:ListItem Value="3">03</asp:ListItem>
                                <asp:ListItem Value="4">04</asp:ListItem>
                                <asp:ListItem Value="5">05</asp:ListItem>
                                <asp:ListItem Value="6">06</asp:ListItem>
                                <asp:ListItem Value="7">07</asp:ListItem>
                                <asp:ListItem Value="8">08</asp:ListItem>
                                <asp:ListItem Value="9">09</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="11">11</asp:ListItem>
                                <asp:ListItem Value="12">12</asp:ListItem>
                                <asp:ListItem Value="13">13</asp:ListItem>
                                <asp:ListItem Value="14">14</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="16">16</asp:ListItem>
                                <asp:ListItem Value="17">17</asp:ListItem>
                                <asp:ListItem Value="18">18</asp:ListItem>
                                <asp:ListItem Value="19">19</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="21">21</asp:ListItem>
                                <asp:ListItem Value="22">22</asp:ListItem>
                                <asp:ListItem Value="23">23</asp:ListItem>
                                <asp:ListItem Value="24">24</asp:ListItem>
                                <asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="26">26</asp:ListItem>
                                <asp:ListItem Value="27">27</asp:ListItem>
                                <asp:ListItem Value="28">28</asp:ListItem>
                                <asp:ListItem Value="29">29</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="31">31</asp:ListItem>
                            </N0:MOBILEDROPDOWNLIST>
                            <N0:MOBILEDROPDOWNLIST class="selectHolder" id="DoneMonth" runat="server">
                                <asp:ListItem Value="1">01</asp:ListItem>
                                <asp:ListItem Value="2">02</asp:ListItem>
                                <asp:ListItem Value="3">03</asp:ListItem>
                                <asp:ListItem Value="4">04</asp:ListItem>
                                <asp:ListItem Value="5">05</asp:ListItem>
                                <asp:ListItem Value="6">06</asp:ListItem>
                                <asp:ListItem Value="7">07</asp:ListItem>
                                <asp:ListItem Value="8">08</asp:ListItem>
                                <asp:ListItem Value="9">09</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="11">11</asp:ListItem>
                                <asp:ListItem Value="12">12</asp:ListItem>
                            </N0:MOBILEDROPDOWNLIST>
                            <N0:MOBILEDROPDOWNLIST class="selectHolder" id="DoneYear" runat="server">
                                </N0:MOBILEDROPDOWNLIST>--%>
                    <div id="Treatmentdatediv" runat="server">
                        <strong>
                            <asp:Label id="TreatFinishedLabel" runat="server" font-bold="True" >End Date</asp:Label>
                        </strong>
                        <input type="date" name="TreatmentDate" id="TreatmentDate" class="form-control">
                    </div>
                            
                    <%--<N0:MOBILEDROPDOWNLIST class="selectHolder" id="DayFinished" runat="server" >
                                    <asp:ListItem Value="1">01</asp:ListItem>
                                    <asp:ListItem Value="2">02</asp:ListItem>
                                    <asp:ListItem Value="3">03</asp:ListItem>
                                    <asp:ListItem Value="4">04</asp:ListItem>
                                    <asp:ListItem Value="5">05</asp:ListItem>
                                    <asp:ListItem Value="6">06</asp:ListItem>
                                    <asp:ListItem Value="7">07</asp:ListItem>
                                    <asp:ListItem Value="8">08</asp:ListItem>
                                    <asp:ListItem Value="9">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    <asp:ListItem Value="12">12</asp:ListItem>
                                    <asp:ListItem Value="13">13</asp:ListItem>
                                    <asp:ListItem Value="14">14</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="16">16</asp:ListItem>
                                    <asp:ListItem Value="17">17</asp:ListItem>
                                    <asp:ListItem Value="18">18</asp:ListItem>
                                    <asp:ListItem Value="19">19</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="21">21</asp:ListItem>
                                    <asp:ListItem Value="22">22</asp:ListItem>
                                    <asp:ListItem Value="23">23</asp:ListItem>
                                    <asp:ListItem Value="24">24</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="26">26</asp:ListItem>
                                    <asp:ListItem Value="27">27</asp:ListItem>
                                    <asp:ListItem Value="28">28</asp:ListItem>
                                    <asp:ListItem Value="29">29</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="31">31</asp:ListItem>
                                </N0:MOBILEDROPDOWNLIST>
                                <N0:MOBILEDROPDOWNLIST class="selectHolder" id="MonthFinished" runat="server" >
                                    <asp:ListItem Value="1">01</asp:ListItem>
                                    <asp:ListItem Value="2">02</asp:ListItem>
                                    <asp:ListItem Value="3">03</asp:ListItem>
                                    <asp:ListItem Value="4">04</asp:ListItem>
                                    <asp:ListItem Value="5">05</asp:ListItem>
                                    <asp:ListItem Value="6">06</asp:ListItem>
                                    <asp:ListItem Value="7">07</asp:ListItem>
                                    <asp:ListItem Value="8">08</asp:ListItem>
                                    <asp:ListItem Value="9">09</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="11">11</asp:ListItem>
                                    <asp:ListItem Value="12">12</asp:ListItem>
                                </N0:MOBILEDROPDOWNLIST>
                                <N0:MOBILEDROPDOWNLIST class="selectHolder" id="YearFinished" runat="server" >
                                </N0:MOBILEDROPDOWNLIST>
                            --%>
                    <strong>
                        <asp:Label id="QuantityLabel" runat="server" font-bold="True">Quantity</asp:Label></td>
                    </strong>
                             
                    <asp:TextBox id="Quantity" CssClass="form-control" runat="server"  MaxLength="70" ></asp:TextBox>
                    <br />
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="Units" runat="server"></N0:MOBILEDROPDOWNLIST>
                             
                    <strong>         
                        <asp:Label id="IncorporationLabel" font-bold="True" runat="server">Incorporation</asp:Label>
                    </strong>    
                                    
                    <N0:MOBILEDROPDOWNLIST class="form-control" id="Incorporation" runat="server" DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                    <br/>
                    <div align="center">
                        <a href="#" class="btn btn-primary waves-effect waves-light" type="button" onclick="checkInput();" >Save Field Event</a>
                    </div>
                    <br/>
                    <div align="center">
                            <a type="button" class="btn btn-primary waves-effect waves-light" href="iFieldEvent.aspx?Action=Map&Type=<%=this.EventType%>" >Show My Map</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    <script type = "text/javascript">

    function selectAnimal(animal) {

        var herdID = sessionStorage.getItem('HerdID');


        var sql = "SELECT * FROM Cows where NationalID like '%" + animal.NationalID + "%' and InternalHerdID = '" + herdID + "'";
        var extraFilter = sessionStorage.getItem('ExtraFilter');
        if (extraFilter) {
            sql += extraFilter;
        }
        if (db) {
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                function (transaction, results) {
                    // results.rows holds the rows returned by the query
                    if (results.rows.length == 1) {
                        var row = results.rows.item(0);
                        var skip = false;
                        if (row.Exception != '') {
                            alert(row.Exception);
                        }
                        if (row.WithdrawalDate != '') {
                            alertWithdrawal(row.WithdrawalDate);
                        }

                        //do something here !!!! row.NationalID
                        //if (document.getElementById("EIDAnimalList")) {
                        //    //var listBox = document.getElementById("EIDAnimalList");
                        //    //var opt = document.createElement("option");
                        //    listBox.options.add(opt, 0);
                        //    opt.text = row.NationalID;
                        //    opt.value = row.InternalAnimalID;
                        //    var counter = document.getElementById("Count");
                        //    counter.value = listBox.length;
                        //    addToList(row.NationalID, null);
                        //}
                        addToList(row.NationalID, null);
                    }
                    else {
                        alert("No records found");
                    }
                },
                function (transaction, error) {
                    alert("Could not read: " + error.message);
                });
            });
        }
        else {
            alert('Cant open database');
        }

    }


    var queryString;

    function addLocation(position)
    {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        WriteFormValues(queryString + "&Latitude=" + latitude + "&Longtitude=" + longitude, document.forms[0], document.forms[0].HidTitle.value);
        document.forms[0].Quantity.value = "";

        alert("<%=this.EventType%>" + " Event Recorded");
    }


    function errorHandler(err) {
        alert("Unable to get location information - Please select a field manually");
        //WriteFormValues(queryString, document.forms[0], document.forms[0].HidTitle.value);
        
    }


    function returnToMain() {
        window.location = "iHerd.aspx";
    }


    function checkInput() {
        var type = "<%=this.EventType%>";
       
        var title = document.forms[0].DoneDateText.value;
            //document.forms[0].DoneDay.value + "/" + document.forms[0].DoneMonth.value;

        if(type == "PastureWalk") {
            var quantity = document.forms[0].Quantity.value;
            if(quantity == "") {
                alert("You must enter a cover value");
                return false;
            }
            if(isNaN(quantity)){
                alert("Cover must be numeric");
                return false;

            }
            title += "-" + document.forms[0].Quantity.value
        }
        queryString = "iFieldEvent.aspx?Action=Add&Type=" + type;
        document.forms[0].HidTitle.value = document.forms[0].FieldList.options[document.forms[0].FieldList.selectedIndex].text + " " + type + " " + title;
        if (document.forms[0].FieldList.value == 0 && navigator.geolocation) {
            var options = {
                enableHighAccuracy: true,
                timeout: 20000,
                maximumAge: 0
            };
            navigator.geolocation.getCurrentPosition(addLocation, errorHandler, options);
        }
        else {
            WriteFormValues(queryString, document.forms[0], document.forms[0].HidTitle.value);

            alert(type + " Event Recorded");
        }
             
        return true;
    }

    function errorHandler2(msg) {  
        var s = document.querySelector('#status');  
        s.innerHTML = typeof msg == 'string' ? msg : "failed";
        s.className = 'fail';  
    }

    function showMe(position) {
         var s = document.querySelector('#status');
         if (s.className == 'success') {    // not sure why we're hitting this twice in FF, I think it's to do with a cached result coming back    
             return;
         }
         s.innerHTML = "";
         s.className = 'success';

         var mapcanvas = document.createElement('div');
         mapcanvas.id = 'mapcanvas';
         mapcanvas.style.height = '400px';
         mapcanvas.style.width = '300px';

         document.querySelector('article').appendChild(mapcanvas);
         var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
         
         var myOptions = {
             zoom: 15,
             center: latlng,
             mapTypeControl: false,
             navigationControlOptions: { style: google.maps.NavigationControlStyle.SMALL },
             mapTypeId: google.maps.MapTypeId.SATELLITE
         };
         var map = new google.maps.Map(document.getElementById("mapcanvas"), myOptions);

         var fieldLayer = new google.maps.KmlLayer('http://www.farmwizard.com:8080/geoserver/topp/wms/kml?layers=topp:GoogleTest3'); 
         fieldLayer.setMap(map);
         var marker = new google.maps.Marker({
             position: latlng,
             map: map,
             title: "You are here!"
         });
     }


     function showMap() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showMe, errorHandler2);
        }
        else {
            alert("Your browser does not support location");
        }

    }

    function initPage() {
        var eventType = "<%=this.EventType%>";
        db = OpenDatabase();
        if (!db) {
            alert("Cannot open database");
            return;
        }
        SetDates(eventType);
        
            
        // Dynamic Lists
        FillDynamicList("<%=FieldList.ClientID%>", "FieldList", 0, 0);
        // We add a special entry to tell server just to geolocate me
        var listBox = document.getElementById("<%=FieldList.ClientID%>");
        var opt = document.createElement("option");
        listBox.options.add(opt);
        opt.text = 'Geolocate Me';
        opt.value = '0';

        if (eventType == "Lime") {
            FillDynamicList("<%=Application2.ClientID%>", "LimeStock", 0, 0);
        }
        else if (eventType == "Spray") {
            FillDynamicList("<%=Application2.ClientID%>", "SprayStock", 0, 0);
        }
        else if (eventType == "Fertiliser") {
            FillDynamicList("<%=Application2.ClientID%>", "FertiliserStock", 0, 0);
        }
        if ("<%=this.ShowMap%>" == "True") {
            showMap();
        }

        // disabling the search feature within the navigation menu
        var searchInput = document.getElementById("CowNumber");
        searchInput.disabled = true;
        searchInput.placeholder = "";
        disableSearchPlaceholder = true;
        //
    }

    </script>

</asp:Content>
