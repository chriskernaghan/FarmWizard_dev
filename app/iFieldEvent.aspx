<%@ Page Language="C#" debug="true" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" %>
<%@ import Namespace="LifecycleManager" %>
<%@ import Namespace="UserManager" %>
<%@ import Namespace="EnterpriseManager" %>
<%@ import Namespace="ExternalInterfaceManager" %>
<%@ import Namespace="DatabaseInteraction" %>
<%@ import Namespace="AnimalManager" %>
<%@ import Namespace="IDManagement" %>
<%@ import Namespace="FieldRecordManager" %>
<%@ import Namespace="Utilities" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Web.Mail" %>
<%@ import Namespace="System.Threading" %>
<%@ import Namespace="UICommon" %>
<%@ import Namespace="Utilities" %>
<script runat="server">

    // Insert page code here
    // <%@ outputcache duration="60" varybyparam="ID;Type;Action" %>

    const int SLEEP_TIME = 1000;
    const int SCAN_SLEEP_TIME = 5000;
    // String for title
    string Title = "";
    string DoneBy = "";
    private string ShowMap = "False";

    string EventType;
    // Semaphore handling rountines to ensure each submission
    // occurs in paralell
    private void takeSema() {
        int retries;
        for(retries=0;retries<SystemConstants.SUBMISSION_RETRIES;retries++)
        {
            Application.Lock();
            {
                if ((bool)Application["pdaSubmissionInProcess"] == false)
                {
                    Application["pdaSubmissionInProcess"] = true;
                    Application.UnLock();
                    break;
                }
            }
            Application.UnLock();
            Thread.Sleep(SLEEP_TIME);
        }
    }

    private void giveSema() {
        Application.Lock();
        {
            Application["pdaSubmissionInProcess"] = false;
        }
        Application.UnLock();
    }

    private void loadScreens(long pEnterpriseID) {

        eApplicationType appType = (eApplicationType)Enum.Parse(typeof
                            (eApplicationType),Request.QueryString["Type"]);
        FieldUI UI = new FieldUI(pEnterpriseID);
        //DoneYear.DataSource = UIUtilities.GetYearsForDataEntry();
        //DoneYear.DataBind();

        //YearFinished.DataSource = UIUtilities.GetYearsForDataEntry();
        //YearFinished.DataBind();


        if (!Page.IsPostBack) {

            //DayFinished.SelectedValue = DateTime.Now.Day.ToString();
            //MonthFinished.SelectedValue = DateTime.Now.Month.ToString();
            //YearFinished.SelectedValue = DateTime.Now.Year.ToString();

            DropDownList CropDD,HarvestYearDD;
            CropDD = (DropDownList)Crop;
            HarvestYearDD = (DropDownList)HarvestYear;
            Title = "Record " + appType.ToString() + " application";
            TitleLabel.Text += "Please enter details of " + appType.ToString();

            UI.LoadFieldAppStaticDropDowns(ref CropDD,ref HarvestYearDD);
            HarvestYear.SelectedValue = DateTime.Now.Year.ToString();
            Crop.SelectedValue = "7"; // By default set this to grazing
        }
        if(appType == eApplicationType.Activity) {
            Application2.Visible = false;
            DropDownList ActivityDD = (DropDownList)Activity;
            UI.LoadDropDownList(ref ActivityDD,"FieldActivities");
            Activity = (MobileDropDownList)ActivityDD;
            ManureType.Visible = false;
            QuantityLabel.Visible = false;
            Units.Visible = false;
            Quantity.Visible = false;
            IncorporationLabel.Visible = false;
            Incorporation.Visible = false;
        }
        else if(appType == eApplicationType.PastureWalk) {
            Application2.Visible = false;
            DropDownList ActivityDD = (DropDownList)Activity;
            UI.LoadDropDownList(ref ActivityDD,"FieldActivities");
            Activity = (MobileDropDownList)ActivityDD;
            ManureType.Visible = false;
            Units.Visible = false;
            IncorporationLabel.Visible = false;
            Incorporation.Visible = false;
            Activity.Visible = false;
            HarvestYearLabel.Visible = false;
            HarvestYear.Visible = false;
            CropLabel.Visible = false;
            Crop.Visible = false;
            TreatFinishedLabel.Visible = false;
            Treatmentdatediv.Visible = false;
            //DayFinished.Visible = false;
            //MonthFinished.Visible = false;
            //YearFinished.Visible = false;
            ActivityLabel.Visible = false;
            TreatmentDateLabel.Text = "Walk Date";
            QuantityLabel.Text = "Cover";
        }
        else {
            Activity.Visible = false;
            // Farm organic manure is special case
            if(appType == eApplicationType.FarmOrganicManure) {
                DropDownList ManureTypeDD = (DropDownList)ManureType;
                DropDownList IncorporationDD = (DropDownList)Incorporation;
                UI.LoadDropDownList(ref ManureTypeDD,"FarmManures");
                UI.LoadDropDownList(ref IncorporationDD,"FieldIncorporations");
                Application2.Visible = false;
            }
            else {
                ManureType.Visible = false;

            }
            if((appType == eApplicationType.Fertiliser) ||
                (appType == eApplicationType.Spray))
            {
                Units.DataSource = Enum.GetNames(typeof(eFertiliserUnitType));
                Units.DataBind();
            }
            else if(appType == eApplicationType.Lime)
            {
                Units.DataSource = Enum.GetNames(typeof(eLimeUnitType));
                Units.DataBind();
            }
            else {
                Units.DataSource = Enum.GetNames(typeof(eManureUnitType));
                Units.DataBind();
            }
            if((appType != eApplicationType.FarmOrganicManure) &&
                (appType != eApplicationType.StockOrganicManure)) {
                IncorporationLabel.Visible = false;
                Incorporation.Visible = false;
            }
        }
        return;
    }

    private void Page_Load(object sender, EventArgs e)
    {

        HttpCookie cookie = Request.Cookies["FWSession"];
        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        DoneBy = cookie.Values["FullName"];
        EventType = Request.QueryString["Type"].ToString().Trim();

        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);

        EventType = Request.QueryString["Type"].ToString().Trim();


        if (Request.QueryString["Action"] == "Add")
        {
            eApplicationType appType = (eApplicationType)Enum.Parse(typeof
                        (eApplicationType), Request.QueryString["Type"]);
            on_add_button_click(appType);
        }


        if (!Page.IsPostBack)
        {
            loadScreens(enterpriseID);
            if (Request.QueryString["Action"] == "Map")
            {
                ShowMap = "True";
            }
        }
    }
    private void returnBack(Exception ex) {

        HttpCookie cookie = Request.Cookies["FWSession"];


        MailMessage Message = new MailMessage();
        Message.To = "info@farmwizard.com";
        Message.From = "exception@farmwizard.com";
        Message.Subject = "Unhandled Exception from PDA";
        Message.Body = "User is: " + cookie.Values["FullName"] +
                    "\nException: " + ex.ToString() +
               "\nEx Message: " + ex.Message + "\nStack Trace: " + ex.StackTrace +
                    "\nSource: " + ex.Source + "\nTargetSite: " + ex.TargetSite +
        "\n\n\nForm is: \n" + Request.Form.ToString();

        try {
            SmtpMail.SmtpServer = SystemConstants.SMTP_SERVER;
            SmtpMail.Send(Message);
        }
        catch {
            // Dont let it not send message
        }

        returnBack(false,"System Error, contact FarmWizard");
        return;
    }




    private void returnBack(bool pSuccess, string pMessage) {
        HttpCookie cookie = Request.Cookies["FWSession"];
        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        long userID = Int64.Parse(cookie.Values["UserID"]);
        long herdID = Int64.Parse(cookie.Values["HerdID"]);
        long fieldID = Int32.Parse(Request.Form["FieldList"]);
        string animal = "";
        if (fieldID > 0)
        {
            Field field = new Field(fieldID, enterpriseID);
            animal = "Field " + field.Group + " " + field.Name;
        }
        eLogType type = eLogType.MajorFail;
        if(pSuccess) {
            type = eLogType.Success;
        }

        takeSema();
        try {
            Logger log = new Logger(userID,enterpriseID,herdID,
                eLogOriginator.SmartPhone,type,pMessage + " " + animal);
            log.AddToDatabase();
        }
        catch(Exception e) {
            giveSema();
            throw new Exception("Logging failed",e);
        }
        giveSema();
        // Write the response back down in XML
        Response.ContentType = "text/xml";
        string response = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<response>\n";
        response += "<SubmissionID>" + Request.QueryString["SubmissionID"] + "</SubmissionID>";
        response += "<Message>" + pMessage + "</Message>";


        if (pSuccess)
        {
            response += "<Success>1</Success>";
        }
        else
        {
            response += "<Success>3</Success>";
        }
        response += "\n</response>";
        Response.Write(response);
        Response.End();
        return;

    }
    private string getDoneDate()
    {
        string date = string.Empty;
        if (Request.Form["DoneDateText"] == null)
        {
            date = Request.Form["DoneDay"] + "/" + Request.Form["DoneMonth"] + "/" + Request.Form["DoneYear"];
        }
        else
        {
            date = Request.Form["DoneDateText"];
        }
        return (date);
    }
    private string getTreatDate()
    {
        string date = string.Empty;
        if (Request.Form["TreatmentDate"] == null)
        {
            date = Request.Form["DayFinished"] + "/" + Request.Form["MonthFinished"] + "/" + Request.Form["YearFinished"];
        }
        else
        {
            date = Request.Form["TreatmentDate"];
        }
        return (date);
    }

    void on_add_button_click(eApplicationType pAppType) {
        HttpCookie cookie = Request.Cookies["FWSession"];
        long enterpriseID;
        DateTime d,f;

        enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);

        double quantity = 0;

        string doneDate = getDoneDate();
        //string.Format("{0}/{1}/{2}",
        //    Request.Form["DoneDay"],Request.Form["DoneMonth"],Request.Form["DoneYear"]);
        string finishDate = getTreatDate();
        //string.Format("{0}/{1}/{2}",
        //    Request.Form["DayFinished"], Request.Form["MonthFinished"], Request.Form["YearFinished"]);

        int activityType = 0;
        int manureType = 0;
        int applicationStockID = 0;
        int units = 0;
        int incorporation = 0;
        string administrator = cookie.Values["FullName"];


        if(pAppType == eApplicationType.Activity) {
            activityType = Int32.Parse(Request.Form["Activity"]);
        }
        else if (pAppType == eApplicationType.FarmOrganicManure) {
            manureType = Int32.Parse(Request.Form["ManureType"]);
            units = (int)(eManureUnitType)Enum.Parse
             (typeof(eManureUnitType),Request.Form["Units"]);
            try {
                quantity = Double.Parse(Request.Form["Quantity"]);
            }
            catch {
                returnBack(false, "Error, Quantity entered not numeric " + Request.Form["Quantity"]);
                return;
            }

        }
        else {
            if(pAppType ==  eApplicationType.Lime)
            {
                units = (int)(eLimeUnitType)Enum.Parse
                  (typeof(eLimeUnitType), Request.Form["Units"]);
            }
            else if (pAppType !=  eApplicationType.PastureWalk)
            {
                units = (int)(eFertiliserUnitType)Enum.Parse
                    (typeof(eFertiliserUnitType), Request.Form["Units"]);
            }
            if (pAppType !=  eApplicationType.PastureWalk) {
                // Only sprays,lime or fertiliser are associated with a stockID
                applicationStockID = Int32.Parse(Request.Form["Application2"]);
            }
            try {
                quantity = Double.Parse(Request.Form["Quantity"]);
            }
            catch {
                returnBack(false, "Error, Quantity entered not numeric " + Request.Form.ToString());
                return;
            }
        }

        if((pAppType == eApplicationType.StockOrganicManure) ||
                (pAppType == eApplicationType.FarmOrganicManure)) {
            incorporation = Int32.Parse(Request.Form["Incorporation"]);
        }

        d = new DateTime(0);
        f = new DateTime(0);

        try {
            d = DateTime.Parse(doneDate);
        }
        catch {
            returnBack(false,"Error, Invalid Start Date entered " + doneDate);
        }

        if (pAppType != eApplicationType.PastureWalk)
        {
            try
            {
                f = DateTime.Parse(finishDate);
            }
            catch
            {
                returnBack(false, "Error, Invalid End Date entered " + finishDate);
            }
        }

        long fieldID = Int32.Parse(Request.Form["FieldList"]);

        if(fieldID == 0) {
            // user has requested we get field from the co-ordinates
            string sLong = Request.QueryString["Longtitude"];
            string sLat = Request.QueryString["Latitude"];
            if (sLong != null && sLat != null)
            {
                Field field = new Field(sLong.Trim(), sLat.Trim(), enterpriseID);
                fieldID = field.InternalFieldID;
                if (fieldID == 0)
                {
                    returnBack(false, "Error, Cannot resolve co-ordinates " + sLong.Trim() + " " + sLat.Trim());
                }
            }
            else
                returnBack(false, "Error, Cannot resolve co-ordinates");
                

        }

        takeSema();
        if(pAppType == eApplicationType.PastureWalk) {
            // if its a pasture walk
            try {
                PastureMonitor pm = new PastureMonitor(fieldID,d);
                pm.Cover = (int)quantity;
                if(pm.DoesExist) {
                    pm.UpdateDatabase();
                }
                else {
                    pm.AddToDatabase();
                }
            }
            catch (Exception ex) {
                giveSema();
                returnBack(ex);
            }
        }
        else {

            FieldHistory fHist = new FieldHistory(fieldID);

            try {
                fHist.SetValues(activityType,quantity,"From Smartphone",
                   units, applicationStockID, d, f, Int32.Parse(Request.Form["Crop"]),
                        incorporation, administrator, Int32.Parse(Request.Form["HarvestYear"]),
                            manureType);
                fHist.AddToDatabase();
            }
            catch (Exception ex) {
                giveSema();
                // throw new Exception("dd",ex);
                returnBack(ex);
                return;
            }
        }
        giveSema();

        returnBack(true,pAppType.ToString() + " Field event recorded");
        return;
    }




