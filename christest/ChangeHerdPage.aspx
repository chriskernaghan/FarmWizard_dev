<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="ChangeHerdPage.aspx.cs" Inherits="HybridAppWeb.ChangeHerdPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    
    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <asp:CheckBox ID="LinkedHoldingCheckBox" runat="server" Text="Linked Holding"></asp:CheckBox>
                </div>
                <div class="form-group col-xs-6">
                    <b>Herd:</b>
                    <n0:MOBILEDROPDOWNLIST id="ReassignHerdList" runat="server" EnableViewState="False" DataTextField="FriendlyName" DataValueField="InternalHerdID" />
                </div>
            </div>
            <div align="center">
                <a class="btn btn-primary waves-effect waves-light" id="ReassignButton" onclick="reassignHerd('ChangeHerd');">Reassign Herd</a>
            </div>
        </div>
    </div>

    <script type = "text/javascript">
        ///<reference path="/Script/jquery-ui.min.js" />
        ///<reference path="/Script/HybridApp.js" />

        //
        var db;
        //

        function checkInput() 
        {
            var pType = "ChangeHerd";
            var herdID = sessionStorage.getItem('HerdID');
            var isEID = "<%=Master.IsEID%>";
            var getLocation = false;



            //var animalListEID = "";
            //var animalListNFC = "";
            //var eidnfclist = getAllFromList();

            //for (var k = 0; k < eidnfclist.length; k++) {
            //    if (k > 0) {
            //        animalListEID += ",";
            //        animalListNFC += ",";
            //    }
            //    animalListEID = animalListEID + eidnfclist[k].EID;
            //    animalListNFC = animalListNFC + eidnfclist[k].NFCID;
            //}

            //document.forms[0].HidAnimalList.value = animalListEID;
            //if (animalListNFC == "undefined" || animalListNFC == null)
            //    document.forms[0].HidAnimalListNFC.value = null;
            //else
            //    document.forms[0].HidAnimalListNFC.value = animalListNFC;

            //var count = eidnfclist.length;

            ////document.forms[0].Count.value = "";
            //document.forms[0].HidTitle.value = "Recorded " + pType + " for " + count + " animals";


            ////if (isEID == 1) 
            ////{   
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
            if(document.getElementById("filterInput") && document.getElementById("filterInput").value) 
            {
                // NOTE WRITE FORM VALUES CALLED FROM WITHIN THIS FUNCTION
                if(document.getElementById("filterInput").value.indexOf('"') > -1) 
                {
                    App.alert("Error","Cant enter \" in the cow number box");
                    return false;
                }
            }
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
            var pType = "ChangeHerd";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;
			
			//if(isEID == 1)
			//{
				WriteFormValues("ChangeHerdPage.aspx?Type=AddChangeHerd&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
				var msg = "Herd move has been recorded and will be transferred at next synchronisation";

				if (isEID != 1) {
					App.alert("Result", msg)
				}
				else {
					App.message(msg);
				}

				//App.alert("Result","Herd move has been recorded and will be transferred at next synchronisation");

				var aniTable = document.getElementById("AnimalListTable");
				if(aniTable!=null)
				aniTable.parentNode.removeChild(aniTable);

				//$('#EIDAnimalList').empty();
				document.getElementById("form1").reset();
			//}
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
            SetDates("ChangeHerd");
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
            
            //if (isEID == 1) 
            //{
            
            //    document.getElementById('selectedAnimalsTable').style.display = 'block';
    
            //    if (document.getElementById('ReadMotherTag'))
            //    {
            //        document.getElementById('ReadMotherTag').style.display = 'none';
            //    }
            //}
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
         //                             alertWithdrawal(row.WithdrawalDate, 'ChangeHerd');
                                      
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
         //                                 if (!exists)
         //                                 {
         //                                     //listBox.options.add(opt, 0);
         //                                     //opt.text = row.ElectronicID;
         //                                     //opt.value = row.InternalAnimalID;
         //                                     //setSelectedIndex(listBox, opt.value);
         //                                     //var counter = document.getElementById("Count");
         //                                     //counter.value = listBox.length;
         //                                     addToList(row.ElectronicID, null);
         //                                 }
         //                             }
                                     
         //                         }
         //                         else {
                                      
         //                         App.message(decimal + " Animal not found");
         //                           }
         //               },
         //                 function(transaction, error) {
         //                     App.alert("Error", "Could not read: " + error.message);
         //                 });
         //       });

         //   //}
         //}


        function reassignHerd(pType)
        {
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            //var herdList = document.getElementById("ReassignHerdList");
            //var strUser = herdList.options[herdList.selectedIndex].text;
            var elementList = document.getElementById("<%=ReassignHerdList.ClientID%>");           
            var herdListID = elementList.options[elementList.selectedIndex].value;

            if (herdID == herdListID)

            {
                App.alert("Result", "Animals already in " + elementList.options[elementList.selectedIndex].text + "\r\nNo movement recorded.");
                document.getElementById("form1").reset();
            }
            else
            {
                var today = new Date();
                var daystr=today.getDate();
                if(daystr<10)
                {
                    daystr="0"+daystr;
                }
                var month = today.getMonth() + 1;
                var monthStr = month;
                if(month < 10) {
                    monthStr = "0" + month;
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
                document.forms[0].ReassignDateLabel.value = today.getFullYear() + "-" + monthStr + "-" + daystr;
                //alert( today.getFullYear() + "-" + monthStr + "-" + daystr);
                document.forms[0].HidTitle.value = count + " Animal has been moved";



                //if (isEID == 1)
                //{
                //    var animals = document.getElementById("EIDAnimalList").options;

                //    var count = animals.length;
                //    if (count == 0) {
                //        App.message("No animals scanned");
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
                //    document.forms[0].ReassignDateLabel.value = today.getFullYear() + "-" + monthStr + "-" + daystr;
                //    document.forms[0].HidTitle.value = count + "Animal has been moved";

                    if (checkInput()) {
                        return submit();
                    }
                    else {
                        return false;
                    }// else
                //}// if
            }// else
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
                            //    if(row.Exception!='')
                            //    {
                            //        App.alert("Exception", row.Exception);
                            //    }
                            //    if(row.WithdrawalDate!='')
                            //    {
                            //        alertWithdrawal(row.WithdrawalDate);
                            //    }
                            //    if (skip == false)
                            //    {
                            //        if(document.getElementById("EIDAnimalList"))
                            //        {
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

    </script>

</asp:Content>
