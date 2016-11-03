<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="BatchLameness.aspx.cs" Inherits="HybridAppWeb.BatchLameness" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>No of Animals in Field :</b>
                            <asp:TextBox ID="FieldAnimal" CssClass="form-control input-sm"  TextMode="Number" onchange='TestOnTextChange(this)' runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Sheep Category :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="SheepType" onchange='sheepTypeTextChange(this)' runat="server" EnableViewState="False">
                                <%--<asp:ListItem Value="Lamb" selected="true">Lamb</asp:ListItem>
                                 <asp:ListItem Value="Ewe">Ewe</asp:ListItem>--%>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                     <div class="row">
                        <div class="form-group col-xs-6">
                            <b>No of Ewe's in Field :</b>
                            <asp:TextBox ID="EweAnimal" CssClass="form-control input-sm"  TextMode="Number" onchange='EweTextChange(this)' runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>No of Lamb's in Field :</b>
                            <asp:TextBox ID="LambAnimal" CssClass="form-control input-sm"  TextMode="Number" onchange='LambTextChange(this)' runat="server"></asp:TextBox>
                        </div>
                        </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Lameness Cause :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="LamenessCause" onchange='lamenessCauseTextChange(this)'  runat="server" EnableViewState="False">
                                <%--<asp:ListItem Value="Lamb" selected="true">Lamb</asp:ListItem>
                                 <asp:ListItem Value="Ewe">Ewe</asp:ListItem>--%>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Treatment Type :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="TreatmentType" onchange='treatmentTypeTextChange(this)' runat="server" EnableViewState="False">
                                <%--<asp:ListItem Value="Lamb" selected="true">Lamb</asp:ListItem>
                                 <asp:ListItem Value="Ewe">Ewe</asp:ListItem>--%>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>

                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Have sheep been moved to a new pasture after Treatment? :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="NewPasture" runat="server" EnableViewState="False">
                                <asp:ListItem Value="false">No</asp:ListItem>
                                <asp:ListItem Value="true" Selected="True">Yes</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-xs-12">
                                <label for="Date" id="EventDateLabel" class="active">Date :</label>
                                <%--<input type="text" name="DoneDateText" onfocus="(this.type='date')" id="inputdate" class="">--%>
                                <input type="date" name="DoneDateText" id="inputdate" class="">
                                <div class="form-group">
                                    <label for="Notes" id="Notes3Label" font-bold="True">Notes :</label>
                                    <%--<input name="Notes" type="text" rows="3" class="" id="Notes"></input>--%>
                                    <asp:TextBox ID="Notes" class="form-control input-sm" runat="server" MaxLength="50" Style="resize: none" Height="50" Width="200%" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div align="center">
                        <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save BatchLameness</a>
                    </div>
                </div>
    </div>

    <script type = "text/javascript">
        ///<reference path="/Script/jquery-ui.min.js" />
        ///<reference path="/Script/HybridApp.js" />

        //
        var db;
        var isCommitted;
        //

        function checkInput()
        {
            var pType = "BatchLameness";      
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

            var getLocation = false;

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this
            if((pType=="BatchLameness")&&("<%=Master.HandsFree%>" == ""))
            {
                if(document.getElementById("<%=FieldAnimal.ClientID%>").value==""){
                    App.alert("Error", "No of animals in field may not be blank");
                    return false;
                }
                document.forms[0].HidTitle.value = "Recorded " + pType + " animals";
            }

            if (isEID == 1) 
            {            
                // Remove the calf nationalID
                // Taking this out for now
                //document.forms[0].HidCalfNationalID.value = document.getElementById("CalfEarTag").value;
                //removeOptions(document.getElementById("CalfEarTag"));
                if((pType=="BatchLameness")&&("<%=Master.HandsFree%>" == ""))
                {
                    if (document.getElementById("<%=FieldAnimal.ClientID%>").value == "")
                    {
                        App.alert("Error", "No of animals in field may not be blank");
                        return false;
                    }
                }       
   
				//document.forms[0].HidTitle.value = "Recorded " + pType + " animals";     
                
                //get location for these types
                if (pType == "BatchLameness" || pType == "Lameness")
                {
                    getLocation = true;
                }
            
            }
			
			
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
                submit();
                return true;   
            }
            // Always return false so that for doesnt get submitted
            return(false);
        }


        function submit()
        {
            var pType = "BatchLameness";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

			var opts = document.forms[0].AnimalList;
	   
			if (opts) {
				document.forms[0].HidAnimalList.value = opts.value;
				document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
				if (document.forms[0].HidAnimalList.value == "0") {
					App.alert("Please select", "Please select or type a cow number");
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
			WriteFormValues("BatchLameness.aspx?Type=Add" + pType  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

			if (isEID != 1) 
			{
				App.alert("Result", msg);
			}
			else  {
				App.message(msg); 
			}  

			isCommitted = 1;
            var aniTable = document.getElementById("AnimalListTable");
            if(aniTable!=null)
            aniTable.parentNode.removeChild(aniTable);

            document.getElementById("form1").reset();

            return true;
        }// submit
		
		
		
		function confirmRecord(pId, pValue)
        {
            if(pValue == false){
                return false;
            }// if
            else {
                document.getElementById("filterInput").value = "";
                submit();
                return true;
            }// else
        }// confirmRecord

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

        function handsFreeBatchLameness(eventType)
        {
                var voiceRespM;
                var found=false;
                while(true){
                    AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Number of animals in field");
                    voiceRespM = AsyncAndroid.GetVoiceCommand();
                    if((voiceRespM =='stop')||(voiceRespM =='cancel')||(voiceRespM =='exit')) {
                        window.location.history.back;
                    }
                    else if(voiceRespM == 'skip'){
                        break;
                    }  else if(voiceRespM=='one'){
                        voiceRespM="1";
                    }
                    if (isNaN(voiceRespM)) {
                        voiceRespM = window.prompt("Please enter animals (must be numeric):", "");
                        //App.textInput("Please enter", "Please enter animals (must be numeric): ", "animalResults", pNationalID, true);
                    }
                    if (!isNaN(voiceRespM)) {
                        document.getElementById("<%=FieldAnimal.ClientID%>").value = voiceRespM;
                        break;
                    }
                    else{
                        App.alert("Please Enter Number","Must be Numeric");
                    }
                }
                for(var l=1;l<4;l++){
                    AsyncAndroid.ConvertTextToVoicePromptResponse("What is the Sheep Category?");
                    voiceRespM = AsyncAndroid.GetVoiceCommands();
                    var arrStr = voiceRespM.replace('[', '');
                    arrStr = arrStr.replace(']', '');
                    var result= arrStr.split(',');
                    var r=0;
                    while(r<result.length && found ==false){
                        if(result[r]=="skip"){
                            found=true;
                            break;
                        }
                       else if (selectOption("SheepType", result[r], 3) != "") {
                            found=true;
                            break;
                        }
                        r++;
                    }
                    if(found){
                        break;
                    }
                }
                if(found==false){
                    AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                    window.loaction.href="BatchLameness.aspx?IsEID=<%=Master.IsEID%>";
                }
                else if(found)
                {
                    found=false;
                }
                for(var k=1;k<4;k++){
                    AsyncAndroid.ConvertTextToVoicePromptResponse("What is the LamenessCause?");
                    voiceRespM = AsyncAndroid.GetVoiceCommands();
                    var arrStr = voiceRespM.replace('[', '');
                    arrStr = arrStr.replace(']', '');
                    var result= arrStr.split(',');
                    var i=0;
                    var text;
                    while(i<result.length && found ==false){
                        if(result[i]=="skip"){
                            found=true;
                            break;
                        }
                       else if (selectOption("LamenessCause", result[i], 6) != ""){
                            found = true;
                            break;
                        }
                        i++;
                    }
                    if(found){
                        break;
                    }
                }
                if(found==false){
                    AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                    window.loaction.href="BatchLameness.aspx?IsEID=<%=Master.IsEID%>";
                }
                else if(found)
                {
                    found=false;
                }
                for(var c=1;c<4;c++){
                    AsyncAndroid.ConvertTextToVoicePromptResponse("What is the TreatmentType?");
                    voiceRespM = AsyncAndroid.GetVoiceCommands();
                    var arrStr = voiceRespM.replace('[', '');
                    arrStr = arrStr.replace(']', '');
                    var result= arrStr.split(',');
                    var x=0;;
                    var text;
                    while(x<result.length && found ==false){
                        if(result[x]=="skip"){
                            found=true;
                            break;
                        }
                     else if (selectOption("TreatmentType", result[x], 6) != "") {
                            found=true;
                            break;
                        }
                        x++;
                    }
                    if(found){
                        break;
                    }
                }
                if(found==false){
                    AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                     window.loaction.href="BatchLameness.aspx?IsEID=<%=Master.IsEID%>";
            }
            else if(found)
            {
                found=false;
            }
            for(var z=1;z<4;z++){
                AsyncAndroid.ConvertTextToVoicePromptResponse("Have sheep been moved to a new pasture?");
                voiceRespM = AsyncAndroid.GetVoiceCommands();
                var arrStr = voiceRespM.replace('[', '');
                arrStr = arrStr.replace(']', '');
                var result= arrStr.split(',');
                var y=0;;
                var text;
                while(y<result.length && found ==false){
                    if(result[y]=="skip"){
                        found=true;
                        break;
                    }
                  else if (selectOption("NewPasture", result[y], 2) != ""){
                        found=true;
                        break;
                    }
                    y++;
                }
                if(found){
                    break;
                }
            }
            if(found==false){
                AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                window.loaction.href="BatchLameness.aspx?IsEID=<%=Master.IsEID%>";
            }
            
            checkInput();
        }
       
        function initPage()
        {
            var isEID = "<%=Master.IsEID%>";
            var HerdID = sessionStorage.getItem('HerdID');
            SetDates('BatchLameness');
            db = OpenDatabase();
            if (!db) {
                App.alert("Database","Cannot open database");
                return;
            }
            if (document.getElementById('FullNumberList')) {
                document.getElementById('FullNumberList').style.display = 'none';
                hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                document.getElementById('FullNumberList').options.length = 0;
            }
            btRetries = 0;
            isCommitted = 0;

            if("<%=Master.HandsFree%>"!=""){
                handsFreeBatchLameness("BatchLameness");
            }

            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Batch Lameness");
            //
        }

        function sheepTypeTextChange() {
            document.getElementById("<%=EweAnimal.ClientID%>").focus();
        }

        function lamenessCauseTextChange() {
            document.getElementById("<%=TreatmentType.ClientID%>").focus();
        }

        function treatmentTypeTextChange() {
            document.getElementById("<%=NewPasture.ClientID%>").focus();
        }

        function TestOnTextChange() {
            document.getElementById("<%=SheepType.ClientID%>").focus();
        }

        function EweTextChange(){
            document.getElementById("<%=LambAnimal.ClientID%>").focus();
        }

        function LambTextChange() {
            document.getElementById("<%=LamenessCause.ClientID%>").focus();
        }


        function animalResults(pId, pValue) {
            if (pValue == false) {
                return;
            }
            else {
                var value = pValue;
                if (isNaN(value)) {
                    App.textInput("Please enter", "Please enter Days Pregnant (must be numeric):", "animalResults", pId, true)
                }
                else {
                    App.alert("TEST", "test test test " + value);
                }// else
            }// else
        }// animalResults
    </script>

</asp:Content>