</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title><%=this.Title%></title>
    <link href="/includes/iphone.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" href="/includes/bootstrap.min.css">
    <meta name="viewport" content="user-scalable=no, width=device-width" />
</head>
<body bgcolor="#e9f3f8" leftmargin="0" topmargin="0" onload="initPage();"  marginheight="0" marginwidth="0">
     <script src="/Script/jquery.min.js" type="text/javascript"></script>
    <script language="javascript"  src="/Script/bootstrap.min.js" type="text/javascript"></script>
    <script language="javascript" src="/Script/MobileDataEntry.js" type="text/javascript"></script>
    <script language="javascript" src="/Script/selectbox.js" type="text/javascript"></script>    
    <script language="javascript" src="/Script/html5OfflineDatabase.js" type="text/javascript"></script>
    <script language="javascript" src='http://maps.googleapis.com/maps/api/js?key=AIzaSyBor4HUYqph0CyzF6bJcnlMTI8iVf8_GRw&sensor=true' type="text/javascript"></script>
    
    <script>

        var queryString;

    function addLocation(position) {
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
        FillDynamicList("FieldList", "FieldList", 0, 0);
        // We add a special entry to tell server just to geolocate me
        var listBox = document.getElementById("FieldList");
        //var opt = document.createElement("option");
        listBox.options.add(opt);
        opt.text = 'Geolocate Me';
        opt.value = '0';

        if (eventType == "Lime") {
            FillDynamicList("Application2", "LimeStock", 0, 0);
        }
        else if (eventType == "Spray") {
            FillDynamicList("Application2", "SprayStock", 0, 0);
        }
        else if (eventType == "Fertiliser") {
            FillDynamicList("Application2", "FertiliserStock", 0, 0);
        }
        if ("<%=this.ShowMap%>" == "True") {
            showMap();
        }
    }
    </script>
    <form runat="server">
        <input type="hidden" name="HidTitle" />
        <input type="hidden" value="False" name="IsSubmitted" />
         <article>
          <span id="status"></span>
         </article>
       <div class="panel panel-default">
                <div class="panel-heading" role="tab">
            <div class="breadheader">
  		<div class="container-fluid">
                                <div class="row">
                                    <div class="col-xs-12">
              <h3>  <a href="#" class="btn btn-success" onclick="returnToMain();" >Home</a>&raquo; <%=this.Title%></h3>
                                         </div>
                                    </div>
                                </div>
                            </div>
                        <asp:Label id="ErrorText" runat="server" font-bold="True" forecolor="Red"></asp:Label> 
                       
                           <asp:Label id="TitleLabel" runat="server"></asp:Label>
                       
                    
                        <N0:MOBILEDROPDOWNLIST class="form-control" id="FieldList" runat="server" EnableViewState="False" ></N0:MOBILEDROPDOWNLIST>
                       
                                        <asp:Label id="ActivityLabel" runat="server" font-bold="True" >Activity
                                        /Application</asp:Label>
                                        <N0:MOBILEDROPDOWNLIST class="form-control" id="Application2" runat="server"></N0:MOBILEDROPDOWNLIST>
                                        <N0:MOBILEDROPDOWNLIST class="form-control" id="Activity" runat="server"  DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                                        <N0:MOBILEDROPDOWNLIST class="form-control" id="ManureType" runat="server"  DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                                    
                                        <asp:Label id="CropLabel" runat="server" font-bold="True" >Crop</asp:Label></td>
                                    
                                        <N0:MOBILEDROPDOWNLIST class="form-control" id="Crop" runat="server" DataValueField="TypeID" DataTextField="TypeName"></N0:MOBILEDROPDOWNLIST>
                                  
                                        <asp:Label id="HarvestYearLabel" class="selectHolder" runat="server" font-bold="True">Harvest
                                        Year</asp:Label>
                                   
                                        <N0:MOBILEDROPDOWNLIST class="form-control" id="HarvestYear" runat="server" ></N0:MOBILEDROPDOWNLIST>
                                   
                    
                                        <asp:Label id="TreatmentDateLabel" runat="server" font-bold="True" >Start
                                        Date</asp:Label>
        <input type="date" name="DoneDateText" id="inputdate" class="form-control">
                       
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
                                        <asp:Label id="TreatFinishedLabel" runat="server" font-bold="True" >End
                                        Date</asp:Label>
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
                   
                                        <asp:Label id="QuantityLabel" runat="server" font-bold="True">Quantity</asp:Label></td>
                                    
                                        <asp:TextBox id="Quantity" CssClass="form-control" runat="server"  MaxLength="70" ></asp:TextBox>
                   <br />
                                        <N0:MOBILEDROPDOWNLIST class="form-control" id="Units" runat="server"></N0:MOBILEDROPDOWNLIST>
                                  
                                        <asp:Label id="IncorporationLabel" font-bold="True" runat="server">Incorporation</asp:Label>
                                    
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
    </form>
    <style>
        .breadheader	{float: left; width:100%; background:#607a40 url(../img/back2.jpg) no-repeat top center; padding:10px 0; margin-bottom:10px; color:#fff;}
.breadheader h4	{font-size:18px; margin:0;}
.breadheader a	{color:#fff;}
.breadheader h4 em	{font-size:14px; margin:0;}
        </style>
</body>
</html>
