<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="AIService.aspx.cs" Inherits="HybridAppWeb.AIService" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="DoneLabel" runat="server" Font-Bold="True">Done By :</asp:Label></strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="DoneObservedBy" runat="server"></n0:MOBILEDROPDOWNLIST>
                    <div style="margin-top: 5px"></div>
                    <asp:TextBox ID="DoneObservedByText" runat="server" class="form-control" MaxLength="70"></asp:TextBox>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label16" runat="server" Font-Bold="True">Breed Code :</asp:Label></strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="BreedCodeList" runat="server" DataTextField="DisplayText" DataValueField="SireStockID"></n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label21" runat="server" Font-Bold="True">Sire :</asp:Label></strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="NameOfServiceList" runat="server"></n0:MOBILEDROPDOWNLIST>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="SireList2" runat="server" DataTextField="SireNameSexed" DataValueField="SireStockID"></n0:MOBILEDROPDOWNLIST>
                </div>

                <asp:TextBox ID="NameOfService" runat="server" MaxLength="60"></asp:TextBox>

                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="StrawsUsedLabel" runat="server" Font-Bold="True">Straws Used :</asp:Label></strong>
                    <asp:TextBox ID="StrawsUsed" class="form-control input-sm" runat="server">1</asp:TextBox>
                </div>
            </div>

            <tr>
                <td colspan="2">
                    <asp:CheckBox ID="InseminationChargeCheckBox" Visible="false" runat="server" Width="200px" Text="Insemination Charge?" Font-Bold="True"></asp:CheckBox>
                    <asp:CheckBox ID="SemenChargeCheckBox" Visible="false" runat="server" Width="200px" Text="Semen Charge?" Font-Bold="True"></asp:CheckBox>
                </td>
            </tr>
            <div class="form-group">
                <strong>
                    <asp:Label ID="ServiceLocationLabel" runat="server" Visible="false" Font-Bold="True">Service Location :</asp:Label></strong>
                <%--<div class="col-xs-6">--%>
                <n0:MOBILEDROPDOWNLIST class="form-control" visible="false" id="ServiceLocation" runat="server"></n0:MOBILEDROPDOWNLIST>
                <%--</div>--%>
                <div style="margin-top: 5px"></div>
            </div>


            <div align="center">

                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save AI Service</a>
            </div>
        </div>
    </div>

    <script type = "text/javascript">

        //
        var db;
        var isCommitted;
        //

        function checkInput()
        {
            var pType = "AIService";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

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
                    App.alert("Please Enter","Cant enter \" in the cow number box");
                    return false;
                }
                if (alwaysConfirmFlag == "1") 
                {
                    var txt = "Click OK to confirm you wish record a " + pType;
                    if (document.getElementById("<%=InseminationChargeCheckBox.ClientID%>")) 
                    {
                        txt += " Insemination is chargeable.";
                    }
                    if (document.getElementById("<%=SemenChargeCheckBox.ClientID%>")) 
                    {
                        txt += " Semen is chargeable.";
                    }
                    App.confirm("Record", txt, confirmRecord, pType);
                }// if
            }// if
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
            var pType = "AIService";
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
            WriteFormValues("AIService.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            var msg = pType + " has been recorded and will be transferred at next synchronisation";

            if (isEID != 1){
                App.alert("Result", msg);
            }
            else{
                App.message(msg); 
            }  

            var aniTable = document.getElementById("AnimalListTable");
            if (aniTable != null)
                aniTable.parentNode.removeChild(aniTable);

            //$('#EIDAnimalList').empty();
            document.getElementById("form1").reset();
            return true;
        }// submit


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
                                else {
                                    App.message(tag + " Animal not found");
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
            SetDates("AIService");
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
    
            FillDynamicList("<%=DoneObservedBy.ClientID%>", "DoneObservedBy", HerdID,0);
            
            FillDynamicList("<%=SireList2.ClientID%>", "SireListSexed", HerdID, 0);
            FillDynamicList("<%=BreedCodeList.ClientID%>", "BreedCodeList", HerdID, 0);
            if(document.getElementById("<%=NameOfServiceList.ClientID%>"))
                FillDynamicList("<%=NameOfServiceList.ClientID%>", "NameOfService", HerdID, 0);
            

            if (isEID == 1) 
            {           
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if(document.getElementById('ReadMotherTag')){
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }   
            }
        }

        function searchFBBatchAfter()
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
                    App.alert("Incorrect Cow Number","All cow numbers must be less than 10 characters:" + input_array[i]);
                    return false;
                }
                
                if (searchFBAI(input_array[i], true) == false) {
                    return false;
                }
                

                else {
                    if (searchFB(input_array[i], true) == false) {
                        return false;
                    }
                }
            }

            document.getElementById("filterInput").value = "";

            
            if (input_array.length > 1) {
                return confirm(input_array.length + " services recorded, are you sure you want to continue?");
                //return App.confirm("Record", input_array.length + " services recorded, are you sure you want to continue?", confirmRecord, pType);
            }
            
            return true;
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
                     App.alert("Error","Could not read: " + error.message);
                 });
                });
            }
            else {
                App.alert("Database",'Cant open database');
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
         //     //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0))
         //     //{            
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
         //                             alertWithdrawal(row.WithdrawalDate,"AIService");
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
         //}

        function searchFBAI(filterInput) {
            var HerdID = sessionStorage.getItem('HerdID');
    // Search database Datastore
    var sql = "SELECT * FROM Cows where FreezeBrand = '" + filterInput + "' AND InternalHerdID = " + HerdID;
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
                    document.forms[0].HidAnimalsToAdd.value = ""; // Need to clear this if not clear already


                    setSelectedIndex(document.getElementById("AnimalList"), row.InternalAnimalID);

                    var lastServedOn = new Date(row.LastServedDate.substring(6),
                        row.LastServedDate.substring(3, 5) - 1, row.LastServedDate.substring(0, 2));
                    var today = new Date();
                    var days = (today.getTime() - lastServedOn.getTime()) / 86400000;
                    days = Math.round(days);
                    if (days < 14) {
                        var ans = confirm("Cow " + filterInput + " Served on " + lastServedOn + " are you sure you want to record service?");
                        //var ans = App.confirm("Record", "Cow " + filterInput + " Served on " + lastServedOn + " are you sure you want to record service?", confirmRecord, pType);
                        if (ans == false) {
                            return false;
                        }
                    }

                    var inbreedPotential = row.InBreedingPotential;
                    if (document.getElementById("<%=SireList2.ClientID%>")) {
                        var sire = document.getElementById("<%=SireList2.ClientID%>").value;
                        if (inbreedPotential.indexOf(sire) >= 0) {
                            var ans = confirm("Cow " + filterInput + " has inbreeding potential with selected sire, are you sure you want to record service?");
                            //var ans = App.confirm("Record", "Cow " + filterInput + " has inbreeding potential with selected sire, are you sure you want to record service?", confirmRecord, pType);
                            if (ans == false) {
                                return false;
                            }
                        }
                    }
                    // Write the form to the offline cache
                    if (processForm() == false) {
                        return false;
                    }
                    WriteFormValues("AIService.aspx?Type=AddAIService&HerdID=" + HerdID, document.forms[0], document.forms[0].HidTitle.value);
                    isCommitted = 1;
                }
                else if (results.rows.length > 1) {
                    App.alert("Please Select","More than one matching cow found " + results.rows.length);
                    return false;
                }
                else {
                    if ("<%=Master.Package%>" == "AITechnician") {
                            // We check if this is a live FW herd or not based on its name
                            var herdName = sessionStorage.getItem('HerdName');
                            if ((herdName == null) || (herdName.indexOf("-") < 0)) {
                                App.alert("Unsuccessfully", "Cow number " + filterInput + " not set on FarmWizard, you must set it before you can record insem, THIS INSEM HAS NOT BEEN RECORDED, PLEASE ENSURE YOU HAVE SELECTED A HERD");
                                return false;
                            }

                            // Set system to add this animal to the database
                            document.forms[0].HidAnimalsToAdd.value = filterInput;
                            // Write the form to the offline cache
                            if (processForm() == false) {
                                return false;
                            }
                            WriteFormValues("AIService.aspx?Type=AddAIService&HerdID=" + HerdID, document.forms[0], document.forms[0].HidTitle.value);

                            return true;
                        }
                        else {
                            App.alert("Records Not found","No matching cows for " + filterInput);
                            return false;
                        }
                    }
                },
                  function (transaction, error) {
                      App.alert("Error","Could not read: " + error.message);
                  });
        });
        return true;
    }

        function searchFB(filterInput,postEntry) {
            var eventType = 'AIService';
            var HerdID = sessionStorage.getItem('HerdID');
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
                            // Write the form to the offline cache
                            if (processForm() == false) {
                                return false;
                            }
<%--                            WriteFormValues("AIService.aspx?Type=Add" + eventType + "&HerdID=" + HerdID, document.forms[0], document.forms[0].HidTitle.value);
                            if("<%=Master.IsEID%>" == "1")  {
                                App.Messaget(eventType + " has been recorded and will be transferred at next synchronisation");
                            }
                            else {
                                App.alert("Result", eventType + " has been recorded and will be transferred at next synchronisation");
                            }
                            isCommitted = 1;--%>
                    }
                    else if (results.rows.length > 1) {
                        App.alert("Please Select","More than one matching cow found " + results.rows.length);
                        return false;
                    }
                    else
                    {
                        App.alert("Records", "No matching cows for " + filterInput);
                        return false;
                    }
                },
                  function (transaction, error) {
                      App.alert("Error","Could not read: " + error.message);
                  });
        });
        return true;
        }

        function processForm() {
            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("No records found", "No cow selected");
                    return false;
                }
            }
                if (document.getElementById("<%=SireList2.ClientID%>")) {
                    if (document.getElementById("<%=SireList2.ClientID%>")[document.getElementById("<%=SireList2.ClientID%>").selectedIndex].text.search("IB RISK") != -1) {
                        var answer = confirm("Potential inbreeding risk click YES to confirm service");
                        //var answer = App.confirm("Record", "Potential inbreeding risk click YES to confirm service", confirmRecord, pType);
                        if (answer) {
                        }
                        else {
                            return false;
                        }
                    }
                }
            
            document.forms[0].IsSubmitted.value = true;
            return true;
        }

        function setHidTitle() {
            var title = "";
            var pEventType='AIService';
                if (document.getElementById("Eidinputdate")) {
                    title += document.getElementById("Eidinputdate").value;
                }
                title += document.getElementById("inputdate").value;
                //document.forms[0].DoneDay.value + "/" +document.forms[0].DoneMonth.value  + "-";
            var opts = document.forms[0].AnimalList;
            var cow = opts.options[opts.selectedIndex].text;
            if(document.forms[0].HidAnimalNos.value != '') {
                cow = document.forms[0].HidAnimalNos.value;
            }
            if (document.forms[0].HidAnimalsToAdd.value != '') {
                cow = document.forms[0].HidAnimalsToAdd.value;
            }
            // just copy first 15 chars if its too long
            if (cow.length > 15) {
                cow = cow.substring(0, 15);
            }
                title += pEventType.substring(0,5) + "-" + cow;
          
                var sireOpts = document.getElementById("<%=SireList2.ClientID%>");
                if (!sireOpts) {
                    // this must be from non sire stock herd
                    sireOpts = document.getElementById("<%=NameOfServiceList.ClientID%>");
                }
                title += "-" + sireOpts.options[sireOpts.selectedIndex].text
              
            document.forms[0].HidTitle.value = title;
        }

           function seachOnAnimalID(animalID) {
        var eventType = "AIService";
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
                          App.alert("Error","Could not read: " + error.message);
                      });
            });
            return true;

           }

           function searchFBFind() {
               var filterInput = document.getElementById("filterInput").value;
               if (!filterInput) {
                   App.alert("Please Select", "Please enter 1 or more cow numbers seperated by a comma");
                   return false;
               }
               if (searchFB(filterInput, false) == false) {
                   return false;
               }
           }


           function confirmRecord(pId, pValue) {
               if (pValue == false) {
                   return false;
               }// if
               else {
                   if (searchFBBatchAfter("AIService") == false) {
                       return false;
                       //$('#EIDAnimalList').empty();
                       checkInput();
                   }
                   //$('#EIDAnimalList').empty();
                   checkInput();
                   return false;
               }// else
           }// confirmRecord

    </script>

</asp:Content>
