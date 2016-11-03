<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="ReTag.aspx.cs" Inherits="HybridAppWeb.ReTag" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
         <div class="row">
                    <div class="form-group col-xs-6">
                        <b>New EID:</b>
                        <asp:TextBox ID="EIDMatch" runat="server" class="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="form-group col-xs-6">
                        <b>Existing Tag:</b>

                        <asp:TextBox ID="NationalIDTagMatch" runat="server" class="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <br />
                <div align="center">
                    <input class="btn btn-primary waves-effect waves-light" type="button" onclick="checkInput()" value="Record Match/Retag" />
                </div>
    </div>

    <script type = "text/javascript">

        var db;

        function checkInput()
        {
            var pType = 'ReTag';
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var herdId = sessionStorage.getItem('HerdID');

            var getLocation = false;
            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this

            //if (isEID == 1) 
            //{            
                // Remove the calf nationalID
                // Taking this out for now
                //document.forms[0].HidCalfNationalID.value = document.getElementById("CalfEarTag").value;
                //removeOptions(document.getElementById("CalfEarTag"));
            if (pType == "ReTag") 
            {
                if (document.getElementById("<%=EIDMatch.ClientID%>").value == "") 
                {
                    App.message("No Retag ID scanned");
                    return false;
                }
                if (document.getElementById("<%=NationalIDTagMatch.ClientID%>") == "") 
                {
                    App.message("Please select animal from the list");
                    return false; 
                }
            }
                
            var ExistingID = document.getElementById("<%=NationalIDTagMatch.ClientID%>").value;
            var count = 1;
            document.forms[0].HidTitle.value = "Recorded " + pType + " for " + count + " animals";

            //}
					
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
            var pType = "ReTag";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

			//var opts = document.forms[0].AnimalList;
	   
			//if (opts) {
			//	document.forms[0].HidAnimalList.value = opts.value;
			//	document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
			//	if (document.forms[0].HidAnimalList.value == "0") {
			//		App.alert("Please select", "Please select or type a cow number");
			//		return false;
			//	}
			//	if (processForm(pType) == false) {
			//		return false;
			//	}
			//}
		   
			var scorelist='';
			//this is commented out until the database supports it
			//if (getLocation == true)
			//    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			//else
			WriteFormValues("ReTag.aspx?Type=Add" + pType  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

			if("<%=Master.HandsFree%>" != "") 
			{
				if ("<%=Master.IsMulti%>" == "true")
				{
					AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
					var  voiceRespM = AsyncAndroid.GetVoiceCommand();
					if (voiceRespM != "no") {

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
			

        function seachOnAnimalID(animalID)
        {
            var eventType = "ReTag";
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
                        }
                    },
                      function (transaction, error) {
                          alert("Could not read: " + error.message);
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

                            var nationalID = document.getElementById("<%=NationalIDTagMatch.ClientID%>");
                            nationalID.value = row.NationalID;
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
           // var herdID = sessionStorage.getItem('HerdID');
            //var sql = "SELECT * FROM Cows where (ElectronicID = '" + tag + "' AND InternalHerdID = " + herdID + ")";
            db.transaction(function(transaction) {
                transaction.executeSql(sql, [],
                    function(transaction, results) {
                        //var listBox = document.getElementById("EIDAnimalList");
                        //var opt = document.createElement("option");
                                      
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) {

                            var row = results.rows.item(0);
                            var skip = false;

                            if(row.Exception!=''){
                                App.alert("Exception", row.Exception);
                            }
                            if(row.withdrawalDate!=''){
                                alertWithdrawal(row.WithdrawalDate);
                            }
                            var existTag=document.getElementById("<%=NationalIDTagMatch.ClientID%>").value;
                            if((existTag==null)||(existTag=="")){
                                document.getElementById("<%=NationalIDTagMatch.ClientID%>").value=row.NationalID;
                            }
                            else{
                                App.message(tag + " in database already");
                            }
                        }
                        else{
                            var tagMatch = document.getElementById("<%=NationalIDTagMatch.ClientID%>").value;
                            if(tagMatch==""){
                                App.message(tag + " not in database");
                            }
                            else{
                                var nfcNewID=document.getElementById("<%=EIDMatch.ClientID%>");
                                nfcNewID.value=tag;
                            }
                        }
                        
                                      },
                                  function(transaction, error) {
                                      App.alert("Error", "Could not read: " + error.message);
                                  });
            });
            App.message(tag);
         return;
        }


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
<%--                        else if (results.rows.length == 1) {
                            var row = results.rows.item(0);
                            var skip = false;
                            document.getElementById('FullNumberList').style.display = 'none';
                            document.getElementById('FullNumberList').options.length = 0;
                            if(row.Exception!='')
                            {
                                App.alert("Exception", row.Exception);
                            }
                            if(row.WithdrawalDate!='')
                            {
                                alertWithdrawal(row.WithdrawalDate);
                            }                          
                            var nationalID = document.getElementById("<%=NationalIDTagMatch.ClientID%>");
                            nationalID.value = row.NationalID;               
                        }--%>
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
                            if(row.Exception!=''){
                                App.alert("Exception", row.Exception);
                            }
                            if(row.WithdrawalDate!=''){                           
                                alertWithdrawal(row.WithdrawalDate);
                            }
                   
                            var nationalID = document.getElementById("<%=NationalIDTagMatch.ClientID%>");
                            nationalID.value = row.NationalID;               
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



        <%--function readNfcTag(nfcTagNumber)
        {
             var pForLambs = 0;
             var herdID=sessionStorage.getItem('HerdID')
              var decimal=nfcTagNumber;
              
              //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0)) {
                  
                  var sql = "SELECT * FROM Cows where (NFCID = '" + decimal + "'OR ElectronicID='" + decimal + "' AND InternalHerdID = " + herdID + ")";
                  db.transaction(function(transaction) {
                      transaction.executeSql(sql, [],
                          function(transaction, results) {
                              //var listBox = document.getElementById("EIDAnimalList");
                              //var opt = document.createElement("option");
                              
                              // results.rows holds the rows returned by the query
                              if (results.rows.length == 1)
                              {
                                  var row = results.rows.item(0);
                                  var skip = false;
                                 
                                  if(row.Exception!=''){
                                      App.alert("Exception", row.Exception);
                                  }
                                  if(row.WithdrawalDate!=''){
                                      alertWithdrawal(row.WithdrawalDate,"ReTag");
                                  }
                                  var nfcExist=document.getElementById("<%=NationalIDTagMatch.ClientID%>").value;
                                  if ((nfcExist == null) || (nfcExist == ""))
                                  {
                                     document.getElementById("<%=NationalIDTagMatch.ClientID%>").value=row.NationalID;
                                  }

                                  else
                                  {
                                      App.message(decimal + " in database already");
                                  }

                              }
                              else
                              {

                                  var tagMatch = document.getElementById("<%=NationalIDTagMatch.ClientID%>").value;
                                  if (tagMatch == "")
                                  {
                                      App.message(decimal + " not in database");
                                  }
                                  else
                                  {
                                      App.alert("Scan", "Please Scan EID");
                                         // var nfcNewID=document.getElementById("EIDMatch");
                                          //var NID=convertEIDtoNID(decimal);
                                          //nfcNewID.value=NID;
                                  }
                              }


                        
                        },
                          function(transaction, error) {
                              App.alert("Error", "Could not read: " + error.message);
                          });
                });

            //}
        }--%>

        function initPage()
        {
            var isEID = "<%=Master.IsEID%>";
            var HerdID = sessionStorage.getItem('HerdID');
            if(isEID == 1){
                //document.getElementById("Mansearch").innerHTML="Manual Add";
            }
            document.getElementById("selectedAnimalsTable").style.display="none";
        
        db = OpenDatabase();
        if (!db) {
            App.alert("Database", "Cannot open database");
            return;
        }
        SetDates("ReTag");
            // If animalID is set then get it
        var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
        //FillDynamicList("AnimalList", "AnimalList", HerdID, 1, defaultAnimalID);

        if (defaultAnimalID) {
            seachOnAnimalID(defaultAnimalID);
        }

        if(document.getElementById('FullNumberList'))
        {
            document.getElementById('FullNumberList').style.display = 'none';
            hideSelect(document.getElementById('FullNumberList')); // hiding the new select
            document.getElementById('FullNumberList').options.length = 0;
        }
        btRetries = 0;
        isCommitted = 0;
        if (isEID == 1) {
            document.getElementById('selectedAnimalsTable').style.display = 'block';
            if (document.getElementById('ReadMotherTag')) {
                document.getElementById('ReadMotherTag').style.display = 'none';
            }
        }
        }
    </script>

</asp:Content>

