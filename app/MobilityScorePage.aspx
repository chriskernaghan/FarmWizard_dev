<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="MobilityScorePage.aspx.cs" Inherits="HybridAppWeb.MobilityScorePage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:Panel ID="MobilityPanel" Visible="false" runat="server">
            <div class="panel panel-default">   
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <div class="input-group input-field">
                        <b>Select animal :</b>
                        <input type="text" class="input-sm autocomplete" name="CowNumber" id="CowNumber" placeholder="Search animal" />
                    </div>
                </div>
                <div class="form-group col-xs-6">
                    <strong>Score :</strong>

                    <n0:MOBILEDROPDOWNLIST class="form-control" id="MobilityScore" runat="server" EnableViewState="False">
                        <asp:ListItem Value="0">0</asp:ListItem>
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div align="center">
                <br />
                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Score</a>
            </div>
        </div>      
    </div>
    </asp:Panel>
    <asp:Panel ID="MobilityEIDPanel" Visible="true" runat="server">
    <div class="panel panel-default">
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
                <div id="animalScoresTable">
            
                </div>
<%--                <table class="formLink" id="EIDScoreTable" style="font-family: Times New Roman; border-collapse: collapse" cellspacing="0" rules="all" border="1">
                    <thead>
                        <tr style="font-weight: bold; color: white; background-color: #ffcc66">
                            <th id="TdS1">Animal</th>
                            <th id="TdS2">Score</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>--%>
            </div>
        </div>
        <div align="center">
            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="addEIDScore();">Save Scores</a>
        </div>
    </div>
        </asp:Panel>
    
    <script type = "text/javascript">

        var db;


        function checkInput() 
        {
            var pType = "MobilityScore";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var herdID = sessionStorage.getItem('HerdID');
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
            //        App.message("Error", "No animals scanned : Please Scan EID");
            //        return false;
            //    }

            //    var animalList = "";         

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
                    }// if

                    App.confirm("Record", txt, confirmRecord, pType);
                }// if
            }// if
            else 
            {          
                if (isEID != 1) {
                    submit();
                }
                else {
                    return true;
                }
            }
            // Always return false so that for doesnt get submitted
            return(false);
        }


        function submit()
        {
            var pType = "MobilityScore";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

            var opts = document.forms[0].AnimalList;
           
            //if (opts) {
            //    document.forms[0].HidAnimalList.value = opts.value;
            //    document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
            //    if (document.forms[0].HidAnimalList.value == "0") {
            //        App.alert("Error", "Please select or type a cow number");
            //        return false;
            //    }
            //    if (processForm() == false) {
            //        return false;
            //    }
            //}
               
            var scorelist='';
            //this is commented out until the database supports it
            //if (getLocation == true)
            //    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            //else
            //if (isEID != "1")
            //{
                WriteFormValues("MobilityScorePage.aspx?Type=AddMobilityScore&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
                var msg = "MobilityScore has been recorded and will be transferred at next synchronisation";
            //}
            //else
            //{
            //    WriteFormValues("MobilityScorePage.aspx?Type=AddEIDMobilityScore&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            //    var msg = "EIDMobilityScore has been recorded and will be transferred at next synchronisation";
            //}

                
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
            }  
        
            var aniTable = document.getElementById("AnimalListTable");
            if (aniTable != null)
                aniTable.parentNode.removeChild(aniTable);

            //$('#EIDAnimalList').empty();
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
                            eidScore(row.NationalID, row.ScoreHistory);
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
             //var sql = "SELECT * FROM Cows where (ElectronicID = '" + decimal + "' AND InternalHerdID = " + HerdID + ")";
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
                                                             eidScore(row.NationalID, row.ScoreHistory);
                                                                 //if (document.getElementById("EIDAnimalList") != null) {
                                                                 //    listBox.options.add(opt, 0);
                                                                 //    opt.text = decimal;
                                                                 //    opt.value = row.InternalAnimalID;
                                                                 //    setSelectedIndex(listBox, opt.value);
                                                                 //    var counter = document.getElementById("Count");
                                                                 //    counter.value = listBox.length;
                                                                 //    addToList(decimal, null);
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

                                 
            
                    //if(manualSearch == false)  {
                    //      setTimeout(function() { readOneTag(pForLambs); }, 500);
                    //  }
                    
                      App.message(tag);
                      stopReading = 1;
                      return;
          

        }

        function initPage() 
        {
            var isEID = "<%=Master.IsEID%>";

            //
            //document.getElementById("selectedAnimalsTable").style.visibility = "hidden";
            //

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
            if (isEID == 0) 
            {
                var theTextBox = document.getElementById("filterInput");
                //   theTextBox.style["width"] = "220px";
            } 
            SetDates("MobilityScore");
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) 
            {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
            //FillDynamicList("AnimalList", "AnimalList", HerdID, 1, defaultAnimalID);

            if (defaultAnimalID) {
                seachOnAnimalID(defaultAnimalID);
            }

            /////
            var tableID = "EIDScoreTable";
            var table1 = document.getElementById(tableID);
            if (table1 == null) {
                createTable();
            }
            /////


            //FillDynamicList("DoneObservedBy", "DoneObservedBy", HerdID,0);
            
            //if (isEID == 1) 
            //{          
            //    //document.getElementById('selectedAnimalsTable').style.display = 'block';
          
            //    //if (document.getElementById('ReadMotherTag'))
            //    //{
            //    //    document.getElementById('ReadMotherTag').style.display = 'none';
            //    //}                 
            //}

            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Record Mobility Score");
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
                            eidScore(row.NationalID, row.ScoreHistory);
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


        function ScoreResults(pId, pValue) {
            if (pValue == false) {
                var aniTable = document.getElementById("AnimalListTable");
                if (aniTable != null)
                    aniTable.parentNode.removeChild(aniTable);

                //$('#EIDAnimalList').empty();
                document.getElementById("form1").reset();

                //EIDScoreTable.deleteRow;
                //var tbl = document.getElementById("EIDScoreTable");
                //if (tbl) tbl.parentNode.removeChild(tbl);
                return;
            }
            else {
                var value = pValue;
                if (isNaN(value)) {
                    App.textInput("Please enter", "Please enter mobility score (must be numeric):", "ScoreResults", pId, true)
                }
                else {
                    var tableID = "EIDScoreTable";
                    var table = document.getElementById(tableID);
                    var tbody = table.getElementsByTagName("tbody")[0];
                    var rowCount = tbody.rows.length;
                    var row = tbody.insertRow(-1);

                    var InternalIDHidCell = row.insertCell(0);
                    InternalIDHidCell.style.padding = "5px";
                    InternalIDHidCell.style.margin = "5px";
                    InternalIDHidCell.appendChild(document.createTextNode(pId));

                    var cell2 = row.insertCell(1);
                    var element9 = document.createElement("input");
                    element9.type = "number";
                    element9.value = value;
                    element9.style.width = '60px';
                    element9.align = "center";
                    cell2.appendChild(element9);

                    //var table = document.getElementById('EIDScoreTable');
                    //var row = table.insertRow(1);

                    //var cell1 = row.insertCell(0);
                    //cell1.appendChild(document.createTextNode(pId));

                    //var cell7 = row.insertCell(1);
                    //var element10 = document.createElement("input");
                    //element10.type = "number";
                    //element10.value = value;
                    //element10.style.width = '40px';
                    //cell7.appendChild(element10);
                }// else
            }// else
        }// ScoreResults


        function confirmRecord(pId, pValue) {
            if (pValue == false) {
                return false;
            }// if
            else {
                document.getElementById("filterInput").value = "";
                submit();
                return true;
            }// else
        }// confirmRecord


        function readNfcTag(nfcTagNumber){
              var pForLambs=0;;
              var decimal=nfcTagNumber;
                         
              //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0))
              //{   
                  var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + HerdID + ")";
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
                                      alertWithdrawal(row.WithdrawalDate,"MobilityScore");
                                  }
                                    eidScore(row.NationalID, row.ScoreHistory);
                                  if (skip == false)
                                  {
                                      var exists = false;
                                      //
                                      var table = document.getElementById('EIDScoreTable');
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
                                    if (!exists)
                                    {
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
                                      
                                      App.message(decimal + " Animal not found");
                                  }
                        },
                          function(transaction, error) {
                              App.alert("Error", "Could not read: " + error.message);
                          });
                });

            //}
        }

        function addEIDScore()
        {
            var selectedAnimalsTable = document.getElementById('EIDScoreTable');
            var count = 0;
            if (selectedAnimalsTable != null) {
                var tbody = selectedAnimalsTable.getElementsByTagName("tbody")[0];
                //count the rows
                count = tbody.rows.length;
            }

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this
            //var selectedAnimals = document.getElementById("EIDAnimalList").options;
            //var count = selectedAnimals.length;

            if (count == 0) {
                App.alert("Error", "No Tags scanned");
                return false;
            }

            var animalList = "";
            var scoreTable = document.getElementById("EIDScoreTable");

            // Note in this case weight is also recorded in selected animals
            for (var i = 0; i < count; i++) {
                if (i > 0) {
                    animalList = animalList + ":";
                }
                //animalList = animalList + selectedAnimals[i].text; // EID is in here
                var tbody = selectedAnimalsTable.getElementsByTagName("tbody")[0];
                var row = tbody.rows[i];
                var cells = row.getElementsByTagName("td");
                animalList = animalList + cells[0].innerText; // EID is in here

                // Check if animal was selected for movement
                var row = scoreTable.rows[i + 1];
                var score = row.cells[1].childNodes[0].value;
                animalList = animalList + "," + score;
            }
            var rowCount = scoreTable.rows.length;
            // Delete any weights still sitting there
            for (var k = 1; k < rowCount; k++) {
                scoreTable.deleteRow(k);
                rowCount--;
                k--;
            }

            document.forms[0].EIDWeighAnimalList.value = animalList;

            if (checkInput()) {
                return submit();
            }
            else {
                return false;
            }
        }


        function eidScore(pNationalID, pScoreHistory) {
            var table = document.getElementById('EIDScoreTable');
            var existRow = false;
            //var rowCount = table.rows.length;
            var rowCount = 0;
            if (table != null) {
                var tbody = table.getElementsByTagName("tbody")[0];
                //count the rows
                rowCount = tbody.rows.length;
            }


            // Delete any weights still sitting there
            for (var k = 0; k < rowCount; k++) {
                //var row = table.rows[k];
                var row = tbody.rows[k];
                var cells = row.getElementsByTagName("td");
                if (cells[0].innerText == pNationalID) {
                    existRow = true;
                }
            }
            if (!existRow) {
                //var row = table.insertRow(1);

                //var cell1 = row.insertCell(0);
                //cell1.appendChild(document.createTextNode(pNationalID));

                //var score = window.prompt("Please enter condition score, previously: " + pScoreHistory, "");
                //if (isNaN(score)) {
                //    score = window.prompt("Please enter condition score (must be numeric):", "");
                //}
                //var cell7 = row.insertCell(1);
                //var element10 = document.createElement("input");
                //element10.type = "number";
                //element10.value = score;
                //element10.style.width = '40px';
                //cell7.appendChild(element10);

                App.textInput("Please enter", "Please enter mobility score, previously: " + pScoreHistory, "ScoreResults", pNationalID, true);
            }

            return true;


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
                            if (processForm() == false) {
                                return false;
                            }
                        }
                    }
                    else if (results.rows.length > 1) {
                        App.alert("Record Found", "More than one matching cow found " + results.rows.length);
                        return false;
                    }
                    else
                    {                       
                        if("<%=Master.HandsFree%>" != "") {
                            initPage();
                        }
                        else {
                            App.alert("Records Not Found", "No matching cows for " + filterInput);
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




        function createTable() {
            var tableID = "EIDScoreTable";
            var table = document.createElement('table');
            table.id = tableID;
            table.style.padding = "4px";
            table.style.margin = "4px";

            ////////////////////////////////////////
            var header = table.createTHead();
            var row = header.insertRow(0);
            var cell = document.createElement('th');
            cell.innerHTML = "Animal";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            row.appendChild(cell);

            var header = table.createTHead();
            //var row = header.insertRow(0);
            //var cell = document.createElement('th');
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Score";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);
            ////////////////////////////////////////

            var newtbody = document.createElement('tbody');
            table.appendChild(newtbody);

            //add the table to the DOM
            document.getElementById('animalScoresTable').appendChild(table);
        }// createTable


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
