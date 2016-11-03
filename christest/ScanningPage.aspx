<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="ScanningPage.aspx.cs" Inherits="HybridAppWeb.ScanningPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>Served :</strong><span id="LastServedText">_</span>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                    <asp:Label ID="Label23" runat="server" Font-Bold="True">Scan Result :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="Results" runat="server" EnableViewState="False">
                        <asp:ListItem Value="No">Not Pregnant</asp:ListItem>
                        <asp:ListItem Value="Yes">Pregnant</asp:ListItem>
                        <asp:ListItem Value="Recheck">Recheck</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label24" runat="server" Font-Bold="True">Days Pregnant :</asp:Label></strong>

                    <asp:TextBox ID="DaysPregnant" type="number" onkeydown="return isNumberKey(event);" class="form-control input-sm" runat="server"></asp:TextBox>
                </div>
            </div>
             <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label999" runat="server">Sire National ID :</asp:Label></strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="SireNationalIDList" runat="server">
                    <asp:ListItem Value="N/A" Selected="True">N/A</asp:ListItem></n0:MOBILEDROPDOWNLIST>
                </div>
                 </div>
        </div>
        <div align="center">

            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Scan</a>
        </div>
    </div>

     <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
<button type="button" id="RadioPreg" class="btn btn-primary waves-effect waves-light btn-lg btn-block">Pregnant</button>
            <br />
<button type="button" id="RadioNon" class="btn btn-danger btn-lg btn-block">NotPregnant</button>
           
        </div>
      </div>
      
    </div>
  </div>
          <div class="modal fade" id="SireModal" role="dialog" >
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
           <span onclick="selectsire();" class="close">X</span>
        <div class="modal-header">
            <asp:Label runat="server" Font-Bold="true">Sire NationalID:</asp:Label>
