<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="WeighPage.aspx.cs" Inherits="HybridAppWeb.WeighPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">     
        <div align="center">
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
                <div class="form-group col-xs-12">
                    <asp:CheckBox ID="ConditionScoreCheckBox" runat="server" Text="Record Condition Score" OnClick=conditionScoreCheckbox();></asp:CheckBox>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-12">
                    <asp:CheckBox ID="AutoAddWeightCheckBox" runat="server" Text="Auto Add"></asp:CheckBox>
                </div>
            </div>

<%--<table class="formLink" id="EIDWeighTable" style="font-family: Times New Roman; border-collapse: collapse" cellspacing="0" rules="all" border="1">

              <tr style="font-weight: bold; color: white; background-color: #ffcc66">
                    <th id="Td1">Animal</th>
                    <th id="Td2">Kg</th>
                    <th id="Td3">Dlwg</th>
                    <th id="Td4">Previous</th>
                    <th id="Td6">Move?</th>
                    <th id="Td7">Score</th>
                    <th id="Td8">Delete?</th> </tr>
            </table>--%>
            <div class="row">
                <div class="form-group col-xs-12">
                    <div id="weightAnimalsTable">
            
                    </div>
                </div>
            </div>
            <div id="SaveWeightButton">
                <div style="margin-top: 5px"></div>
                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="addEIDWeight();">Save Weights</a>
            </div>
        </div>
    </div>

    <script type = "text/javascript">

        //
        var db;
        var animalSelected = "";
        var tagScanned = "";
        //

        function checkInput() 
        {
            var pType = "EIDWeigh";           
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var isEID = "<%=Master.IsEID%>";
            var getLocation = false;

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this

            //if (isEID == 1) 
            //{            
            //    // Remove the calf nationalID
            //    // Taking this out for now
            //    //document.forms[0].HidCalfNationalID.value = document.getElementById("CalfEarTag").value;
            //    //removeOptions(document.getElementById("CalfEarTag"));
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
                if(searchFBBatchAfter(pType) == false) 
                {
                    return false;
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
            var pType = "EIDWeigh";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

            // creating a variable to store all the internal animal id's
            var animals = $('#EIDWeighTable td:nth-child(1)').map(function () {
                return $(this).text();
            }).get();

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
                //animalList = animalList + animals[k].value;
                animalList = animalList + animals[k].toString();
            }



            //var opts = document.forms[0].AnimalList;
            //var opts = document.forms[0].EIDWeighAnimalList;
	   
            //if (opts) {
            if(animalList){
				//document.forms[0].HidAnimalList.value = opts.value;
				//document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
                document.forms[0].HidAnimalList.value = animalList;
                //document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
				if (document.forms[0].HidAnimalList.value == "0") {
					App.alert("Please Select", "Please select or type a cow number");
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
			WriteFormValues("WeighPage.aspx?Type=AddWeigh&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

			if("<%=Master.HandsFree%>" != "") 
			{
				if ("<%=Master.IsMulti%>" == "true")
				{
					AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
					var  voiceRespM = AsyncAndroid.GetVoiceCommand();
					if (voiceRespM != "no")
					{
						if (pType == "EIDWeigh")
						{
							singleVR=false;
							setTimeout(function() { initPage(); }, 3000);
						}
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
				App.alert("Record Added", msg);
			}
			else  {
				App.message(msg); 
			}
			
            // deleting the rows from the table after the form has been submitted
            if (document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked == false)
            {
                var weighTable = document.getElementById("EIDWeighTable");
                var rowCount = weighTable.rows.length;
                // Delete any weights still sitting there
                for (var k = 1; k < rowCount; k++) {
                    weighTable.deleteRow(k);
                    rowCount--;
                    k--;
                }// for
            }// if

            //document.getElementById("form1").reset();

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

                            // setting animal selected
                            animalSelected = row.NationalID;

                            var skip = false;
                            if (row.Exception != '') {
                                alert(row.Exception);
                            }
                            if (row.WithdrawalDate != '') {
                                alertWithdrawal(row.WithdrawalDate);
                            }

                            if (row.ElectronicID != 0) {
                                if (eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID, row.ScoreHistory, row.WeightHistoryText) == false) {
                                    skip = true;
                                }
                            }
                            else {

                                if (bWeigherConnected == true) {
                                    App.requestWeight(sConnectedWeigher);
                                    //eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID, row.ScoreHistory, row.WeightHistoryText, weight)
                                }// if
                                else {
                                    App.textInput("Please enter", "Please enter weight:", "ScoreResults", animalSelected, true);
                                }// else

                                ////If there is no EID needs to be set all values to readOneTag function for call eidWeigh function
                                //lastWeighDate = row.LastWeightDate;
                                //lastWeight = row.LastWeight;
                                //nationalId = row.NationalID;
                                //scoreHistory = row.ScoreHistory;
                                //weighHistoryText = row.WeightHistoryText;
                                //document.forms[0].SelectedAnimalID.value = row.InternalAnimalID;

                                //manualSearch = true;
                                //App.message("Please Scan EID");
                                ////var confirmWrite= confirm("Please scan EID");
                                ////if(confirmWrite){
                                ////readBTTags(0);
                                //if (connectToDevice()) {
                                //    //TODO FIX.
                                //    App.message("Ready to scan tag...");
                                //    readOneTag(0);
                                //}
                                //// }
                                ////else{

                                ////}
                            }
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
		//function readTag(tag) 
		//{
		    //var herdID = sessionStorage.getItem('HerdID');
		    //var decimal = tag;
		    tagScanned = tag;

		    //var sql = "SELECT * FROM Cows where (ElectronicID = '" + decimal + "' AND InternalHerdID = " + herdID + ")";
            db.transaction(function(transaction){
                transaction.executeSql(sql, [],
                    function(transaction, results) 
                    {
                        //var listBox = document.getElementById("EIDAnimalList");
                        //var opt = document.createElement("option");
                                      
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) 
                        {
                            var row = results.rows.item(0);

                            // setting animal selected
                            animalSelected = row.NationalID;

                            var skip = false;
                            if (row.Exception != '') {
                                App.alert("Exception", row.Exception);
                            }
                            if (row.withdrawalDate != '') {
                                alertWithdrawal(row.WithdrawalDate);
                            }


                            if (bWeigherConnected == true)
                            {
                                App.requestWeight(sConnectedWeigher);
                                //eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID, row.ScoreHistory, row.WeightHistoryText, weight)
                            }// if
                            else
                            {
                                App.textInput("Please enter", "Please enter weight:", "ScoreResults", animalSelected, true);
                            }// else

                            //else
                            //{
                            //    //If Manual Search Make sure the user scan same tag again
                            //    if (!manualSearch) {
                            //        if (eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID, row.ScoreHistory, row.WeightHistoryText, 0) == false) {
                            //            skip = true;
                            //        }
                            //    }
                            //    else {
                            //        App.message(decimal + " Animal already in Database, scan again.");
                            //        readOneTag(0);
                            //        return;
                            //    }
                            //}// else
                        }
                        else 
                        {
                            App.message(decimal + "Animal not found");
                            ////if there is no EID from Manual search need to be update local DB 
                            //if (nationalId != undefined) {
                            //    db.transaction(function (transaction) {
                            //        var updateSQL = "UPDATE Cows SET ElectronicID = '" + decimal + "' where InternalAnimalID = " + document.forms[0].EIDAnimalList.value + "";
                            //        transaction.executeSql(updateSQL);
                            //    });
                            //    App.message("EID has been updated");

                            //    document.forms[0].SetEIDLabel.value = decimal;
                            //    document.forms[0].HidTitle.value = "EID set for " + nationalId;
                            //    WriteFormValues("iQuickAdd.aspx?Type=SetEID&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
                            //    App.message(decimal + " Setting EID for " + nationalId);

                            //    //Once we updated local DB to read weight of that animal.
                            //    //var weight = Android.ReadWeight();
                            //    //var weight = App.requestWeight(sConnectedWeigher);
                            //    //eidWeigh(lastWeighDate, lastWeight, nationalId, scoreHistory, weighHistoryText, weight);

                            //    stopReading == 1;
                            //    return;
                            //}
                            //else {
//                                App.message(decimal + "Animal not found")
                            //}
                        }                                     
                    },

                    function(transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
            });
                                           
            //if (manualSearch == false)
            //{
            //// Need longer timeout for weighing
            //setTimeout(function() { readOneTag(0); }, 8000);
                                    
            //App.message(tag);
            //stopReading = 1;
            //return;
		    //}
            App.message(tag);
            return;
        }


        function readGallagher(fullString)
        {
            var herdID = sessionStorage.getItem('HerdID');
            var GALLAGHER_WC810_LENGTH = 62;
            var startString = 0;
            var idString = 16;
            var weighStart = 33;
            var weighFinish = 39;
                     
              if (stopReading == 1) {
                  return;
              }
              if (("<%=Master.BTWeigherDeviceType%>" == "Gallagher_Panel_Reader")) {
                  if (fullString.Length < GALLAGHER_WC810_LENGTH) {
                      // alert
                      App.alert("Scan again", "Could you please Scan again?");
                  } else {
                      var decimalID = fullString.substring(startString, idString);
                      var decimalWeigh = fullString.substring(weighStart, weighFinish);
                      var sql = "SELECT * FROM Cows where (ElectronicID = '" + decimalID + "' AND InternalHerdID = " + HerdID + ")";
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
                                      if (eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID, row.ScoreHistory, row.WeightHistoryText, decimalWeigh) == false) {
                                          skip = true;
                                      }
                                      if (skip == false) {
                                          listBox.options.add(opt, 0);
                                          opt.text = decimalWeigh;
                                          opt.value = row.InternalAnimalID;
                                          setSelectedIndex(listBox, opt.value);
                                          var counter = document.getElementById("Count");
                                          counter.value = listBox.length;
                                          addToList(decimalWeigh, null);
                                          if ((document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked))
                                          {
                                              addEIDWeight();
                                          }
                                      }
                                  } else {
                                      
                                      App.message(decimal + " Animal not found");
                                  }
                              },
                              function(transaction, error) {
                                  App.alert("Error", "Could not read: " + error.message);
                              });
                      });
                  }
              }
        }


        function initPage() 
        {
            if (document.getElementById("FullNumberList")) {
                var test = document.getElementById("FullNumberList");
                //$(test).hide();
                $(".FullNumberList").hide();
            }

            var isEID = "<%=Master.IsEID%>";
            db = OpenDatabase();
            if (!db) {
                App.alert("Database", "Cannot open database");
                return;
            }
            if(document.getElementById('FullNumberList'))
            {   document.getElementById('FullNumberList').style.display = 'none';
                hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                document.getElementById('FullNumberList').options.length = 0;
            }

            // trying to connect to reader
            if (!bReaderConnected)
            {
	            var deviceList = "<%=Master.BTReaderDeviceName%>";
	            deviceList = deviceList.split(",");
	            for(var i = 0;i<deviceList.length;i++)
	            {
		            App.connectBTDevice(deviceList[i], "<%=Master.BTDeviceReader%>", "<%=Master.BTReaderDeviceType%>");
	            }// for
            }// if

            // trying to connect to the weigher
            if ("<%=Master.BTWeigherDeviceName%>" != "") 
            {
	            var deviceList = "<%=Master.BTWeigherDeviceName%>"; 
	            deviceList = deviceList.split(",");
	            for(var i = 0;i<deviceList.length;i++) 
	            {
		            App.connectBTDevice(deviceList[i], "<%=Master.BTDeviceWeigher%>", "<%=Master.BTWeigherDeviceType%>");  
	            }// for
            }// if


            btRetries = 0;
            isCommitted = 0;
            // Widen the data entry box if its a wide screen
            if (isEID == 0) {
                var theTextBox = document.getElementById("filterInput");
                //   theTextBox.style["width"] = "220px";
            } 
           
            SetDates("EIDWeigh");

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


            if (isEID == 1) 
            {           
                //document.getElementById('selectedAnimalsTable').style.display = 'block';
                document.getElementById('weightAnimalsTable').style.display = 'block';
                

                if (document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }                    
            }

         
            //document.getElementById("selectedAnimalsTable").style.display="none";
            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Weigh");
            //
        }



        function addEIDWeight()
        {
            var isEID = "<%=Master.IsEID%>";
            //(isEID == 1)
            //{
                //var selectedAnimals = document.getElementById("EIDAnimalList").options;
                var animalList = "";

                // creating a variable to store all the EID's 
                var colArray = $('#EIDWeighTable td:nth-child(2)').map(function () {
                    return $(this).text();
                }).get();

                var selectedAnimals = colArray;

                if (selectedAnimals.length == 0) {
                    App.alert("Error", "No Tags scanned");
                    return;
                }

                var weighTable = document.getElementById("EIDWeighTable");

                // Note in this case weight is also recorded in selected animals

                for (var i = 0; i < selectedAnimals.length; i++) {
                    if (i > 0) {
                        animalList = animalList + ":";
                    }

                    //animalList = animalList + selectedAnimals[i].text; // EID is in here
                    animalList = animalList + selectedAnimals[i].toString();

                    // Check if animal was selected for movement
                    var row = weighTable.rows[i + 1];
                    var weight = row.cells[3].childNodes[0].value;
                    var score = "";
                    if (row.cells[7]) {
                        score = row.cells[7].childNodes[0].value;
                    }
                    var move = 0;
                    var chkbox = row.cells[6].childNodes[0];
                    if (null != chkbox && true == chkbox.checked) {
                        move = 1;
                    }
                    animalList = animalList + "," + weight + "," + score + "," + move;
                }

<%--                if (document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked == false) {

                    var rowCount = weighTable.rows.length;
                    // Delete any weights still sitting there
                    for (var k = 1; k < rowCount; k++) {
                        weighTable.deleteRow(k);
                        rowCount--;
                        k--;
                    }
                }--%>

                document.forms[0].EIDWeighAnimalList.value = animalList;
            //}
            // Only clear this if not EID
            
            if (isEID != 1)
            {
                //selectedAnimals.options.length = 0;
                //var counter = document.getElementById("Count");
                //counter.value = 0;
            }
               
              checkInput();
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
            if (extraFilter)
            {
                sql += extraFilter;
            }
        
            if (db)
            {
                db.transaction(function (transaction)
                {
                    transaction.executeSql(sql, [],
                        function (transaction, results)
                        {
                            // results.rows holds the rows returned by the query
                            if (results.rows.length > 1)
                            {
                                App.alert("Records Found", results.rows.length + " animals found please select one from list");
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
                                //select.style.display = 'block';
                                showSelect(select); // showing the new select
                                document.getElementById('ManTag').value = '';
                            }
<%--                        else if (results.rows.length == 1)
                            {
                            var row = results.rows.item(0);
                            var skip = false;
                            document.getElementById('FullNumberList').style.display = 'none';
                            document.getElementById('FullNumberList').options.length = 0;
                            if(row.Exception!='')
                            {
                                App.alert("Exception",row.Exception);
                            }
                            if(row.WithdrawalDate!='')
                            {
                                alertWithdrawal(row.WithdrawalDate);
                            }

                            //if (eventType == "EIDWeigh")
                            //{                    
                                if (row.ElectronicID != 0)
                                {
                                    if (eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID,row.ScoreHistory,row.WeightHistoryText) == false) {
                                        skip = true;
                                    }
                                }
                                else
                                {
                                    //If there is no EID needs to be set all values to readOneTag function for call eidWeigh function
                                    lastWeighDate=row.LastWeightDate;
                                    lastWeight=row.LastWeight;
                                    nationalId=row.NationalID;
                                    scoreHistory=row.ScoreHistory;
                                    weighHistoryText=row.WeightHistoryText;
                                    document.forms[0].SelectedAnimalID.value = row.InternalAnimalID;

                                    manualSearch = true;
                                    App.message("Please Scan EID");
                                    //var confirmWrite= confirm("Please scan EID");
                                    //if(confirmWrite){
                                    //readBTTags(0);
                                    //if (connectToDevice())
                                    //{
                                    //    App.message("Ready to scan tag...");
                                    //    readOneTag(0);
                                    //}
                                }
                            //}
                            if (skip == false)
                            {
                                //if(document.getElementById("EIDAnimalList"))
                                {
                                    //var listBox = document.getElementById("EIDAnimalList");
                                    //var opt = document.createElement("option");
                                    listBox.options.add(opt, 0);
                                    opt.text = row.NationalID;
                                    opt.value = row.InternalAnimalID;
                                    var counter = document.getElementById("Count");
                                    counter.value = listBox.length;
                                    addToList(row.NationalID, null);
                                    //if (eventType == "EIDWeigh")
                                   // {
                                        if((document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked) ) {
                                            addEIDWeight();
                                        }
                                    //}
                                }
                            }
                            }--%>
                            else
                            {
                                App.alert("Records", "No records found");
                            }
                        },
                 function (transaction, error)
                 {
                     App.alert("Error", "Could not read: " + error.message);
                 });
                });
            }
            else
            {
                App.alert("Database", 'Cant open database');
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
            if (extraFilter)
            {
                sql += extraFilter;
            }
        
            if (db)
            {
                db.transaction(function (transaction)
                {
                    transaction.executeSql(sql, [],
                        function (transaction, results)
                        {
                            // results.rows holds the rows returned by the query
                            if (results.rows.length == 1)
                            {
                            var row = results.rows.item(0);
                            var skip = false;
                            document.getElementById('FullNumberList').style.display = 'none';
                            hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                            document.getElementById('FullNumberList').options.length = 0;
                            if(row.Exception!='')
                            {
                                App.alert("Exception",row.Exception);
                            }
                            if(row.WithdrawalDate!='')
                            {
                                alertWithdrawal(row.WithdrawalDate);
                            }

                            //if (eventType == "EIDWeigh")
                            //{                    
                                if (row.ElectronicID != 0)
                                {
                                    if (eidWeigh(row.LastWeightDate, row.LastWeight, row.NationalID,row.ScoreHistory,row.WeightHistoryText) == false) {
                                        skip = true;
                                    }
                                }
                                else
                                {
                                    //If there is no EID needs to be set all values to readOneTag function for call eidWeigh function
                                    lastWeighDate=row.LastWeightDate;
                                    lastWeight=row.LastWeight;
                                    nationalId=row.NationalID;
                                    scoreHistory=row.ScoreHistory;
                                    weighHistoryText=row.WeightHistoryText;
                                    document.forms[0].SelectedAnimalID.value = row.InternalAnimalID;

                                    manualSearch = true;
                                    App.message("Please Scan EID");
                                    //var confirmWrite= confirm("Please scan EID");
                                    //if(confirmWrite){
                                    //readBTTags(0);
                                    //if (connectToDevice())
                                    //{
                                    //    App.message("Ready to scan tag...");
                                    //    readOneTag(0);
                                    //}
                                }
                            //}
                            if (skip == false)
                            {
                                <%--if(document.getElementById("EIDAnimalList"))
                                {
                                    //var listBox = document.getElementById("EIDAnimalList");
                                    //var opt = document.createElement("option");
                                    listBox.options.add(opt, 0);
                                    opt.text = row.NationalID;
                                    opt.value = row.InternalAnimalID;
                                    var counter = document.getElementById("Count");
                                    counter.value = listBox.length;
                                    addToList(row.NationalID, null);
                                    //if (eventType == "EIDWeigh")
                                   // {
                                        if((document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked) ) {
                                            addEIDWeight();
                                        }
                                    //}
                                }--%>
                                addToList(row.NationalID, null);                         
                                if((document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked) ) {
                                    addEIDWeight();
                                }
                                    
                            }
                            }
                            else
                            {
                                App.alert("Records", "No records found");
                            }
                        },
                    function (transaction, error)
                    {
                        App.alert("Error", "Could not read: " + error.message);
                    });
                });

            }
            else
            {
                App.alert("Database", 'Cant open database');
            }   
        }




        function seachOnAnimalID(animalID) {
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
                          App.alert("Error", "Could not read: " + error.message);
                      });
            });
            return true;
        }


        function searchFBFind()
        {
            var filterInput = document.getElementById("filterInput").value;
            if (!filterInput) {
                App.alert("Enter Cow Number", "Please enter 1 or more cow numbers seperated by a comma");
                return false;
            }
            if (searchFB(filterInput, false) == false) {
                return false;
            }
        }


        function searchFB(filterInput, postEntry)
        {
           var herdID=sessionStorage.getItem('HerdID')
        // Search database Datastore
        var sql = "SELECT * FROM Cows where (FreezeBrand = '" + filterInput + "' AND InternalHerdID = " + HerdID + ")";
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

                        setSelectedIndex(document.getElementById("AnimalList"), row.InternalAnimalID);
                        if (postEntry == false) {
                            return false;
                        }
                        else
                        {
                            // Write the form to the offline cache
                            //if (processForm() == false) {
                            //    return false;
                            //}
                            if (processForm() == false) {
                                return false;
                            }
<%--                            WriteFormValues("WeighPage.aspx?Type=AddWeigh&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
                            if("<%=Master.IsEID%>" == "1")  {
                                App.message("Weigh has been recorded and will be transferred at next synchronisation");
                            }
                            else {
                                App.alert("Record Added", "Weigh has been recorded and will be transferred at next synchronisation");
                            }
                            isCommitted = 1;
                            var aniTable = document.getElementById("AnimalListTable");
                            aniTable.parentNode.removeChild(aniTable);

                            //$('#EIDAnimalList').empty();
                            document.getElementById("form1").reset();--%>
                        }
                    }
                    else if (results.rows.length > 1) {
                        App.alert("Record Found", "More than one matching cow found " + results.rows.length);
                        return false;
                    }
                    else
                    {
                        return (searchTag(filterInput));                       
                    }
                },
                  function (transaction, error) {
                      App.alert("Error", "Could not read: " + error.message);
                  });
        });
        return true;
                }


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
                    App.alert("Cow Number", "All cow numbers must be less than 10 characters:" + input_array[i]);
                    return false;
                }
                else {
                    if (searchFB(input_array[i], true) == false) {
                        return false;
                    }
                }
            }
            document.getElementById("filterInput").value = "";
            return true;
        }


        function searchTag(filterInput) {
            var sql = "SELECT * FROM Cows where NationalID like '%" + filterInput + "%' and InternalHerdID = '" + HerdID + "'";
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
                            setSelectedIndex(document.getElementById("AnimalList"), row.InternalAnimalID);
                        }
                        else if (results.rows.length > 1) {
                            App.alert("Record Found", "More than one matching cow found, try a more exact tag " + results.rows.length);
                            return false;
                        }
                        else {
                            App.alert("Records Not Found", "No matching cows for " + filterInput);
                            return false;
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
            });
            return true;
        }


        function eidWeigh(pLastWeightDate, pLastWeight, pNationalID, pScoreHistory, pWeightHistory, decimalWeigh, pnfcscan)
        {
            var decimalWeigh = decimalWeigh || 0;
            var nfcScan = pnfcscan || false;
            //
            var tableID = "EIDWeighTable";
            var table1 = document.getElementById(tableID);
            if (table1 == null) {
                createTable();
            }
            //
            var table = document.getElementById('EIDWeighTable');
            var existRow = false;
            var tbody = table.getElementsByTagName("tbody")[0];
            var rowCount = tbody.rows.length;
            //var rowCount = table.rows.length;
              
            // Delete any weights still sitting there
            for (var k = 0; k < rowCount; k++)
            {
                //var row = table.rows[k];
                var row = tbody.rows[k];
                var cells = row.getElementsByTagName("td");
                if (cells[2].innerText == pNationalID)
                {
                    existRow=true;
                }
            }            


            var weight = "";
            var resp = "";
            if (decimalWeigh != 0)
            {
                weight = decimalWeigh;
            }
            else
            {
                // Need to clear table if we are in autoaddmode
                // trying to connect to weigher
                if ("<%=Master.BTWeigherDeviceName%>" != "") 
                {
	                var deviceList = "<%=Master.BTWeigherDeviceName%>"; 
	                deviceList = deviceList.split(",");
	                for(var i = 0;i<deviceList.length;i++) 
	                {
		                App.connectBTDevice(deviceList[i], "<%=Master.BTDeviceWeigher%>", "<%=Master.BTWeigherDeviceType%>");  
	                }// for
                }// if

                var vMsgweigh = "Please say weight of animal";
                var voiceweigh = "";
                if ((resp == "") || (resp.indexOf("ERROR") >= 0))
                {
                    if ("<%=Master.HandsFree%>" != "")
                    {
                        for (var i = 0; i < 5; i++)
                        {
                            AsyncAndroid.ConvertTextToVoicePromptResponse(vMsgweigh);
                            voiceweigh = AsyncAndroid.GetVoiceCommand();
                            if (voiceweigh == "<No Response>")
                            {
                                continue;
                            }
                            else
                            {
                                break;
                            }
                        }

                        AsyncAndroid.ConvertTextToVoice(voiceweigh);
                        var voicemsg = "I think you said" + voiceweigh + "Say Yes or No";
                        AsyncAndroid.ConvertTextToVoicePromptResponse(voicemsg);
                        var response = AsyncAndroid.GetVoiceCommand();
                        if (response != "no")
                            weight = voiceweigh;
                        if (response == "no")
                            //weight = window.prompt("Please enter weight:", "");
                            weight = App.textInput("Please enter", "Please enter weight:", "ScoreResults", pNationalID, true);
                        //if (isNaN(weight))
                        //{
                        //    weight = window.prompt("Please enter", "Please enter weight (must be numeric):", "");
                        //}
                    }
                    else
                    {                           
                        if (!existRow)
                        {
                            if (bWeigherConnected == true) {
                                App.requestWeight(sConnectedWeigher);
                            }
                            else {
                                //weight = window.prompt("Please enter weight:", "");
                                App.textInput("Please enter", "Please enter weight:", "ScoreResults", pNationalID, true);
                            }
                            //if (isNaN(weight)) {
                            //    weight = window.prompt("Please enter weight (must be numeric):", "");
                            //}
                        }
                    }

                }
                else
                {
<%--                             if ("<%=Master.BTWeigherDeviceType%>" == "Gallagher_SS")
                    {                        
                        <%--alert(<%=this.BTWeigherDeviceType%>);--%>
                        <%--weight = App.ReadWeight(<%=Master.BTWeigherDeviceType%>);// Android.ReadGallagherWeight();
                    }
                    else
                    {--%>
                    //weight = App.ReadWeight();
                    if (bWeigherConnected == true) {
                        App.requestWeight(sConnectedWeigher);
                    }
                    //}
                }
            }

<%--              if (document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked) {
                  // Hide the save button
                  document.getElementById("SaveWeightButton").style.display = 'none';
                  var rowCount = table.rows.length;
                  // Delete any weights still sitting there
                  for (var k = 1; k < rowCount; k++) {
                      table.deleteRow(k);
                      rowCount--;
                      k--;
                  }
              } else {
                  document.getElementById("SaveWeightButton").style.display = 'block';
              }
              if (!weight) {
                  return false;
              }

              
                     //setTimeout(function () { App.shortVibrate(); }, 200);
              
              weight = Math.round(weight * Math.pow(10, 1)) / Math.pow(10, 1);
              var dlwg = 0;
              
              
              if (pLastWeightDate != "") {
                  var lastWeighedOn = new Date(pLastWeightDate.substring(6),
                    pLastWeightDate.substring(3, 5) - 1, pLastWeightDate.substring(0, 2));
                  var today = new Date();
                  var days = (today.getTime() - lastWeighedOn.getTime()) / 86400000;
                  if (days > 0) {
                      dlwg = (weight - pLastWeight) / days;
                  }
                  dlwg = Math.round(dlwg * Math.pow(10, 2)) / Math.pow(10, 2);
              }
              if(!existRow){
                  var rowCount = table.rows.length;
                  var row = table.insertRow(1);

                  var cell1 = row.insertCell(0);
                  cell1.appendChild(document.createTextNode(pNationalID));

                  var cell2 = row.insertCell(1);
                  var element9 = document.createElement("input");
                  element9.type = "number";
                  element9.value = weight;
                  element9.style.width = '40px';
                  cell2.appendChild(element9);

                  var cell4 = row.insertCell(2);
                  cell4.appendChild(document.createTextNode(dlwg));


                  var cell3 = row.insertCell(3);
                  cell3.appendChild(document.createTextNode(pWeightHistory));

              
                  var cell6 = row.insertCell(4);
                  var element8 = document.createElement("input");
                  element8.type = "checkbox";
                  var vMsg = "Todays weight is " + weight + ". Daily live weight gain is " + dlwg;
                   
              }
              if("<%=Master.HandsFree%>" != "") {
                  if("<%=Master.VoiceMarkMove%>" != "") {
                      while(true) {
                          AsyncAndroid.ConvertTextToVoicePromptResponse(vMsg + ". Say MOVE, to mark animal for move or No to continue");
                          var voiceRespM = AsyncAndroid.GetVoiceCommand();
                          if(voiceRespM == "no") {
                              break;
                          }else if(voiceRespM == "move") {
                              element8.checked = true;
                              break;
                          }
                      }
                  }
                  else {
                      AsyncAndroid.ConvertTextToVoice(vMsg);
                  }
              }
              else {
                  AsyncAndroid.ConvertTextToVoice(vMsg); // Call out the voice weight if possible
              }
              cell6.appendChild(element8);--%>

              
<%--              if ((document.getElementById("<%=ConditionScoreCheckBox.ClientID%>").checked) || ("<%=Master.VoiceConditionScore%>" != ""))
              {
                  var score;
                  if("<%=Master.HandsFree%>" != "") {		                  
                      if("<%=Master.HandsFree%>" != "") {
                          AsyncAndroid.ConvertTextToVoicePromptResponse(vMsg + ". Say score, or say No to continue");
                          var scoreMsg = "";
                          var voiceResp = AsyncAndroid.GetVoiceCommand();		                     
                          if(VoiceMarkMove ==  "") {
                              if(voiceResp != "no") {		                          
                                  scoreMsg = vMsg; // No need to call out weight again if we already have called it out for mark move
                                  score = voiceResp;		                      
                              }
                              while(true) {
                                  AsyncAndroid.ConvertTextToVoicePromptResponse(scoreMsg + ". Say numeric score 0,1,2 or 3, or say No to continue");
                                  var voiceResp = AsyncAndroid.GetVoiceCommand();
                                  if(voiceResp != "no") {
                                      score = voiceResp;
                                  }
                                  else {
                                      break;
                                  }
                                  if (isNaN(score)) {
                                      continue;
                                  }
                                  else {
                                      break;
                                  }
                              }		                      }
                      }		                  }
                  else {
                      score = window.prompt("Please enter condition score, previously: " + pScoreHistory, "");
                      if (isNaN(score)) {
                          score = window.prompt("Please enter condition score (must be numeric):", "");
                      }
                  }
                  var cell7 = row.insertCell(5);
                  var element10 = document.createElement("input");
                  element10.type = "number";
                  element10.value = score;
                  element10.style.width = '40px';
                  cell7.appendChild(element10);
              }--%>
                     if((nfcScan)&&("<%=Master.HandsFree%>" != "")){
                     setTimeout(function() { addEIDWeight(); }, 5000);
                 }
              return true;

        }



        // checking the value of the manually entered weight
        function ScoreResults(pId, pValue) {
            if (pValue == false) {
                return;
            }
            else {
                var value = pValue;
                if (isNaN(value) || value == 0) {
                    App.textInput("Please enter", "Please enter weight (must be numeric):", "ScoreResults", pId, true)
                }
                else {
                    readWeight(value);
                }// else
            }// else
        }// ScoreResults



        function weightCheckOption(pId, pValue)
        {
            if (pValue == false) {
                return;
            }
            else
            {
                App.requestWeight(sConnectedReader);
            }
        }// weightCheckOption



        function readWeight(pWeight)
        {
            // checking the weight value
            var weight = parseInt(pWeight);
            if (weight == 0 || isNaN(weight) ) {
                App.confirm("Prompt", "Ready to read weight?", "weightCheckOption", sConnectedWeigher);
                //App.alert("Error", "Weight must be greater than 0");
                //return;
            }

            var existRow = false;
            //var weight = pWeight;
            var nationalID = animalSelected;
            var lastWeighedDate = "";
            var lastWeight = "";
            var weightHistory = "";
            var scoreHistory = "";
            var EID = "";
            var InternalID = "";
            
            var tableID = "EIDWeighTable";
            var table1 = document.getElementById(tableID);
            if (table1 == null) {
                createTable();
            }          

            var herdID = sessionStorage.getItem('HerdID');
            //var sql = "SELECT * FROM Cows where (ElectronicID = '" + tagScanned + "' AND InternalHerdID = " + herdID + ")";
            var sql = "SELECT * FROM Cows where (NationalID = '" + animalSelected + "' AND InternalHerdID = " + herdID + ")";
            db.transaction(function (transaction)
            {
                transaction.executeSql(sql, [],
                    function (transaction, results)
                    {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1)
                        {
                            var row = results.rows.item(0);
                            //setting the table variables to == the current row value for the selected animal.
                            nationalID = row.NationalID,
                            lastWeighedDate = row.LastWeightDate;
                            lastWeight = row.LastWeight;
                            weightHistory = row.WeightHistoryText;
                            scoreHistory = row.ScoreHistory;
                            EID = row.ElectronicID;
                            InternalID = row.InternalAnimalID;
                            //
                                
                            var skip = false;
                            if (row.Exception != '') {
                                App.alert("Exception", row.Exception);
                            }
                            if (row.withdrawalDate != '') {
                                alertWithdrawal(row.WithdrawalDate);
                            }
                        }// rowLength

                   
                        if (!weight)
                        {
                            return false;
                        }

              
                        weight = Math.round(weight * Math.pow(10, 1)) / Math.pow(10, 1);
                        var dlwg = 0;
                 
                        if (lastWeighedDate != "") {
                            var lastWeighedOn = new Date(lastWeighedDate.substring(6),
                            lastWeighedDate.substring(3, 5) - 1, lastWeighedDate.substring(0, 2));
                            var today = new Date();
                            var days = (today.getTime() - lastWeighedOn.getTime()) / 86400000;
                            if (days > 0) {
                                dlwg = (weight - lastWeight) / days;
                            }
                            dlwg = Math.round(dlwg * Math.pow(10, 2)) / Math.pow(10, 2);
                        }

                        var tableID = "EIDWeighTable";
                        var table = document.getElementById(tableID);
                        var tbody = table.getElementsByTagName("tbody")[0];
                        var rowCount = tbody.rows.length;

                        // checking if there is any rows in the table
                        if (rowCount > 0) {
                            for (var k = 0; k < rowCount; k++) {
                                var row = tbody.rows[k];
                                var cells = row.getElementsByTagName("td");
                                // checking if the selected animal is already in the table
                                if (cells[2].innerText == nationalID) {
                                    // updating the selected animals table values
                                    cells[3].firstChild.value = weight;
                                    existRow = true;
                                }
                            }
                        }

                        if (!existRow)
                        {
                            var table = document.getElementById(tableID);
                            if (table != null)
                            {
                                var tbody = table.getElementsByTagName("tbody")[0];

                                //count the rows
                                var rowCount = tbody.rows.length;
                                //count the columns
                                var colCount = table.rows[0].cells.length;                 
                                var row = tbody.insertRow(-1);

                                var InternalIDHidCell = row.insertCell(0);
                                //cell1.align = "center";
                                InternalIDHidCell.style.padding = "5px";
                                InternalIDHidCell.style.margin = "5px";
                                InternalIDHidCell.appendChild(document.createTextNode(InternalID));

                                var EIDHidCell = row.insertCell(1);
                                EIDHidCell.style.padding = "5px";
                                EIDHidCell.style.margin = "5px";
                                EIDHidCell.appendChild(document.createTextNode(EID));
                               
                                // hiding the EID and InternalID columns
                                hideTableCols();

                                var cell1 = row.insertCell(2);
                                cell1.appendChild(document.createTextNode(nationalID));

                                var cell2 = row.insertCell(3);
                                var element9 = document.createElement("input");
                                element9.type = "number";
                                element9.value = weight;
                                element9.style.width = '60px';
                                element9.style.paddingTop = "20px";
                                element9.align = "center";
                                cell2.appendChild(element9);

                                var cell3 = row.insertCell(4);
                                cell3.align = "center";
                                cell3.appendChild(document.createTextNode(dlwg));

                                var cell4 = row.insertCell(5);
                                cell4.align = "center";
                                cell4.appendChild(document.createTextNode(weightHistory));
              
                                var cell5 = row.insertCell(6);
                                var element8 = document.createElement("input");
                                element8.id = "myCheckbox" + InternalID;
                                element8.type = "checkbox";
                                element8.style.textAlign = "center";
                                //
                                var label = document.createElement("label");
                                label.setAttribute("for", element8.id);
                                //
                                cell5.appendChild(element8);
                                cell5.appendChild(label);

                                var cell6 = row.insertCell(7);
                                var element10 = document.createElement("input");
                                element10.type = "number";
                                element10.style.width = '60px';
                                cell6.align = "center";
                                cell6.appendChild(element10);

                                // calling to check whether to show or hide the score field
                                conditionScoreCheckbox();

                                var cell7 = row.insertCell(8);                 
                                cell7.style.padding = "5px";
                                cell7.style.margin = "5px";
                                cell7.align = "center";
                                var deletebtn = document.createElement("button");
                                deletebtn.className = "btn btn-danger btn-xs";
                                deletebtn.appendChild(document.createTextNode("delete"));
                                deletebtn.onclick = function () {
                                    deleteWeightFromList(nationalID, true);
                                    return false;
                                };
                                cell7.appendChild(deletebtn);
                                var vMsg = "Todays weight is " + weight + ". Daily live weight gain is " + dlwg;
                                App.textToSpeech(vMsg, false, "", "");

                            }// table
                        }// existRow


                        if (document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked)
                        {
                              // Hide the save button
                              document.getElementById("SaveWeightButton").style.display = 'none';
                              //var rowCount = table.rows.length;
                              //// Delete any weights still sitting there
                              //for (var k = 1; k < rowCount; k++) {
                              //    //todo: save all rows then delete
                              //    //table.deleteRow(k);
                              //    rowCount--;
                              //    k--;
                              //}
                        }
                        else {
                              document.getElementById("SaveWeightButton").style.display = 'block';
                        }// else


                        if ((document.getElementById("<%=ConditionScoreCheckBox.ClientID%>").checked) || ("<%=Master.VoiceConditionScore%>" != ""))
                        {
                                    var score;
                                    if ("<%=Master.HandsFree%>" != "")
                                    {
                                        if("<%=Master.HandsFree%>" != "") {
                                            AsyncAndroid.ConvertTextToVoicePromptResponse(vMsg + ". Say score, or say No to continue");
                                            var scoreMsg = "";
                                            var voiceResp = AsyncAndroid.GetVoiceCommand();		                     
                                            if(VoiceMarkMove ==  "") {
                                                if(voiceResp != "no") {		                          
                                                    scoreMsg = vMsg; // No need to call out weight again if we already have called it out for mark move
                                                    score = voiceResp;		                      
                                                }
                                                while(true) {
                                                    AsyncAndroid.ConvertTextToVoicePromptResponse(scoreMsg + ". Say numeric score 0,1,2 or 3, or say No to continue");
                                                    var voiceResp = AsyncAndroid.GetVoiceCommand();
                                                    if(voiceResp != "no") {
                                                        score = voiceResp;
                                                    }
                                                    else {
                                                        break;
                                                    }
                                                    if (isNaN(score)) {
                                                        continue;
                                                    }
                                                    else {
                                                        break;
                                                    }
                                                }		                      }
                                        }

                                        var tableID = "EIDWeighTable";
                                        var table = document.getElementById(tableID);
                                        var tbody = table.getElementsByTagName("tbody")[0];
                                        var rowCount = tbody.rows.length;

                                        if (rowCount > 0) {
                                            for (var k = 0; k < rowCount; k++) {
                                                var row = tbody.rows[k];
                                                var cells = row.getElementsByTagName("td");
                                                if (cells[2].innerText == animalSelected) {
                                                    cells[7].firstChild.value = score;
                                                }// if
                                            }
                                        }

                                    }
                                    else
                                    {
                                        App.textInput("Please enter", "Please enter condition score, previously: " + scoreHistory, "ConditionScoreResult", nationalID, true);
                                        //score = window.prompt("Please enter condition score, previously: " + scoreHistory, "");
                                        //if (isNaN(score)) {
                                        //    score = window.prompt("Please enter condition score (must be numeric):", "");
                                        //}
                                    }
                        }

                        if ((document.getElementById("<%=AutoAddWeightCheckBox.ClientID%>").checked))
                        {
                            addEIDWeight();
                        }// if

                    },

                    function (transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
            });


            //else update 
                 
        }// readWeight


        // checking the inputted condition score value 
        function ConditionScoreResult(pId, pValue) {
            var nationalID = pId;
            if (pValue == false)
            {
                //App.textInput("Please enter", "Please enter condition score (must be numeric):", "ConditionScoreResult", pId, true)
            }
            else {
                var value = pValue;
                if (isNaN(value)) {
                    App.textInput("Please enter", "Please enter condition score (must be numeric):", "ConditionScoreResult", pId, true)
                }
                else {
                    //count the columns
                    //var colCount = table.rows[0].cells.length;
                    //var row = tbody.rows(-1);

                    //var cell7 = row.insertCell(5);
                    //var element10 = document.createElement("input");
                    //element10.type = "number";
                    //element10.value = score;
                    //element10.style.width = '40px';
                    //cell7.appendChild(element10);

                    /////
                    var tableID = "EIDWeighTable";
                    var table = document.getElementById(tableID);
                    var tbody = table.getElementsByTagName("tbody")[0];
                    var rowCount = tbody.rows.length;

                    if (rowCount > 0)
                    {
                        for (var k = 0; k < rowCount; k++) {
                            var row = tbody.rows[k];
                            var cells = row.getElementsByTagName("td");
                            if (cells[2].innerText == nationalID)
                            {
                                cells[7].firstChild.value = value;
                            }// if
                        }
                    }
                    /////


                }// else
            }// else
        }// ScoreResults


        // creating the weight records table
        function createTable()
        {
            var tableID = "EIDWeighTable";
            var table = document.createElement('table');
            table.id = tableID;
            table.style.padding = "4px";
            table.style.margin = "4px";

            ////////////////////////////////////////
            var header = table.createTHead();
            var row = header.insertRow(0);
            var cell = document.createElement('th');
            cell.innerHTML = "InternalID";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            row.appendChild(cell);

            var header = table.createTHead();
            //var row = header.insertRow(0);
            //var cell = document.createElement('th');
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "EID";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);
            ////////////////////////////////////////

            //create header for Animal
            var header = table.createTHead();
            //var row = header.insertRow(0);
            //var cell = document.createElement('th');
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Animal";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            //var row = header.insertRow(0);
            //var cell = document.createElement('th');
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Kg";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "DLWG";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Last";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Move";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Score";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            ////create header for Animal
            //var header = table.createTHead();
            //var tr = table.tHead.children[0];
            //var cell = document.createElement('th');
            //cell.innerHTML = "Delete";
            //cell.style.padding = "5px";
            //cell.style.margin = "5px";
            //tr.appendChild(cell);


            var newtbody = document.createElement('tbody');
            table.appendChild(newtbody);


            //add the table to the DOM
            document.getElementById('weightAnimalsTable').appendChild(table);

            // calling this to check whether the score column should be shown or not
            conditionScoreCheckbox();
            // hiding the EID and InternalID columns
            hideTableCols();
            ////////////////////////////////////////
        }


        function deleteWeightFromList(pNationalID,showconfirm) {
            var check = false;
            if (showconfirm)
                check = confirm("Are you sure you want to remove this animal?");
                //check =  App.confirm("Record", "Are you sure you want to remove this animal?", confirmRecord, pType);
            else
                check = true;

            if (check == true)
            {
                var table = document.getElementById('EIDWeighTable');
                var tbody = table.getElementsByTagName("tbody")[0];

                for (var k = 0; k < tbody.rows.length; k++) {
                    var row = tbody.rows[k];
                    var cells = row.getElementsByTagName("td");
                    if (pNationalID != null) {
                        if (cells[2].innerText == pNationalID) {
                            tbody.removeChild(row);
                        }
                    }
                }
            }
            return false;
        }


        function hideMarkForMove() {
            //var v = $('#number').val() || 0;
            var v = 5;
            $('#EIDWeighTable tr > *:nth-child(' + v + ')').toggle();
        }

        // checking if the checkbox is checked or not
        function conditionScoreCheckbox()
        {
            var v = 6;
            var index = $('th').filter(
                function ()
                {
                    return $(this).text() == 'Score';
                }).index();
            index += 1;

            if(document.getElementById("<%=ConditionScoreCheckBox.ClientID%>").checked) {
                $('#EIDWeighTable tr > *:nth-child(' + index + ')').show();
            }
            else if(document.getElementById("<%=ConditionScoreCheckBox.ClientID%>").checked == false) {
                $('#EIDWeighTable tr > *:nth-child(' + index + ')').hide();
            }
        }


        function hideTableCols()
        {
            // hiding the InternalID col
            var index = $('th').filter(
            function () {
                return $(this).text() == 'InternalID';
            }).index();
            index += 1;
            $('#EIDWeighTable tr > *:nth-child(' + index + ')').hide();

            // hiding the EID col
            var index = $('th').filter(
            function () {
                return $(this).text() == 'EID';
            }).index();
            index += 1;
            $('#EIDWeighTable tr > *:nth-child(' + index + ')').hide();

        }



        function processForm() {
            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("No selection", "No cow selected");
                    return false;
                }
            }
            if (ValidateDate() == false)
                return false;
            document.forms[0].IsSubmitted.value = true;
            return true;
        }


        function setHidTitle() {
            var pEventType = 'EIDWeigh';
            var title = "";
            if (document.getElementById("Eidinputdate")) {
                title += document.getElementById("Eidinputdate").value;
            }
            else {
                title += document.getElementById("inputdate").value;
            }
            //document.forms[0].DoneDay.value + "/" +document.forms[0].DoneMonth.value  + "-";

            var opts = document.forms[0].EIDWeighAnimalList;
            var res = opts.value.split(",");
            var cow = res[0].toString();
            //var cow = opts.options[opts.selectedIndex].text;
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
