<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="VetAction.aspx.cs" Inherits="HybridAppWeb.VetAction" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <div class="input-group input-field">
                        <b>Select animal :</b>
                        <input type="text" class="input-sm autocomplete" name="CowNumber" id="CowNumber" placeholder="Search animal" />
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
                <div class="form-group col-xs-6">
                    <b>
                        <asp:Label ID="Label19" runat="server" Font-Bold="True">Action Type:</asp:Label></b>

                    <n0:MOBILEDROPDOWNLIST class="form-control" runat="server" id="VetActionList">
                        <asp:ListItem Value="">Please Select Type...</asp:ListItem>
                        <asp:ListItem Value="PostNatalCheck">Post Natal Check</asp:ListItem>
                        <asp:ListItem Value="CyclingNotSeen">Cycling Not Seen by Deadline</asp:ListItem>
                        <asp:ListItem Value="Anoeustrous">Anoeustrous</asp:ListItem>
                        <asp:ListItem Value="PregDiagnosis">Preg Diagnosis</asp:ListItem>
                        <asp:ListItem Value="HerdAction">Herd Action Note</asp:ListItem>
                        <asp:ListItem Value="General">General Treatment</asp:ListItem>
                        <asp:ListItem Value="DueVet">Due Vet Examination</asp:ListItem>
                        <asp:ListItem Value="InVetGroup">Add to Vet List</asp:ListItem>
                        <asp:ListItem Value="OutVetGroup">Remove from Vet List</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div id="PostNatalCheckTable">
                <div class="row">
                    <div class="form-group col-xs-6">

                        <b>Ovarian State:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="OvarianStateList" DataTextField="TypeName" DataValueField="TypeID" runat="server"></n0:MOBILEDROPDOWNLIST>

                    </div>

                    <div class="form-group col-xs-6">
                        <b>Uterine Condition:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="UterianConditionList" onchange='setUterineCondition();' DataTextField="TypeName" DataValueField="TypeID" runat="server"></n0:MOBILEDROPDOWNLIST>
                    </div>

                </div>
                <div class="row">
                    <div class="form-group col-xs-6">

                        <%-- <b>Ovarian State Right:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="MOBILEDROPDOWNLIST1" DataTextField="TypeName" DataValueField="TypeID" runat="server"></n0:MOBILEDROPDOWNLIST>--%>

                    </div>

                    <div class="form-group col-xs-6" id="UterineGrade">
                        <asp:Label ID="lblUterineGrade" runat="server" Font-Bold="True">Uterine Grade:</asp:Label>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="UterineConditionGrade" runat="server">
                            <asp:ListItem Value="0" Selected="True">Not Graded</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                        </n0:MOBILEDROPDOWNLIST>
                    </div>

                </div>
            </div>
            <div id="PregDiagnosisTable">
                <div class="row">
                    <div class="form-group col-xs-6">
                        <strong>
                        <asp:Label ID="Label22" runat="server" Font-Bold="True">Scan Result :</asp:Label>
                        </strong>
                        <n0:MOBILEDROPDOWNLIST class="form-control" id="PregDiagnosisList" runat="server" EnableViewState="False">
                            <asp:ListItem Value="No">Not Pregnant</asp:ListItem>
                            <asp:ListItem Value="Yes">Pregnant</asp:ListItem>
                            <asp:ListItem Value="Twins">Twins</asp:ListItem>
                            <asp:ListItem Value="Triplets">Triplets</asp:ListItem>
                            <asp:ListItem Value="Recheck">Recheck</asp:ListItem>
                            <asp:ListItem Value="Death">Embryonic Death-Reabsorption</asp:ListItem>
                        </n0:MOBILEDROPDOWNLIST>
                    </div>


                    <div class="form-group col-xs-6">
                        <strong>
                            <asp:Label ID="Label25" runat="server" Font-Bold="True">Days Pregnant :</asp:Label></strong>

                        <asp:TextBox ID="PregDiagnosisDays" type="number" onkeydown="return isNumberKey(event);" class="form-control" runat="server"></asp:TextBox>
                    </div>

                </div>


                <strong>Served by :</strong>
                <span id="PregDiagnosisText">_</span>

            </div>

            <div id="FertilityDiagnosisTable">

                <div class="row">
                    <div class="form-group col-xs-6">

                        <b>Diagnosis:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="FertilityDiagnosisList" DataTextField="TypeName" DataValueField="TypeID" runat="server"></n0:MOBILEDROPDOWNLIST>

                    </div>
                </div>
            </div>

            <div id="FertilityTreatmentTable">
                <div class="row">
                    <div class="form-group col-xs-6">
                        <b>Treatment:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="FertilityTreatmentList" DataTextField="TypeName" DataValueField="TypeID" runat="server"></n0:MOBILEDROPDOWNLIST>

                        <div style="margin-top: 5px"></div>
                        <n0:MOBILEDROPDOWNLIST class="form-control" id="ProtocolList" visible="false" runat="server"></n0:MOBILEDROPDOWNLIST>
                    </div>
                </div>
            </div>
            <div id="HerdActionTable">
                <div class="row">
                    <div class="form-group col-xs-6">
                        <b>Type:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="NoteTypeList" DataTextField="TypeName" DataValueField="TypeID" runat="server"></n0:MOBILEDROPDOWNLIST>

                    </div>
                    <div class="form-group col-xs-6">
                        <b>Apply To Group:</b>

                        <n0:MOBILEDROPDOWNLIST class="form-control" id="NoteTypeApplyTo" runat="server">
                            <asp:ListItem Value="">N/A</asp:ListItem>
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="0">Young Stock</asp:ListItem>
                            <asp:ListItem Value="1">Heifers</asp:ListItem>
                            <asp:ListItem Value="2">1st Calvers</asp:ListItem>
                            <asp:ListItem Value="3">2nd Calvers</asp:ListItem>
                            <asp:ListItem Value="4">3rd Calvers</asp:ListItem>
                            <asp:ListItem Value="5">4th Calvers</asp:ListItem>
                            <asp:ListItem Value="6">5th Calvers</asp:ListItem>
                            <asp:ListItem Value="7">6th Calvers</asp:ListItem>
                            <asp:ListItem Value="8">7th Calvers</asp:ListItem>
                            <asp:ListItem Value="9">8th Calvers</asp:ListItem>
                            <asp:ListItem Value="10">9th Calvers</asp:ListItem>
                        </n0:MOBILEDROPDOWNLIST>
                    </div>
                </div>

            </div>



            <div align="center">
                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Vet Action</a>

            </div>
        </div>
    </div>

    <script type = "text/javascript">

        var db;

        function checkInput() 
        {
            var pType = "VetAction";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

            var getLocation = false;

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this
          
                if (document.getElementById("<%=VetActionList.ClientID%>").value == '') {
                    App.alert("Please Select","Please select type of vet action");
                    return false;
                }
                else if (document.getElementById("<%=VetActionList.ClientID%>").value == 'PregDiagnosis') {
                    var pregDiagnosis = document.getElementById("<%=PregDiagnosisList.ClientID%>").value;
                    if ((pregDiagnosis == 'Yes') || (pregDiagnosis == 'Twins') || (pregDiagnosis == 'Triplets'))  {
                        if (document.getElementById("<%=PregDiagnosisDays.ClientID%>").value == '') {
                            App.alert("Please Enter","Days pregnant not specified");
                            return false;
                        }
                    }
                }


            var animalListEID = "";
            var animalListNFC = "";
            var eidnfclist = getAllFromList();

            // checking to see whether any animals have been selected/scanned
            var count = eidnfclist.length;
            if (count == 0) {
                App.message("No animals selected/scanned.");
                return false;
            }

            for (var k = 0; k < eidnfclist.length; k++) {
                if (k > 0) {
                    animalListEID += ",";
                    animalListNFC += ",";
                }
                animalListEID = animalListEID + eidnfclist[k].EID;
                animalListNFC = animalListNFC + eidnfclist[k].NFCID;
            }

            document.forms[0].HidAnimalList.value = animalListEID;
            if (animalListNFC == "undefined" || animalListNFC == null)
                document.forms[0].HidAnimalListNFC.value = null;
            else
                document.forms[0].HidAnimalListNFC.value = animalListNFC;

            var count = eidnfclist.length;

            //document.forms[0].Count.value = "";
            document.forms[0].HidTitle.value = "Recorded " + pType + " for " + count + " animals";

            //if (isEID == 1) 
            //{            
            //    // Remove the calf nationalID
            //    // Taking this out for now
            //    //document.forms[0].HidCalfNationalID.value = document.getElementById("CalfEarTag").value;
            //    //removeOptions(document.getElementById("CalfEarTag"));
            //    var animals = document.getElementById("EIDAnimalList").options;
            //    var count = animals.length;

            //    if (count == 0) 
            //    {
            //        App.message("No animals scanned : Please Scan EID");
            //        return false;
            //    }

            //    var animalList = "";
            //    //  alert("check process "+  document.forms[0].NFCID.value);
            

            //    for (var k = 0; k < count; k++) 
            //    {
            //        if (k > 0) {
            //            animalList += ",";
            //        }
            //        animalList = animalList + animals[k].value;
            //    }

            //    document.forms[0].HidAnimalList.value = animalList;
            //    animals.length = 0;
            //    //document.forms[0].Count.value = "";
                
            //    document.forms[0].HidTitle.value = "Recorded " + pType + " animals";                                  
            //}
                    
                

            // document.forms[0].NFCID.value="787000853605892(982000175198006)";
            if (document.getElementById("filterInput") && document.getElementById("filterInput").value) {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if (document.getElementById("filterInput").value.indexOf('"') > -1) {
                    App.alert("Please Enter", "Cant enter \" in the cow number box");
                    return false;
                }
                if (alwaysConfirmFlag == "1") {
                    var txt = "Click OK to confirm you wish record a " + pType;
                    if (document.getElementById("InseminationChargeCheckBox")) {
                        txt += " Insemination is chargeable.";
                    }
                    if (document.getElementById("SemenChargeCheckBox")) {
                        txt += " Semen is chargeable.";
                    }
                    App.confirm("Record", txt, confirmRecord, pType);
                }
            }
            else {
                submit();
                return true;
            }
            // Always return false so that for doesnt get submitted
            return(false);
        }


        function submit()
        {
            var pType = "VetAction";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

			var opts = document.forms[0].AnimalList;
	   
			if (opts) {
				document.forms[0].HidAnimalList.value = opts.value;
				document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
				if (document.forms[0].HidAnimalList.value == "0") {
					App.alert("Please Select","Please select or type a cow number");
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
			WriteFormValues("VetAction.aspx?Type=Add" + pType  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

			if("<%=Master.HandsFree%>" != "") 
			{
				if ("<%=Master.IsMulti%>" == "true")
				{
					AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
					var  voiceRespM = AsyncAndroid.GetVoiceCommand();
					if (voiceRespM != "no")
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
			}
				
			isCommitted = 1;
            var aniTable = document.getElementById("AnimalListTable");
            if(aniTable!=null)
            aniTable.parentNode.removeChild(aniTable);

            //$('#EIDAnimalList').empty();
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


        function seachOnAnimalID(animalID) 
        {
            var HerdID = sessionStorage.getItem('HerdID');
            // Search database Datastore
            if (!animalID) {
                animalID = document.getElementById("AnimalList").value;
            }
            var sql = "SELECT * FROM Cows where (InternalAnimalID = '" + animalID + "' AND InternalHerdID = " + HerdID + ")";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
            db.transaction(function (transaction) 
            {
                transaction.executeSql(sql, [],
                    function (transaction, results) 
                    {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) {
                            var row = results.rows.item(0);

                            document.forms[0].HidAnimalList.value = row.InternalAnimalID;
                            document.forms[0].HidAnimalNos.value = row.FreezeBrand;

                            
                            var lastServedOn = new Date(row.LastServedDate.substring(6),
                                    row.LastServedDate.substring(3, 5) - 1, row.LastServedDate.substring(0, 2));
                            var today = new Date();
                            var days = (today.getTime() - lastServedOn.getTime()) / 86400000;
                            days = Math.round(days);                               
                            if (document.getElementById("<%=PregDiagnosisDays.ClientID%>")) {
                                document.getElementById("<%=PregDiagnosisDays.ClientID%>").value = '';
                                document.getElementById("PregDiagnosisText").firstChild.data = row.LastServedDate + " " + row.LastServedTo;
                                    
                                if ((days > 0) && (days < 280)) {
                                    document.getElementById("<%=PregDiagnosisDays.ClientID%>").value = days;
                                }
                            }                            
                            
                        }
                    },
   
                      function (transaction, error) 
                      {
                          App.alert("Error","Could not read: " + error.message);
                      });
            });
            return true;
        }


        function searchFB(filterInput,postEntry) 
        {
            var herdID = sessionStorage.getItem('HerdID');
            // Search database Datastore
            var sql = "SELECT * FROM Cows where (FreezeBrand = '" + filterInput + "' AND InternalHerdID = " + herdID + ")";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
            db.transaction(function (transaction) 
            {
            transaction.executeSql(sql, [],
                function (transaction, results) {
                    // results.rows holds the rows returned by the query
                    if (results.rows.length == 1) {
                        var row = results.rows.item(0);

                        document.forms[0].HidAnimalList.value = row.InternalAnimalID;
                        document.forms[0].HidAnimalNos.value = row.FreezeBrand;

                        setSelectedIndex(document.getElementById("AnimalList"), row.InternalAnimalID);
                        if (postEntry == false) 
                        {                           
                            var lastServedOn = new Date(row.LastServedDate.substring(6),
                                    row.LastServedDate.substring(3, 5) - 1, row.LastServedDate.substring(0, 2));
                            var today = new Date();
                            var days = (today.getTime() - lastServedOn.getTime()) / 86400000;
                            days = Math.round(days);

                            if (document.forms[0].PregDiagnosisDays) 
                            {
                                if ((days > 0) && (days < 280))
                                {
                                        document.forms[0].PregDiagnosisDays.value = days;
                                }
                            }
                                
                            if("<%=Master.HandsFree%>" != "") 
                            {
                                checkInput();
                                if("<%=Master.IsMulti%>" == "true") {
                                    initPage();
                                }
 
                            }
                            
                        }
                        else 
                        {
                            // Write the form to the offline cache
                            if (processForm() == false) 
                            {
                                return false;
                            }
                            WriteFormValues("VetAction.aspx?Type=AddVetAction?HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
                            if("<%=Master.IsEID%>" == "1")  {
                                App.message("VetAction has been recorded and will be transferred at next synchronisation");
                            }
                            else {
                                App.alert("Result", "VetAction has been recorded and will be transferred at next synchronisation");
                            }
                            isCommitted = 1;
                        }
                    }
                    else if (results.rows.length > 1) 
                    {
                        App.alert("Records found","More than one matching cow found " + results.rows.length);
                        return false;
                    }
                    else 
                    {
                        if("<%=Master.HandsFree%>" != "") {
                            initPage();
                        }
                        else {
                            App.alert("No Records","No matching cows for " + filterInput);
                        }
                        return false;                                             
                    }
                },
                  function (transaction, error) {
                      App.alert("Error","Could not read: " + error.message);
                  });
            });
            return true;
        }



        function setVetActionScreen() 
        {
            document.getElementById('PostNatalCheckTable').style.display = 'none';
            document.getElementById('FertilityTreatmentTable').style.display = 'none';
            document.getElementById('PregDiagnosisTable').style.display = 'none';
            document.getElementById('HerdActionTable').style.display = 'none';
            document.getElementById('FertilityDiagnosisTable').style.display = 'none';
            document.getElementById('UterineGrade').style.display = 'none';

            //call this to make sure the extra grade option is shown if it's needed. 
            setUterineCondition();


            var action = document.getElementById('<%=VetActionList.ClientID%>');

            if (action.value == "PostNatalCheck") {
                document.getElementById('PostNatalCheckTable').style.display = 'block';
                document.getElementById('FertilityTreatmentTable').style.display = 'block';
                document.getElementById('FertilityDiagnosisTable').style.display = 'block';
            }
            else if (action.value == "CyclingNotSeen") {
                document.getElementById('PostNatalCheckTable').style.display = 'block';
                document.getElementById('FertilityTreatmentTable').style.display = 'block';

                var fertdiagnosistable = document.getElementById("FertilityDiagnosisTable");
                fertdiagnosistable.style.display = 'block';

                var fertdiagnosislist = document.getElementById("FertilityDiagnosisList");
                if (fertdiagnosislist)
                {
                    //Set selected value to 13 as default - missed deadline.
                    for (var i = 0; i < fertdiagnosislist.options.length; i++)
                    {
                        if (fertdiagnosislist.options[i].value == 13)
                        {
                            fertdiagnosislist.options[i].selected = true;
                            break;
                        }
                    }
                }

            }
            else if (action.value == "Anoeustrous") {
                document.getElementById('PostNatalCheckTable').style.display = 'block';
                document.getElementById('FertilityTreatmentTable').style.display = 'block';
            }
            else if (action.value == "PregDiagnosis") {
                document.getElementById('PregDiagnosisTable').style.display = 'block';
                document.getElementById('FertilityTreatmentTable').style.display = 'block';
                document.getElementById('FertilityDiagnosisTable').style.display = 'block';
            }
            else if (action.value == "HerdAction") {
                document.getElementById('HerdActionTable').style.display = 'block';
            }
            else if (action.value == "General") {
                document.getElementById('FertilityTreatmentTable').style.display = 'block';
                document.getElementById('FertilityDiagnosisTable').style.display = 'block';
            }
        }

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



        function readNfcTag(tagValue)
        {
            handleTag(tagValue, "NFCID");
        }// readNfcTag


        function readTag(tagValue)
        {
            handleTag(tagValue, "ElectronicID");
        }// readTag


        function handleTag(tagValue, tagType)
        {
            var tag= tagValue;      
            btRetries = 0;
            var herdID = sessionStorage.getItem('HerdID');  
	
            var sql = "SELECT * FROM Cows where (" + tagType + "= '" + tag + "' AND InternalHerdID = " + herdID + ")";          
       //function readTag(tag) {
            //var herdID = sessionStorage.getItem('HerdID');
                    //var sql = "SELECT * FROM Cows where (ElectronicID = '" + tag + "' AND InternalHerdID = " + herdID + ")";
                    db.transaction(function(transaction) {
                        transaction.executeSql(sql, [],
                            function(transaction, results) {
                                //var listBox = document.getElementById("EIDAnimalList");
                                //var opt = document.createElement("option");
                                      
                                // results.rows holds the rows returned by the query
                                if (results.rows.length == 1) {

                                    var row = results.rows.item(0);
                                    if(row.Exception!=''){
                                        App.alert("Exception", row.Exception);
                                    }
                                    if(row.withdrawalDate!=''){
                                        alertWithdrawal(row.WithdrawalDate);
                                    }
                                        //if(document.getElementById("EIDAnimalList")!=null){
                                        //    listBox.options.add(opt, 0);
                                        //    opt.text = tag;
                                        //    opt.value = row.InternalAnimalID;
                                        //    setSelectedIndex(listBox, opt.value);
                                        //    var counter = document.getElementById("Count");
                                        //    counter.value = listBox.length;
                                        //    addToList(tag, null);
                                        //}
                                    if (tagType == "ElectronicID") {
                                        if (row.NFCID != "" || row.NFCIF != null) {
                                            addToList(row.NationalID, row.NFCID);
                                        }
                                        else {
                                            addToList(row.NationalID, null);
                                        }
                                    }
                                    else {
                                        if (row.ElectronicID != "" || row.ElectronicID != null) {
                                            addToList(row.NationalID, tag);
                                        }
                                        else {
                                            addToList(null, tag);
                                        }
                                    }


                                }
                                else{
                                    App.message(tag + "Animal not found")
                                }
                            
                        },
                                  function(transaction, error) {
                                      App.alert("Error","Could not read: " + error.message);
                                  });
                    });
                    App.message(tag);
                    return;
    }
                
        function initPage() 
        {         
            var isEID = "<%=Master.IsEID%>";
            db = OpenDatabase();
            if (!db) {
                App.alert("Database","Cannot open database");
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
            SetDates("VetAction");
           var HerdID = sessionStorage.getItem('HerdID');
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
            document.getElementById('PostNatalCheckTable').style.display = 'none';
            document.getElementById('FertilityTreatmentTable').style.display = 'none';
            document.getElementById('FertilityDiagnosisTable').style.display = 'none';
            document.getElementById('PregDiagnosisTable').style.display = 'none';
            document.getElementById('HerdActionTable').style.display = 'none';
            
           
            if (isEID == 1) 
            {           
                document.getElementById('selectedAnimalsTable').style.display = 'block';  
                if(document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }                 
            }
            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Record Vet Action");
            //
        }

        function setUterineCondition() {

            //if they have selected value 1 (Metritis) or 5 (Endometritis) display Grading for the Grade
            var uclval = document.getElementById('<%=UterianConditionList.ClientID%>').value;
            var ucltext = document.getElementById('<%=UterianConditionList.ClientID%>').options[document.getElementById('<%=UterianConditionList.ClientID%>').selectedIndex].text;

            if (uclval == 5 || uclval == 1) {
                document.getElementById('UterineGrade').style.display = 'block';
                document.getElementById('<%=lblUterineGrade.ClientID%>').innerText = ucltext + ' Grade';

                var dropdown = document.getElementById('<%=UterineConditionGrade.ClientID%>');
                dropdown.focus();
            }
            else
                document.getElementById('UterineGrade').style.display = 'none';
        }


        function manSearchAdd() {
            var tagNo = document.getElementById("ManTag").value;
            //if (tagNo == '') {
            //    tagNo = document.getElementById("FullNumberList").value;
            //}       
            var herdID = sessionStorage.getItem('HerdID');
            var sql = "SELECT * FROM Cows where NationalID like '%" + tagNo + "%' and InternalHerdID = '" + herdID + "'";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
            if (db) {
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                    function (transaction, results) {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length > 1) {
                            App.alert("Animals Found", results.rows.length + " animals found please select one from list");
                            var select = document.getElementById('FullNumberList');
                            for (z = 0; z < results.rows.length; z++) {
                                var row = results.rows.item(z);
                                select.options[select.options.length] = new Option(row.NationalID, row.NationalID);
                            }
                            //if(row.Exception!='')
                            //{
                            //    alert(row.Exception);
                            //}
                            //if(row.WithdrawalDate!='')
                            //{
                            //    alertWithdrawal(row.WithdrawalDate);
                            //}
                            select.style.display = 'block';
                            showSelect(select); // showing the new select
                            document.getElementById('ManTag').value = '';
                        }
                            //else if (results.rows.length == 1)
                            //{
                            //    var row = results.rows.item(0);
                            //    var skip = false;
                            //    document.getElementById('FullNumberList').style.display = 'none';
                            //    document.getElementById('FullNumberList').options.length = 0;
                            //    if(row.Exception!=''){
                            //        App.alert("Exception", row.Exception);
                            //    }
                            //    if(row.WithdrawalDate!=''){
                            //        alertWithdrawal(row.WithdrawalDate);
                            //    }
                            //    if (skip == false){
                            //        if(document.getElementById("EIDAnimalList")){
                            //            //var listBox = document.getElementById("EIDAnimalList");
                            //            //var opt = document.createElement("option");
                            //            listBox.options.add(opt, 0);
                            //            opt.text = row.NationalID;
                            //            opt.value = row.InternalAnimalID;
                            //            var counter = document.getElementById("Count");
                            //            counter.value = listBox.length;
                            //            addToList(row.NationalID, null);
                            //        }
                            //    }
                            //}
                        else {
                            App.alert("Records", "No records found");
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
                });
            }
            else {
                App.alert("Database", 'Cant open database');
            }
        }


        function manSearchSelect() {
            //var tagNo = document.getElementById("ManTag").value;
            var index = document.getElementById("FullNumberList").selectedIndex;
            var tagNo = document.getElementById("FullNumberList").options[index].text;

            var herdID = sessionStorage.getItem('HerdID');
            var sql = "SELECT * FROM Cows where NationalID like '%" + tagNo + "%' and InternalHerdID = '" + herdID + "'";
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
                            document.getElementById('FullNumberList').style.display = 'none';
                            hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                            document.getElementById('FullNumberList').options.length = 0;
                            if (row.Exception != '') {
                                App.alert("Exception", row.Exception);
                            }
                            if (row.WithdrawalDate != '') {
                                alertWithdrawal(row.WithdrawalDate);
                            }
                            if (skip == false) {
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
                        }
                        else {
                            App.alert("Records", "No records found");
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
                });
            }
            else {
                App.alert("Database", 'Cant open database');
            }
        }



         //function readNfcTag(nfcTagNumber){
         //     var decimal=nfcTagNumber;
         //     //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0)) {
                  
         //         var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + HerdID + ")";
         //         db.transaction(function(transaction) {
         //             transaction.executeSql(sql, [],
         //                 function(transaction, results) {
         //                     //var listBox = document.getElementById("EIDAnimalList");
         //                     //var opt = document.createElement("option");
                              
         //                     // results.rows holds the rows returned by the query
         //                     if (results.rows.length == 1) {
         //                         var row = results.rows.item(0);
         //                         var skip = false;
                                 
         //                         if(row.Exception!=''){
         //                             App.alert("Exception", row.Exception);
         //                         }
         //                         if(row.WithdrawalDate!=''){
         //                             alertWithdrawal(row.WithdrawalDate,"VetAction");
         //                         }
                                
         //                             if (skip == false) {
         //                                 var exists = false;
         //                                 //
         //                                 var table = document.getElementById('AnimalListTable');
         //                                 var existRow = false;
         //                                 var rowCount = 0;
         //                                 if (table != null) {
         //                                     var tbody = table.getElementsByTagName("tbody")[0];
         //                                     rowCount = tbody.rows.length;
         //                                 }

         //                                 for (var k = 0; k < rowCount; k++) {
         //                                     var row = table.rows[k];
         //                                     var cells = row.getElementsByTagName("td");
         //                                     if (cells[0].innerText == row.ElectronicID) {
         //                                         existRow = true;
         //                                     }
         //                                 }
         //                                 //
         //                                 //$('#EIDAnimalList option').each(function () {
         //                                 //    if (this.text == row.ElectronicID) {
         //                                 //        exists=true;
         //                                 //    }
         //                                 //});
         //                                 if(!exists){
         //                                     listBox.options.add(opt, 0);
         //                                     opt.text = row.ElectronicID;
         //                                     opt.value = row.InternalAnimalID;
         //                                     setSelectedIndex(listBox, opt.value);
         //                                     var counter = document.getElementById("Count");
         //                                     counter.value = listBox.length;
         //                                     addToList(row.ElectronicID, null);
         //                                 }
         //                             }
                                     
         //                         }
         //                         else {
         //                         App.message(decimal + " Animal not found");
         //                           }
         //               },
         //                 function(transaction, error) {
         //                     App.alert("Error","Could not read: " + error.message);
         //                 });
         //       });

         //   //}
         // }


        function searchFBBatchAfter(pType) {
            var filterInput = document.getElementById("filterInput").value;
            var i;

            var input_array = filterInput.split(",");
            document.forms[0].HidAnimalList.value = '';
            document.forms[0].HidAnimalNos.value = '';
            document.forms[0].HidCalfNationalID.value = '';

            for (i = 0; i < input_array.length; i++) {
                if (input_array[i] == '') {
                    continue;
                }
                if (input_array[i].length > 10) {
                    App.alert("InCorrect Cow Number", "All cow numbers must be less than 10 characters:" + input_array[i]);
                    return false;
                    if (searchFB(input_array[i], true) == false) {
                        return false;
                    }
                }
                document.getElementById("filterInput").value = "";
                return true;
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function searchFBFind() {
            var filterInput = document.getElementById("filterInput").value;
            if (!filterInput) {
                App.alert("Please Enter","Please enter 1 or more cow numbers seperated by a comma");
                return false;
            }
            if (searchFB(filterInput, false) == false) {
                return false;
            }
        }

        function processForm() {
            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("Please Select", "No cow selected");
                    return false;
                }
            }
            if (ValidateDate() == false)
                return false;
            document.forms[0].IsSubmitted.value = true;
            return true;
        }
        function setHidTitle() {
            var pEventType = 'VetAction';
            var title = "";
            if (document.getElementById("Eidinputdate")) {
                title += document.getElementById("Eidinputdate").value;
            }
            title += document.getElementById("inputdate").value;
            //document.forms[0].DoneDay.value + "/" +document.forms[0].DoneMonth.value  + "-";

            var opts = document.forms[0].AnimalList;
            var cow = opts.options[opts.selectedIndex].text;
            if (document.forms[0].HidAnimalNos.value != '') {
                cow = document.forms[0].HidAnimalNos.value;
            }
            if (document.forms[0].HidAnimalsToAdd.value != '') {
                cow = document.forms[0].HidAnimalsToAdd.value;
            }
            // just copy first 15 chars if its too long
            if (cow.length > 15) {
                cow = cow.substring(0, 15);
            }
            title += pEventType.substring(0, 5) + "-" + cow;
            document.forms[0].HidTitle.value = title;
        }
    </script>

</asp:Content>