<n0:MOBILEDROPDOWNLIST class="form-control" id="ListSire" onchange="selectsire();" runat="server">
    <asp:ListItem Value="N/A" Selected="True">N/A</asp:ListItem>
                                    </n0:MOBILEDROPDOWNLIST>
           
        </div>
      </div>
      
    </div>
  </div>

    <script type = "text/javascript">

        var db;
        var scanResult = false;

        function checkInput() 
        {
            var pType = "Scan";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var herdID = sessionStorage.getItem('HerdID');

            var getLocation = false;

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this

            if (document.getElementById("<%=ListSire.ClientID%>").value != "N/A") {
                //document.forms[0].ListSireName.value=document.getElementById("ListSire").value;
                document.getElementById("<%=SireNationalIDList.ClientID%>").value = document.getElementById("<%=ListSire.ClientID%>").value;
            }

            // Days Pregnant must be set
            if (document.getElementById("<%=Results.ClientID%>").value == 'Yes') 
            {
                if (document.getElementById("<%=DaysPregnant.ClientID%>").value == '') 
                {
                    App.alert("Please enter" ,"Days pregnant not specified");
                    return false;
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
            //    var animals = document.getElementById("EIDAnimalList").options;
            //    var count = animals.length;

            //    if (count == 0) {
            //        App.message("No animals scanned : Please Scan EID");
            //        return false;
            //    }

            //    var animalList = "";
            //    //  alert("check process "+  document.forms[0].NFCID.value);
            

            //    for (var k = 0; k < count; k++) {
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

            if(document.getElementById("filterInput") && document.getElementById("filterInput").value) 
            {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if(document.getElementById("filterInput").value.indexOf('"') > -1) 
                {
                    App.alert("Result", "Cant enter \" in the cow number box");
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
            var pType = "Scan";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;
            var msg;

			//var opts = document.forms[0].AnimalList;
	   
			//if (opts) {
			//	document.forms[0].HidAnimalList.value = opts.value;
			//	document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
			//	if (document.forms[0].HidAnimalList.value == "0") {
			//		App.alert("Select", "Please select or type a cow number");
			//		return false;
			//	}
			//	if (processForm("Scan") == false) {
			//		return false;
			//	}
			//}
		   
			var scorelist = '';
			
			//this is commented out until the database supports it
			//if (getLocation == true)
			//    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			//else
			
			if ((document.getElementById("<%=SireNationalIDList.ClientID%>").value != "N/A")&&(document.getElementById("<%=Results.ClientID%>").value == 'Yes')) {
			    //var strDate = document.getElementById("Eidinputdate").value.split('-');
			    var strDate = document.getElementById("inputdate").value.split('-');
			    
			    nrAddDays = document.getElementById("<%=DaysPregnant.ClientID%>").value;
			    var date = new Date(parseInt(strDate[0]), parseInt(strDate[1]) - 1, parseInt(strDate[2]));

			    /* Add nr of days*/
			    date.setDate(date.getDate() - nrAddDays);

			    var d = new Date(date.toString());
			    var result = `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;

			    //document.getElementById("Eidinputdate").value = result;
			    document.getElementById("inputdate").value = result;

			    //document.forms[0].HidTitle.value = "Recorded BullService animals";
			    //WriteFormValues("BullServicePage.aspx?Type=AddBullService&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			    //msg = pType + " , BullService has been recorded and will be transferred at next synchronisation";
			}

			//document.getElementById('Eidinputdate').value = setDate;
			//document.getElementById('inputdate').value = setDate;

            WriteFormValues("ScanningPage.aspx?Type=AddScan&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            msg = "Scan has been recorded and will be transferred at next synchronisation";

			if("<%=Master.HandsFree%>" != "") 
			{
				if ("<%=Master.IsMulti%>" == "true")
				{
					AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
					var  voiceRespM = AsyncAndroid.GetVoiceCommand();
					if (voiceRespM != "no")
					{

					}
					else
					{
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
				App.alert("Result",msg);
			}
			else  {
				App.message(msg); 
			} 

			isCommitted = 1;
            var aniTable = document.getElementById("AnimalListTable");
            if(aniTable!=null)
            aniTable.parentNode.removeChild(aniTable);

            //$('#EIDAnimalList').empty();

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


        function readTag(tag) {
       var herdID= sessionStorage.getItem('HerdID');
                var sql = "SELECT * FROM Cows where (ElectronicID = '" + tag + "' AND InternalHerdID = " + herdID + ")";
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                        function (transaction, results) {
                            //var listBox = document.getElementById("EIDAnimalList");
                            //var opt = document.createElement("option");

                            // results.rows holds the rows returned by the query
                            if (results.rows.length == 1) {

                                var row = results.rows.item(0);

                                if (row.Exception != '') {
                                    App.alert("Exception", row.Exception);
                                }
                                if (row.withdrawalDate != '') {
                                    alertWithdrawal(row.WithdrawalDate);
                                }
                                //if (document.getElementById("EIDAnimalList") != null) {
                                    //listBox.options.add(opt, 0);
                                    //opt.text = tag;
                                    //opt.value = row.InternalAnimalID;
                                    //setSelectedIndex(listBox, opt.value);
                                    //var counter = document.getElementById("Count");
                                    //counter.value = listBox.length;
                                    addToList(row.NationalID, null);
                                    var daysPreg = "";
                                    var preg;
                                    if (row.LastServedDate != "") {
                                        var lastServedOn = new Date(row.LastServedDate.substring(6),
    row.LastServedDate.substring(3, 5) - 1, row.LastServedDate.substring(0, 2));
                                        var today = new Date();
                                        var days = (today.getTime() - lastServedOn.getTime()) / 86400000;
                                        days = Math.round(days);

                                        document.getElementById("LastServedText").firstChild.data = row.LastServedDate + " " + row.LastServedTo;
                                        document.getElementById("<%=DaysPregnant.ClientID%>").value = '';
                                        if ((days > 0) && (days < 280)) {
                                            daysPreg = days;
                                        }
                                    }
                                    if ($('#myModal').modal('show')) {
                                        document.getElementById("RadioPreg").onclick = function () { preg = true; Scanning("Scan", preg, daysPreg); };
                                        document.getElementById("RadioNon").onclick = function () { Preg = false; Scanning("Scan", preg, daysPreg); };
                                    }
                                //}
                            }// results = 1

                            else {
                                
                                App.message(decimal + " Animal not found");
                                }

                            },
                 function (transaction, error) {
                     App.alert("Error", "Could not read: " + error.message);

                 });
                    });
        }

        function initPage() 
        {
            
            var isEID = "<%=Master.IsEID%>";

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
            SetDates("Scan");
           var herdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
            //FillDynamicList("AnimalList", "AnimalList", herdID, 1, defaultAnimalID);
            
            if (defaultAnimalID) {
                seachOnAnimalID(defaultAnimalID);
            }
            if (isEID == 1) 
            {          
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if (document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }
            }
                var herd="<%=this.HerdList%>";
                var tempArray=new Array();
                tempArray=herd.split(",");
                for(var i=0;i<tempArray.length;i++){
                    FillDynamicList("<%=ListSire.ClientID%>", "BullBirthEarTag", tempArray[i], 0);
                    FillDynamicList("<%=SireNationalIDList.ClientID%>", "BullBirthEarTag", tempArray[i], 0);}
                     
        }



        function seachOnAnimalID(animalID)
        {
            
            // Search database Datastore
            if (!animalID)
            {
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
                    function (transaction, results) {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1)
                        {
                            var row = results.rows.item(0);

                            document.forms[0].HidAnimalList.value = row.InternalAnimalID;
                            document.forms[0].HidAnimalNos.value = row.FreezeBrand;

                            var lastServedOn = new Date(row.LastServedDate.substring(6),
                                    row.LastServedDate.substring(3, 5) - 1, row.LastServedDate.substring(0, 2));
                            var today = new Date();
                            var days = (today.getTime() - lastServedOn.getTime()) / 86400000;
                            days = Math.round(days);

                            document.getElementById("LastServedText").firstChild.data = row.LastServedDate + " " + row.LastServedTo;
                            document.getElementById("<%=DaysPregnant.ClientID%>").value = '';
                            if ((days > 0) && (days < 280)) {
                                document.getElementById("<%=DaysPregnant.ClientID%>").value = days;
                            }           
                        }
                    },
                      function (transaction, error)
                      {
                          App.alert("Error", "Could not read: " + error.message);
                      });
            });
            return true;
        }


        function searchFB(filterInput, postEntry)
        {
            // Search database Datastore
            var sql = "SELECT * FROM Cows where (FreezeBrand = '" + filterInput + "' AND InternalHerdID = " + HerdID + ")";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter)
            {
                sql += extraFilter;
            }

            db.transaction(function (transaction)
            {
                transaction.executeSql(sql, [],
                function (transaction, results)
                {
                    // results.rows holds the rows returned by the query
                    if (results.rows.length == 1)
                    {
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

                            document.getElementById("LastServedText").firstChild.data = row.LastServedDate + " " + row.LastServedTo;
                            document.getElementById("<%=DaysPregnant.ClientID%>").value = '';
                            if ((days > 0) && (days < 280)) {
                                document.getElementById("<%=DaysPregnant.ClientID%>").value = days;
                            }

                            if ("<%=Master.HandsFree%>" != "")
                            {
                                while (true)
                                {
                                    var daysPreg = "";
                                    if(document.getElementById("<%=DaysPregnant.ClientID%>").value != '') {
                                        daysPreg = "From service date cow should be " + document.getElementById("<%=DaysPregnant.ClientID%>").value + " days pregnant." ;
                                    }
                                    AsyncAndroid.ConvertTextToVoicePromptResponse(daysPreg + " Please say days pregnant or, No, if not pregnant or Recheck.");
                                    var voiceRespM = AsyncAndroid.GetVoiceCommand();
                                    if(voiceRespM == "no")  {
                                        setSelectedIndex(document.getElementById("<%=Results.ClientID%>"),"No");
                                        break;
                                    }
                                    else if (voiceRespM == "recheck")
                                    {
                                        setSelectedIndex(document.getElementById("<%=Results.ClientID%>"),"Recheck");
                                        break;
                                    }
                                    else if (isNaN(voiceRespM))
                                    {
                                        continue;
                                    } 
                                    else
                                    {
                                        setSelectedIndex(document.getElementById("<%=Results.ClientID%>"),"Yes");
                                        document.getElementById("<%=DaysPregnant.ClientID%>").value = voiceRespM;
                                        break;
                                    }
                                }
                                checkInput();
                                if ("<%=Master.IsMulti%>" == "true")
                                {
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
                        }
                    }
                    else if (results.rows.length > 1)
                    {
                        App.alert("Result", "More than one matching cow found " + results.rows.length);
                        return false;
                    }
                    else
                    {
                        if("<%=Master.HandsFree%>" != "") {
                            initPage();
                        }
                        else {
                            App.alert("Result", "No matching cows for " + filterInput);
                        }
                        return false;                     
                    }
                },
                  function (transaction, error) {
                      App.alert("Error", "Could not read: " + error.message);
                  });
            });
            return true;
        }

        function selectsire() {
            scanResult = true;
            document.getElementById("<%=SireNationalIDList.ClientID%>").value = document.getElementById("<%=ListSire.ClientID%>").value;

            $('#SireModal').modal('hide');

            if (confirm("Continue recording scans?")) {

                //Added Pending List with out asking Click OK to confirm you wish record a scan
                SingleScan = true;
                checkInput("Scan");
                document.getElementById("LastServedText").firstChild.data = "";
                //$('#EIDAnimalList').empty();
                 document.getElementById("<%=DaysPregnant.ClientID%>").value="";
                SetDates('Scan');
                //if (connectToDevice()) {
                //    readBTTags(0);
                //}
            }
            else {
                //Auto save for last scan animals
                checkInput("Scan");
                document.getElementById("LastServedText").firstChild.data = "";
                //$('#EIDAnimalList').empty();
                document.getElementById("myForm").reset();

            }
        }

       function Scanning(eventType,preg,daysPreg){
           var daysValue;

          if("<%=this.BeefUser%>"=="1"){
              daysValue=70;
          }
          else{
              daysValue=40;
          }
          if(preg){
              document.getElementById("<%=Results.ClientID%>").value="Yes";
              if(daysPreg!=""){
                  document.getElementById("<%=DaysPregnant.ClientID%>").value = daysPreg;
                  scanResult=true;
              }
              else{
               if(confirm("No Service Date Recorded : Use "+ daysValue +" days Pregnant?")){
                  document.getElementById("<%=DaysPregnant.ClientID%>").value=daysValue;
              }
              else{
                  var days= window.prompt("Please enter Days Pregnant:", "");
                  if(days!=null){
                      document.getElementById("<%=DaysPregnant.ClientID%>").value=days;
                  }
                  else{
                      $('#myModal').modal('hide');
                      return false;
                  }
               }
               scanResult=false;
               $('#SireModal').modal('show');
              
          }
          }
          else if(!preg){ 
              document.getElementById("<%=Results.ClientID%>").value="No";
              scanResult=true;
          }

          $('#myModal').modal('hide');
         
          if(scanResult){
            
              if(confirm("Continue recording scans?")){

                  //Added Pending List with out asking Click OK to confirm you wish record a scan
                  SingleScan =true;
                  checkInput("Scan");
                  document.getElementById("LastServedText").firstChild.data="";
                  //$('#EIDAnimalList').empty();
                  document.getElementById("<%=DaysPregnant.ClientID%>").value="";
                  SetDates('Scan');
                  //if (connectToDevice()) {
                  //    readBTTags(0);
                  //}
              }
              else{
                  //Auto save for last scan animals
                  checkInput("Scan");
                  document.getElementById("LastServedText").firstChild.data="";
                  //$('#EIDAnimalList').empty();
                  document.getElementById("<%=DaysPregnant.ClientID%>").value="";
                  document.getElementById("myForm").reset();
                 
              }
          }
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

        function setHidTitle() {
            var pEventType = 'Scan';
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


        function ScoreResults(pId, pValue) {
            if (pValue == false) {
                return;
            }
            else {
                var value = pValue;
                if (isNaN(value)) {
                    App.textInput("Please enter", "Please enter Days Pregnant (must be numeric):", "ScoreResults", pId, true)
                }
                else {
                    App.alert("TEST", "test test test " + value);
                }// else
            }// else
        }// ScoreResults
    </script>

    <style>
        #myModal, #SireModal {
            text-align: center;
            vertical-align: middle;
            height: 100%;
        }

        #RadioPreg, #RadioNon {
            padding: 18px 28px;
            font-size: 22px;
            border-radius: 8px;
        }
        /* The Close Button */
.close {
    color: deepskyblue;
    float: right;
    font-size: 50px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: blue;
    text-decoration: none;
    cursor: pointer;
}
    </style>
</asp:Content>
