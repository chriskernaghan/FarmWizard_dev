<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="SheepMarketLot.aspx.cs" Inherits="HybridAppWeb.SheepMarketLot" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        
            <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <strong>Lot Batch No :</strong>
                             <asp:TextBox ID="LotNo" CssClass="form-control"  MaxLength="4" onkeypress="return NumberOnly()" runat="server"></asp:TextBox>
                            <%--<asp:DropDownList class="form-control" ID="LotNo"  runat="server" EnableViewState="False">
                               <asp:ListItem Value="" Selected="true">N/A</asp:ListItem>
                            </asp:DropDownList>--%>
                        </div>
                        <div class="form-group col-xs-6">
                            <strong>Flock No :</strong>
                            <asp:TextBox ID="FlockNo" CssClass="form-control"  MaxLength="7" onkeypress="return NumberOnly()" runat="server"></asp:TextBox>
                        </div>
                   </div>
                   <div align="center">
                        <br />
                        <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Event</a>
                    </div>
                </div>
            </div>
              
        
    </div>

    <script type = "text/javascript">

        //
        var db;
        //

        function checkInput() 
        {
            var pType = "SheepMarketLot";
            var herdID = sessionStorage.getItem('HerdID');
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

            var getLocation = false;

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this

            <%--if (isEID == 1) 
            {            
                // Remove the calf nationalID
                // Taking this out for now  if(pType == "SheepMarketLot"){
                    if((document.getElementById("<%=FlockNo.ClientID%>").value)!=""){
                        if(isNaN(document.getElementById("<%=FlockNo.ClientID%>").value)){
                            App.alert("Enter", "Please Enter Numbers");
                            return false;
                        }
                    }
                    var animals = document.getElementById("EIDAnimalList").options;
                    var count = animals.length;
           
                    if (count == 0) {
                        App.message("No animals scanned.");
                        return false;
                    }

                    var animalList = "";
           
            
                    for (var k = 0; k < count; k++) {
                        if (k > 0) {
                            animalList += ",";
                        }
                        animalList = animalList + animals[k].value;
                    }

                    document.forms[0].HidAnimalList.value = animalList;
                    animals.length = 0;
                    //document.forms[0].Count.value = "";
               
                    document.forms[0].HidTitle.value="Recorded SheepMarketLot for Lot No "+ document.getElementById("<%=LotNo.ClientID%>").value ;
                

            }--%>
            // document.forms[0].NFCID.value="787000853605892(982000175198006)";
            if(document.getElementById("filterInput") && document.getElementById("filterInput").value) 
            {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if(document.getElementById("filterInput").value.indexOf('"') > -1) 
                {
                    App.alert("Error", "Cant enter \" in the cow number box");
                    return false;
                }
                if (alwaysConfirmFlag == "1") 
                {
                    var txt = "Click OK to confirm you wish record a " + pType;
                    if (document.getElementById("InseminationChargeCheckBox")) 
                    {
                        txt += " Insemination is chargeable.";
                    }
                    if (document.getElementById("SemenChargeCheckBox")) 
                    {
                        txt += " Semen is chargeable.";
                    }
                    App.confirm("Record", txt, confirmRecord, pType);
                }
            }
            else 
            {
                var opts = document.forms[0].AnimalList;
           
                if (opts) {
                    document.forms[0].HidAnimalList.value = opts.value;
                    document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
                    if (document.forms[0].HidAnimalList.value == "0") {
                        App.alert("Enter", "Please select or type a cow number");
                        return false;
                    }
                    if (processForm() == false) {
                        return false;
                    }
                }
               
                var scorelist='';
                //this is commented out until the database supports it
                //if (getLocation == true)
                //    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
                //else
                WriteFormValues("SheepMarketLot.aspx?Type=AddSheepMarketLot&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
                var msg = "SheepMarketLot has been recorded and will be transferred at next synchronisation";

                if("<%=Master.HandsFree%>" != "") 
                {
                    if ("<%=Master.IsMulti%>" == "true")
                    {
                        AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
                        var  voiceRespM = AsyncAndroid.GetVoiceCommand();
                        if(voiceRespM!="no")
                        {

                        }
                        else {
                            AsyncAndroid.ConvertTextToVoice(msg);
                            setTimeout(function(){ returnToMain();},1000);
                        }
                    }
                    else
                    {
                        AsyncAndroid.ConvertTextToVoice(msg);
                        setTimeout(function(){ returnToMain();},2000);
                    }
                }
                else if (isEID != 1) 
                {
                    App.alert("Result", msg);
                }
                else  {
                    App.message(msg); 
                    document.getElementById("form1").reset();
                }  
        
            }
            // Always return false so that for doesnt get submitted
            return(false);
        }

        function selectAnimal(animal) {

            if (document.getElementById("ManTag").value != "") {
                var exists = false;
                $('#EIDAnimalList option').each(function () {
                    if (this.text == document.getElementById("ManTag").value) {
                        exists = true;
                    }
                });
                if (!exists) {
                    //var listBox = document.getElementById("EIDAnimalList");
                    //var opt = document.createElement("option");
                    listBox.options.add(opt, 0);
                    opt.text = document.getElementById("ManTag").value;
                    opt.value = document.getElementById("ManTag").value;
                    var counter = document.getElementById("Count");
                    counter.value = listBox.length;
                    addToList(opt.text, null);
                    document.getElementById("selectedAnimalsTable").style.display = "none";
                }
            }

        }


        function readTag(tag) {
            
            var herdID = sessionStorage.getItem('HerdID');
                if(tag!=""){
                    var exists=false;
                    $('#EIDAnimalList option').each(function () {
                        if (this.text == tag) {
                            exists=true;
                        }
                    });
                    if(!exists){
                        //var listBox = document.getElementById("EIDAnimalList");
                        //var opt = document.createElement("option");
                        listBox.options.add(opt, 0);
                        opt.text = tag;
                        opt.value = tag;
                        setSelectedIndex(listBox, opt.value);
                        var counter = document.getElementById("Count");
                        counter.value = listBox.length;
                        addToList(row.NationalID, null);
                        document.getElementById("selectedAnimalsTable").style.display="none";
                    }
                }
        }

        function initPage() 
        {
            var isEID = "<%=Master.IsEID%>";
            
            if (isEID == 1)
            {
                document.getElementById("Mansearch").innerHTML="Manual Add";
            }
            document.getElementById("selectedAnimalsTable").style.display="none";
            
            db = OpenDatabase();
            if (!db) {
                App.alert("Database", "Cannot open database");
                return;
            }
            if(document.getElementById('FullNumberList'))
            {
                document.getElementById('FullNumberList').style.display = 'none';
                hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                document.getElementById('FullNumberList').options.length = 0;
            }
            btRetries = 0;
            isCommitted = 0;
            // Widen the data entry box if its a wide screen
            if (isEID == 0) {
                var theTextBox = document.getElementById("filterInput");
                //   theTextBox.style["width"] = "220px";
            } 
            SetDates("SheepMarketLot");
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
            //FillDynamicList("AnimalList", "AnimalList", HerdID, 1, defaultAnimalID);
            
            if (defaultAnimalID) {
                seachOnAnimalID(defaultAnimalID);
            }
       
            //var select = '';
            //select += '<option val=' + 0 + '>' + 'N/A' + '</option>';
            //for (i = 1; i <= 500; i++)
            //{
            //        select += '<option val=' + i + '>' + i + '</option>';
            //}

            //$('#LotNo').html(select);
            //}
            
            if (isEID == 1) 
            {
            
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if (document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }             
            }
        }



        function manSearchAdd()
        {
            var tagNo = document.getElementById("ManTag").value;
              
            var herdID = sessionStorage.getItem('HerdID');
         
            if (document.getElementById("ManTag").value != "")
            {
                var exists=false;
                $('#EIDAnimalList option').each(function ()
                {
                    if (this.text == document.getElementById("ManTag").value) {
                        exists=true;
                    }
                });
                if (!exists)
                {
                    //var listBox = document.getElementById("EIDAnimalList");
                    //var opt = document.createElement("option");
                    listBox.options.add(opt, 0);
                    opt.text = document.getElementById("ManTag").value;
                    opt.value = document.getElementById("ManTag").value;
                    var counter = document.getElementById("Count");
                    counter.value = listBox.length;
                    addToList(opt.text, null);
                    document.getElementById("selectedAnimalsTable").style.display="none";
                }
            }  
        }

        function NumberOnly() {
            var AsciiValue = event.keyCode
            if ((AsciiValue >= 48 && AsciiValue <= 57) || (AsciiValue == 8 || AsciiValue == 127))
                event.returnValue = true;
            else
                event.returnValue = false;
        }


        function processForm() {
            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("No selection", "No group selected");
                    return false;
                }
            }
            if (ValidateDate() == false)
                return false;
            document.forms[0].IsSubmitted.value = true;
            return true;
        }


    </script>

</asp:Content>
