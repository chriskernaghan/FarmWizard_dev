<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="FosterPage.aspx.cs" Inherits="HybridAppWeb.FosterPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">

            <div class="panale panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Foster Dam NationalID :</b>

                            <asp:TextBox ID="FosterDamEID" runat="server" readonly="true" class="form-control" MaxLength="20"></asp:TextBox>

                            <div style="margin-top: 5px"></div>
                            <a href="#" id="ReadFosterLambs" class="btn btn-primary waves-effect waves-light" onclick="scanLambTag();">Read Lamb Tag</a><br>
                            <br>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Lamb NationalID :</b>

                            <asp:TextBox ID="FosterLambEID" readonly="true" runat="server" class="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                    <div align="center">

                        <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Foster</a>
                    </div>
                </div>
            </div>
    </div>

    <script type = "text/javascript">

        var db;
        var lambTag = false;

        function checkInput()
        {
            var pType = "Foster";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

            var getLocation = false;

            
            //if (isEID == 1) 
            //{   
                    if(document.getElementById("<%=FosterDamEID.ClientID%>").value == "") 
                    {
                        App.message("No Foster Ewe ID scanned");
                        return false;
                    }
                    if(document.getElementById("<%=FosterLambEID.ClientID%>").value == "") 
                    {
                        App.message("No Foster Lamb ID scanned");
                        return false;
                    }
                document.forms[0].HidTitle.value = "Recorded " + pType + " animals";
            //}

            // document.forms[0].NFCID.value="787000853605892(982000175198006)";
            if(document.getElementById("filterInput") && document.getElementById("filterInput").value) 
            {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if(document.getElementById("filterInput").value.indexOf('"') > -1) 
                {
                    App.alert("Please enter", "Cant enter \" in the cow number box");
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
            var pType = "Foster";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

			//var opts = document.forms[0].AnimalList;
           
			//if (opts) {
			//	document.forms[0].HidAnimalList.value = opts.value;
			//	document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
			//	if (document.forms[0].HidAnimalList.value == "0") {
			//		App.alert("Please Select", "Please select or type a cow number");
			//		return false;
			//	}
			//	if (processForm() == false) 
			//	{
			//		return false;
			//	}
			//}

			WriteFormValues("FosterPage.aspx?Type=Add" + pType  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

			if("<%=Master.HandsFree%>" != "") 
			{
				if ("<%=Master.IsMulti%>" == "true")
				{
					AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
					var  voiceRespM = AsyncAndroid.GetVoiceCommand();
					if(voiceRespM!="no"){

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
				App.alert("Successful", msg);
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




        <%--function readNfcTag(nfcTagNumber)
        {                                     
            var decimal=nfcTagNumber;
            //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0))
            //{    
                var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + HerdID + ")";
                db.transaction(function(transaction) 
                {
                    transaction.executeSql(sql, [],
                        function (transaction, results)
                        {
                            //var listBox = document.getElementById("EIDAnimalList");
                            //var opt = document.createElement("option");
                              
                            // results.rows holds the rows returned by the query
                            if (results.rows.length == 1)
                            {
                                var row = results.rows.item(0);
                                var skip = false;
                                 
                                if(row.Exception!=''){
                                    App.alert("Exception",row.Exception);
                                }
                                if(row.WithdrawalDate!=''){
                                    alertWithdrawal(row.WithdrawalDate,"Foster");
                                }
                                                                
                                var field = document.getElementById("<%=FosterDamEID.ClientID%>").value; 
                                    
                                if((field==null)||(field==""))
                                {                                    
                                    var fosterDam = document.getElementById("<%=FosterDamEID.ClientID%>");
                                    fosterDam.value = row.ElectronicID;
                                }
                                else
                                {
                                    var lambEID=document.getElementById("<%=FosterLambEID.ClientID%>");
                                    lambEID.value=row.ElectronicID;
                                }
                            
                                      
                                if (skip == false) {
                                    var exists=false;
                                    //
                                    var table = document.getElementById('AnimalListTable');
                                    var existRow = false;
                                    var rowCount = 0;
                                    if (table != null) {
                                        var tbody = table.getElementsByTagName("tbody")[0];
                                        rowCount = tbody.rows.length;
                                    }

                                    for (var k = 0; k < rowCount; k++) {
                                        var row = table.rows[k];
                                        var cells = row.getElementsByTagName("td");
                                        if (cells[0].innerText == row.ElectronicID) {
                                            existRow = true;
                                        }
                                    }
                                    //
                                    //$('#EIDAnimalList option').each(function () {
                                    //    if (this.text == row.ElectronicID) {
                                    //        exists=true;
                                    //    }
                                    //});
                                    if(!exists){
                                        listBox.options.add(opt, 0);
                                        opt.text = row.ElectronicID;
                                        opt.value = row.InternalAnimalID;
                                        setSelectedIndex(listBox, opt.value);
                                        var counter = document.getElementById("Count");
                                        counter.value = listBox.length;
                                        addToList(row.ElectronicID, null);
                                    }
                                }
                            }
                            else
                            {
                                if (lambTag) {
                                    addLamb(decimal); 
                                }
                                else
                                {
                                    
                                    App.message(decimal + " Animal not found");
                                }
                            }
                        },
                        function (transaction, error)
                        {
                            App.alert("Error","Could not read: " + error.message);
                        });
                });
            //}
            
        }--%>


        function manSearchAdd()
        {
            var tagNo = document.getElementById("ManTag").value;
            //if (tagNo == '') {
            //    tagNo = document.getElementById("FullNumberList").value;
            //}       
            var herdID = sessionStorage.getItem('HerdID');

            
            var sql =  "SELECT * FROM Cows where NationalID like '%" + tagNo + "%' and InternalHerdID = '" + herdID + "'";
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
                            if(row.Exception!='')
                            {
                                App.alert("Exception",row.Exception);
                            }
                            if(row.WithdrawalDate!='')
                            {
                                alertWithdrawal(row.WithdrawalDate);
                            }
                            select.style.display = 'block';
                            showSelect(select); // showing the new select
                            document.getElementById('ManTag').value = '';
                        }
                        else if (results.rows.length == 1)
                        {
                            var row = results.rows.item(0);
                            var skip = false;
                            document.getElementById('FullNumberList').style.display = 'none';
                            hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                            document.getElementById('FullNumberList').options.length = 0;
                            if(row.Exception!=''){
                                App.alert("Exception",row.Exception);
                            }
                            if(row.WithdrawalDate!=''){
                                alertWithdrawal(row.WithdrawalDate);
                            }
                                var tag = document.getElementById("<%=FosterDamEID.ClientID%>");
                                tag.value = row.ElectronicID;
                        }
                        else {
                            App.alert("Records","No records found");
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error","Could not read: " + error.message);
                    });
                });
            }
            else {
                App.alert("Database",'Cant open database');
            }
        }



        function manSearchSelect()
        {
            //var tagNo = document.getElementById("ManTag").value;
            var index = document.getElementById("FullNumberList").selectedIndex;
            var tagNo = document.getElementById("FullNumberList").options[index].text;
      
            var herdID = sessionStorage.getItem('HerdID');       
            var sql =  "SELECT * FROM Cows where NationalID like '%" + tagNo + "%' and InternalHerdID = '" + herdID + "'";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
            if (db) {
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                    function (transaction, results) {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1)
                        {
                            var row = results.rows.item(0);
                            var skip = false;
                            document.getElementById('FullNumberList').style.display = 'none';
                            hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                            document.getElementById('FullNumberList').options.length = 0;
                            if(row.Exception!=''){
                                App.alert("Exception",row.Exception);
                            }
                            if(row.WithdrawalDate!=''){
                                alertWithdrawal(row.WithdrawalDate);
                            }
                                var tag = document.getElementById("<%=FosterDamEID.ClientID%>");
                                tag.value = row.ElectronicID;
                        }
                        else {
                            App.alert("Records","No records found");
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error","Could not read: " + error.message);
                    });
                });
            }
            else {
                App.alert("Database",'Cant open database');
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
                                App.alert("Exception", row.Exception);
                            }
                            if (row.WithdrawalDate != '') {
                                alertWithdrawal(row.WithdrawalDate);
                            }
                            if(lambTag)
                            {
                                var tag = document.getElementById("<%=FosterLambEID.ClientID%>");
                                tag.value = row.NationalID;     
                                lambTag = false;
                            }// if
                            else
                            {
                                var tag = document.getElementById("<%=FosterDamEID.ClientID%>");
                                tag.value = row.NationalID;
                            }// else
                        }
                        else {
                            App.alert("Error", "No records found");
                        }
                    },
                 function (transaction, error) {
                     App.alert("Error", "Could not read: " + error.message);
                 });
                });
            }
            else {
                App.alert("Database",'Cant open database');
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
        //function  readTag(tag) {
            //var herdID = sessionStorage.getItem('HerdID');
            //var decimal = tag;
            //var sql = "SELECT * FROM Cows where (ElectronicID = '" + decimal + "' AND InternalHerdID = " + HerdID + ")";                  
            db.transaction(function(transaction){                    
                transaction.executeSql(sql, [],                         
                    function (transaction, results){
                        //var listBox = document.getElementById("EIDAnimalList");
                        //var opt = document.createElement("option");
                                      
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1)
                        {
                            var row = results.rows.item(0);
                            var skip = false;

                            if (row.Exception != ''){
                                App.alert("Exception",row.Exception);
                            }
                            if (row.withdrawalDate != ''){
                                alertWithdrawal(row.WithdrawalDate);
                            }
                            var field = "<%=FosterDamEID.ClientID%>";
                            if (lambTag){
                                field = "<%=FosterLambEID.ClientID%>";
                            }
                            var tagField = document.getElementById(field);
                            //tagField.value = tag;  
                            tagField.value = row.NationalID;
                        } else
                        {
                            
                            App.message(tag + " Animal not found");                                    
                        }
                    },                
                    function(transaction, error) {
                        App.alert("Error","Could not read: " + error.message);
                    });
            });
                // Only do a single tag for foster lamb or not
                stopReading = 1;
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
            SetDates("Foster");
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

            //FillDynamicList("DoneObservedBy", "DoneObservedBy", HerdID,0);

            if (isEID == 1){
                document.getElementById('selectedAnimalsTable').style.display = 'block';
                   // document.getElementById('StartScanButton').style.display = 'none';
                    if(<%=Master.IsInnova%> == "0"){
                        if(document.getElementById('Lambtable')){
                            document.getElementById('T4').style.display = 'none';
                            document.getElementById('T5').style.display = 'none';
                            document.getElementById('T6').style.display = 'none';
                    }
                }
            }
        }


        function seachOnAnimalID(animalID) 
        {    
            var eventType = "Foster";
            // Search database Datastore
            if (!animalID) {
                animalID = document.getElementById("AnimalList").value;
            }
            var sql = "SELECT * FROM Cows where (InternalAnimalID = '" + animalID + "' AND InternalHerdID = " + HerdID + ")";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                    function (transaction, results) {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) {
                            var row = results.rows.item(0);

                            document.forms[0].HidAnimalList.value = row.InternalAnimalID;
                            document.forms[0].HidAnimalNos.value = row.FreezeBrand;

                            // Set Days Pregnant
                            if ((eventType == 'Scan') || (eventType == 'VetAction')) {
                                var lastServedOn = new Date(row.LastServedDate.substring(6),
                                        row.LastServedDate.substring(3, 5) - 1, row.LastServedDate.substring(0, 2));
                                var today = new Date();
                                var days = (today.getTime() - lastServedOn.getTime()) / 86400000;
                                days = Math.round(days);
                                if (eventType == 'Scan') {
                                    document.getElementById("LastServedText").firstChild.data = row.LastServedDate + " " + row.LastServedTo;
                                    document.forms[0].DaysPregnant.value = '';
                                    if ((days > 0) && (days < 280)) {
                                        document.forms[0].DaysPregnant.value = days;
                                    }
                                }
                                else {
                                    if (document.forms[0].PregDiagnosisDays) {
                                        document.forms[0].PregDiagnosisDays.value = '';
                                        document.getElementById("PregDiagnosisText").firstChild.data = row.LastServedDate + " " + row.LastServedTo;
                                    
                                        if ((days > 0) && (days < 280)) {
                                            document.forms[0].PregDiagnosisDays.value = days;
                                        }
                                    }
                                }
                            }

                            else if (eventType == 'Treatment') {
                                if(document.getElementById('EIDEntryPanel')){
                                    if((document.getElementById("EIDAnimalList").options.length)!=0){
                                        document.getElementById("TreatHistoryText").firstChild.data = row.TreatmentText;
                                    }
                                }
                                else{
                                    document.getElementById("TreatHistoryText").firstChild.data = row.TreatmentText;
                                }
                            }

                            else if (eventType == 'Birth') {
                                selectOption("SireList1", row.LastServedTo, 5);
                            }
                        }
                    },
                      function (transaction, error) {
                          App.alert("Error","Could not read: " + error.message);
                      });
            });
            return true;
        }


        function confirmRecord(pId, pValue)
        {
            if(pValue == false){
                return false;
            }// if
            else {
                if (searchFBBatchAfter("Foster") == false) {
                    return false;
                    //$('#EIDAnimalList').empty();
                    checkInput();
                }
                //$('#EIDAnimalList').empty();
                checkInput();
                return false;
            }// else
        }// confirmRecord


        function scanLambTag()
        {   
            lambTag = true;
        }

        function processForm() {
            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("Please Select","No cow selected");
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
