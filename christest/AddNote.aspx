﻿<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="AddNote.aspx.cs" Inherits="HybridAppWeb.AddNote" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
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
         <div align="center">
            <a class="btn btn-primary waves-effect waves-light" href="#" onclick="checkInput();">Add Note</a>
         </div>
    </div>

    <script type = "text/javascript">
        ///<reference path="/Script/jquery-ui.min.js" />
        ///<reference path="/Script/HybridApp.js" />

        var db;

        function checkInput()
        {
            var pType = "AddNote";
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


            //deleteAllFromList();

            //if (isEID == 1)
            //{

                //var animals = document.getElementById("EIDAnimalList").options;
                //var count = animals.length;

                //if (count == 0) {
                //    App.message("No animals scanned : Please Scan EID");
                //    return false;
                //}

                //var animalList = "";
                ////  alert("check process "+  document.forms[0].NFCID.value);
                //for (var k = 0; k < count; k++) {
                //    if (k > 0) {
                //        animalList += ",";
                //    }
                //    animalList = animalList + animals[k].value;
                //}

                //document.forms[0].HidAnimalList.value = animalList;
                //animals.length = 0;
                ////document.forms[0].Count.value = "";
                //document.forms[0].HidTitle.value = "Recorded " + pType + " for " + count + " animals";
            //}
            
            // document.forms[0].NFCID.value="787000853605892(982000175198006)";
            if(document.getElementById("filterInput") && document.getElementById("filterInput").value) 
            {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if(document.getElementById("filterInput").value.indexOf('"') > -1) 
                {
                    App.alert("No records found", "Cant enter \" in the cow number box");
                    return false;
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
            return (false);
        }


        function submit()
        {
            var pType = "AddNote";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

            //var opts = document.forms[0].AnimalList;

            //if (opts) {
            //    document.forms[0].HidAnimalList.value = opts.value;
            //    document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
            //    if (document.forms[0].HidAnimalList.value == "0") {
            //        App.alert("Please Enter", "Please select or type a cow number");
            //        return false;
            //    }
            //    if (processForm(pType) == false) {
            //        return false;
            //    }
            //}

            var scorelist = '';
            //this is commented out until the database supports it
            //if (getLocation == true)
            //    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            //else
            WriteFormValues("AddNote.aspx?Type=AddNote&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            var msg = pType + " has been recorded and will be transferred at next synchronisation";

            if ("" != "") {
                if ("" == "true") {
                    AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
                    var voiceRespM = AsyncAndroid.GetVoiceCommand();
                    if (voiceRespM != "no") {

                    }
                    else {
                        AsyncAndroid.ConvertTextToVoice(msg);
                        setTimeout(function () { returnToMain(); }, 1000);
                    }
                }
                else {
                    AsyncAndroid.ConvertTextToVoice(msg);
                    setTimeout(function () { returnToMain(); }, 2000);
                }
            }
            else if (isEID != 1) {
                App.alert("Result", msg);
            }
            else {
                App.message(msg);

            }

            var aniTable = document.getElementById("AnimalListTable");
            if (aniTable != null)
                aniTable.parentNode.removeChild(aniTable);

            ////$('#EIDAnimalList').empty();
            document.getElementById("form1").reset();

            return true;
        }// submit

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

                            ////do something here !!!! row.NationalID
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
                                ////var listBox = document.getElementById("EIDAnimalList");
                                ////var opt = document.createElement("option");
                                      
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
                                else {
                                    App.message(tag + " Animal not found");
                                }
                        },
                                  function(transaction, error) {
                                      App.alert("Error", "Could not read: " + error.message);
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
            SetDates("AddNote");
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
           

            if (document.getElementById('ReadMotherTag'))
            {
                document.getElementById('ReadMotherTag').style.display = 'none';
            }

            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Record Note");
            //
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
                        //else if (results.rows.length == 1) {
                        //    var row = results.rows.item(0);
                        //    var skip = false;
                        //    document.getElementById('FullNumberList').style.display = 'none';
                        //    document.getElementById('FullNumberList').options.length = 0;
                        //    if (row.Exception != '') {
                        //        App.alert("Exception", row.Exception);
                        //    }
                        //    if (row.WithdrawalDate != '') {
                        //        alertWithdrawal(row.WithdrawalDate);
                        //    }
                        //    if (skip == false) {
                        //        if (document.getElementById("EIDAnimalList")) {
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
         //                     ////var listBox = document.getElementById("EIDAnimalList");
         //                     ////var opt = document.createElement("option");
                              
         //                     // results.rows holds the rows returned by the query
         //                     if (results.rows.length == 1) {
         //                         var row = results.rows.item(0);
         //                         var skip = false;
                                 
         //                         if(row.Exception!=''){
         //                             App.alert("Exception", row.Exception);
         //                         }
         //                         if(row.WithdrawalDate!=''){
         //                             alertWithdrawal(row.WithdrawalDate,"AddNote");
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

         //                               App.message(decimal + " Animal not found");
         //                           }
         //               },
         //                 function(transaction, error) {
         //                     App.alert("Error", "Could not read: " + error.message);
         //                 });
         //       });

         //   //}
         //  }
    </script>

</asp:Content>