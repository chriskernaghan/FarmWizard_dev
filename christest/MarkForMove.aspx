<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="MarkForMove.aspx.cs" Inherits="HybridAppWeb.MarkForMove" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="row">
            <div class="form-group col-xs-12">
                <strong>
                    <asp:Label ID="Label1124" runat="server" Font-Bold="True">Group :</asp:Label></strong>
                <n0:MOBILEDROPDOWNLIST class="form-control" id="EventGroup" runat="server" DataValueField="ID" DataTextField="Name" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-xs-12">
                <div align="center">
                    <br />
                    <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Event</a>
                </div>
            </div>
        </div>
    </div>

    <script type = "text/javascript">
 ///<reference path="/Script/jquery-ui.min.js" />
        ///<reference path="/Script/HybridApp.js" />

        var db;

        function checkInput()
        {
            var pType = "MarkForMove";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;
           
            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this

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




            //if (isEID == 1) {
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
            //    document.forms[0].HidTitle.value = "Recorded " + pType + " for " + count + " animals";
            //}

                                      // document.forms[0].NFCID.value="787000853605892(982000175198006)";
            if (document.getElementById("filterInput") && document.getElementById("filterInput").value) {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if (document.getElementById("filterInput").value.indexOf('"') > -1) {
                    App.alert("Error", "Cant enter \" in the cow number box");
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
            return (false);  
        }// checkInput


        function submit()
        {
            var pType = "MarkForMove";
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
			//	if (processForm() == false) {
			//		return false;
			//	}
			//}

			var scorelist = '';
			//this is commented out until the database supports it
			//if (getLocation == true)
			//    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			//else
			WriteFormValues("MarkForMove.aspx?Type=AddMarkForMove&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = "MarkForMove has been recorded and will be transferred at next synchronisation";


			
			if (isEID != 1) {
				App.alert("Result", msg);
			}
			else {
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
                                      App.alert("Error", "Could not read: " + error.message);
                                  });
                    });
                    App.message(tag);
                    return;
             
    }

        function initPage() {
            var isEID = "<%=Master.IsEID%>";
            db = OpenDatabase();
            if (!db) {
                App.alert("Database", "Cannot open database");
                return;
            }
            if (document.getElementById('FullNumberList')) {
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
            SetDates("MarkForMove");
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            
            //FillDynamicList("AnimalList", "AnimalList", HerdID, 1, defaultAnimalID);
            
            if (defaultAnimalID) {
                seachOnAnimalID(defaultAnimalID);
            }

            //FillDynamicList("DoneObservedBy", "DoneObservedBy", HerdID, 0);

            // FillDynamicList("LamenessField", "FieldList", 0, 0);
            //FillDynamicList("LamenessMed", "MedicineList", HerdID, 0);
            //FillDynamicList("AdminBox", "DoneBy", HerdID, 0);

            if (isEID == 1) {
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if (document.getElementById('ReadMotherTag')) {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }
            }
        }


        //function readNfcTag(nfcTagNumber)
        //{
        //      var decimal=nfcTagNumber;
        //      //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0)) {
                  
        //          var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + HerdID + ")";
        //          db.transaction(function(transaction) {
        //              transaction.executeSql(sql, [],
        //                  function(transaction, results) {
        //                      //var listBox = document.getElementById("EIDAnimalList");
        //                      //var opt = document.createElement("option");
                              
        //                      // results.rows holds the rows returned by the query
        //                      if (results.rows.length == 1) {
        //                          var row = results.rows.item(0);
        //                          var skip = false;
                                 
        //                          if(row.Exception!=''){
        //                              App.alert("Exception", row.Exception);
        //                          }
        //                          if(row.WithdrawalDate!=''){
        //                              alertWithdrawal(row.WithdrawalDate,"MarkForMove");
        //                          }
                                
        //                              if (skip == false) {
        //                                  var exists = false;
        //                                  //
        //                                  var table = document.getElementById('AnimalListTable');
        //                                  var existRow = false;
        //                                  var rowCount = 0;
        //                                  if (table != null) {
        //                                      var tbody = table.getElementsByTagName("tbody")[0];
        //                                      rowCount = tbody.rows.length;
        //                                  }

        //                                  for (var k = 0; k < rowCount; k++) {
        //                                      var row = table.rows[k];
        //                                      var cells = row.getElementsByTagName("td");
        //                                      if (cells[0].innerText == row.ElectronicID) {
        //                                          existRow = true;
        //                                      }
        //                                  }
        //                                  //
        //                                  //$('#EIDAnimalList option').each(function () {
        //                                  //    if (this.text == row.ElectronicID) {
        //                                  //        exists=true;
        //                                  //    }
        //                                  //});
        //                                  if(!exists){
        //                                      listBox.options.add(opt, 0);
        //                                      opt.text = row.ElectronicID;
        //                                      opt.value = row.InternalAnimalID;
        //                                      setSelectedIndex(listBox, opt.value);
        //                                      var counter = document.getElementById("Count");
        //                                      counter.value = listBox.length;
        //                                      addToList(row.ElectronicID, null);
        //                                  }
        //                              }
                                     
        //                          }
        //                          else {
                                      
        //                          App.message(decimal + " Animal not found");
        //                            }
        //                },
        //                  function(transaction, error) {
        //                      App.alert("Error", "Could not read: " + error.message);
        //                  });
        //        });

        //    //}
        //}


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


        function seachOnAnimalID(animalID)
        {
            var eventType = "<%=Master.EventType%>";
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
                          alert("Error", "Could not read: " + error.message);
                      });
            });
            return true;

        }

        function searchFBFind()
        {
            var filterInput = document.getElementById("filterInput").value;
            if (!filterInput) {
                App.alert("Enter", "Please enter 1 or more cow numbers seperated by a comma");
                return false;
            }
            if (searchFB(filterInput, false) == false) {
                return false;
            }
        }


        function searchFB(filterInput, postEntry)
        {
            var eventType = "<%=Master.EventType%>";
        // Search database Datastore
        var sql = "SELECT * FROM Cows where (FreezeBrand = '" + filterInput + "' AND InternalHerdID = " + HerdID + ")";
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
                        
                        // Write the form to the offline cache
                        if (processForm() == false) {
                            return false;
                        }
                        WriteFormValues("MarkForMove.aspx?Type=AddMarkForMove&HerdID=" + HerdID, document.forms[0], document.forms[0].HidTitle.value);
                        if ("<%=Master.IsEID%>" == "1")
                        {
                            App.message("MarkForMove has been recorded and will be transferred at next synchronisation");
                        }
                        else {
                            App.alert("Result", "MarkForMove has been recorded and will be transferred at next synchronisation");
                        }
                        isCommitted = 1;
                        
                    }
                    else if (results.rows.length > 1) {
                        App.alert("Record Found", "More than one matching cow found " + results.rows.length);
                        return false;
                    }
                    else
                    {                      
                        
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


        function searchFBBatchAfter(pType)
        {
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
                    App.alert("Error", "All cow numbers must be less than 10 characters:" + input_array[i]);
                    return false;
                }

                
                if (searchFB(input_array[i], true) == false) {
                    return false;
                }
                
            }
            document.getElementById("filterInput").value = "";
            return true;
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