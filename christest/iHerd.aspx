<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="iHerd.aspx.cs" Inherits="HybridAppWeb.iHerd" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <script type="text/javascript">
        var db;
        var StockTakeMode;
        var isExpectingSetEID = false;
        var isExpectingSetNFC = false;

        function exitPage() 
        {
            stopReading = 1;
            var eventType = "<%=Master.EventType%>";


            return true;

        }
                
        function initPage(pSyncUp) 
        {
            var isCogent = "<%=Master.IsCogent %>";

            //if (document.getElementById('NonEIDEntryPanel'))
            //    document.getElementById('NonEIDEntryPanel').style.display = 'none';
            //if (document.getElementById('EIDEntryPanel'))
            //    document.getElementById('EIDEntryPanel').style.display = 'none';
            //if (document.getElementById('CommonPanel'))
            //    document.getElementById('CommonPanel').style.display = 'none';

            if (document.getElementById('TitleLabel'))
                document.getElementById('TitleLabel').style.display = 'none';


            //To hide textbox when pageload
            if(document.getElementById("NfcTagID")){
                document.getElementById("NfcTagID").style.display='none';
            }

            StockTakeMode = false;
            <%--if(document.getElementById("<%=MultiHerd.ClientID%>")) {             
                var toSelect = document.getElementById("<%=MultiHerd.ClientID%>");       
                var fromSelect = document.getElementById("<%=MultiHerdCopy.ClientID%>"); 

                var toSelect2 = document.getElementById("<%=ReassignHerdList.ClientID%>");      
                toSelect.innerHTML = fromSelect.innerHTML;    

                if(toSelect2) {
                    toSelect2.innerHTML = fromSelect.innerHTML;      
                }

                fromSelect.hidden = true;
                fromSelect.style.display = 'none';  
                fromSelect.className += " hide";  
                //hideSelect(document.getElementById("MultiHerdCopy"));
            }--%>

            if ("<%=Master.IsMultiHerd%>" == "true") {             
                var toSelect = document.getElementById("MultiHerd");       
                var fromSelect = document.getElementById("MultiHerdCopy"); 

                var toSelect2 = document.getElementById("<%=ReassignHerdList.ClientID%>");      
                toSelect.innerHTML = fromSelect.innerHTML;    

                if(toSelect2) {
                    toSelect2.innerHTML = fromSelect.innerHTML;      
                }

                fromSelect.hidden = true;
                fromSelect.style.display = 'none';  
                fromSelect.className += " hide";  
                //hideSelect(document.getElementById("MultiHerdCopy"));
            }

            if(document.getElementById("Buttons"))
                document.getElementById("Buttons").style.display = 'block';
            
            if(document.getElementById("EventManagement"))
                document.getElementById("EventManagement").style.display = 'none';
            
            if(document.getElementById("FieldRecordsDisplay"))
                document.getElementById("FieldRecordsDisplay").style.display = 'none';
            
            if(document.getElementById("BackToReportButton"))
                document.getElementById("BackToReportButton").style.display = 'none';
              
            if(document.getElementById("DetailsTable"))
            {               
                var theTable = (document.getElementById("DetailsTable"));
                theTable.style.display = 'none';
            }

            if (document.getElementById("<%=SetButtons.ClientID%>"))
                document.getElementById("<%=SetButtons.ClientID%>").style.display = 'none';

            if(document.getElementById("MenuTabs"))
                document.getElementById('MenuTabs').style.display = 'none';

            //document.getElementById('CowNumberList').style.display = 'none';
            //hideSelect(document.getElementById('CowNumberList'));
            //document.getElementById('CowNumberList').className += " hide";
            //document.getElementById('CowNumberList').options.length = 0;

            if(document.getElementById("StoredReportList"))
                hideSelect(document.getElementById('StoredReportList'));

            if(document.getElementById("StoredReportListTable"))
                document.getElementById('StoredReportListTable').style.display = 'none';

            if(document.getElementById("BovineButtons")) {
                document.getElementById("BovineButtons").style.display = 'block';
            }
                     

            var psTable = (document.getElementById('PassportsTable'));
            if(psTable) {
                psTable.style.display = 'none';
                document.getElementById('PassportScanner1').style.display = 'none';
                document.getElementById('PassportScanner2').style.display = 'none';
                  
                document.getElementById('SavePassportButton').style.display = 'none';
            }
            if(document.getElementById('CallLogList')){
                document.getElementById('CallLogList').style.display = 'none';
                hideSelect(document.getElementById('CallLogList'));
            }

            var herdMovePanel = (document.getElementById('reassignArea'));
            if(herdMovePanel) {
                herdMovePanel.style.display = 'none';
            }
            
            var breedCMPanel = (document.getElementById('BCMArea'));
            if(breedCMPanel) {
                breedCMPanel.style.display = 'none';
            }
            
            var mvTable = (document.getElementById('MoveTable'));
            if(mvTable) {
                mvTable.style.display = 'none';
            }


            var actTable = (document.getElementById('ActionListTable'));
            if(actTable) {
                actTable.style.display = 'none';
            }

            if(document.getElementById('EventsTable'))
            {
                var eTable = (document.getElementById('EventsTable'));
                // Clear events table
                for (var i = eTable.rows.length - 1; i > 0; i--) {
                    eTable.deleteRow(i);
                }
                eTable.style.display = 'none';      
            }

            if(document.getElementById('AllEventsTable'))
            {
                var aTable = (document.getElementById('AllEventsTable'));
                // Clear events table
               
                for (var i = aTable.rows.length - 1; i > 0; i--) {
                    aTable.deleteRow(i);
                }
                aTable.style.display = 'none';
            }
            // Set default herdID
            var herdID =  sessionStorage.getItem('HerdID');
            if(!herdID) {
                herdID = "<%=Master.HerdID%>";
                sessionStorage.removeItem('HerdID');
                sessionStorage.setItem('HerdID', herdID);  
                    
            }
            if(((pSyncUp)||("<%=Master.package%>"!="SheepMartManager"))){
                if (!db) {
                    db = OpenDatabase();
                }
              //SheepMarket User doesn't have herds
                if (herdID == "")
                {
                    db.transaction(function (tx) {
                        tx.executeSql('SELECT COUNT(*) AS c FROM Cows', [], function (tx, r) {
                            //if (r.rows.item(0).c == 0)
                            //{
                            //    sync();
                            //}
                        }, function (tx, e) {
                            //Cows does not exist
                            sync(syncComplete);
                        });
                    });
                }
                <%--else
                {
                    //sql = "SELECT * FROM Cows WHERE InternalHerdID = " + herdID;
                    db.transaction(function (tx) {
                        tx.executeSql("SELECT * FROM Cows WHERE InternalHerdID = " + herdID, [],
                               function (tx, results) {
                            
                                   // results.rows holds the rows returned by the query
                                   document.getElementById("Status").firstChild.data = results.rows.length + " animals loaded";
                                   document.getElementById("Status").style.color = "Black";
                             
                               },
                               function (tx, error) {
                                   if(confirm("Offline database may not yet be initialised, click OK to Synchronise") == true) {
                                   //if(App.confirm("Record", "Offline database may not yet be initialised, click OK to Synchronise", confirmRecord, pType) == true){
                                       sync();
                                   }
                                   else {
                                       alertWithCheck("Error is " + error.message);
                                   }
                               });
                    });
                    if(("<%=Master.RunSync%>" == "1") && (pSyncUp == true)) {
                        sync();
                    }
                }--%>
            }
                <%--if(document.getElementById("<%=MultiHerd.ClientID%>")) {
                    setSelectedIndex(document.getElementById("<%=MultiHerd.ClientID%>"), herdID);
                    if(!isCogent) {
                        addNRRInfo(herdID);
                    }
                    var multiHerdDL = document.getElementById("<%=MultiHerd.ClientID%>");
                    sessionStorage.setItem('HerdName', multiHerdDL.options[multiHerdDL.selectedIndex].text);
                }--%>
                if(isCogent == "1") {
                    // If animalID is set then get it
                    if(pSyncUp == false) {
                        var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');
                        //FillDynamicList("CowNumberList", "AnimalList", herdID,0,defaultAnimalID);
                        //document.getElementById('CowNumberList').style.display = 'block';
                        //showSelect(document.getElementById('CowNumberList'));                
                    }
                }
                
                btRetries = 0;
                if(document.getElementById("MoveDate")) {
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
                 
                    document.forms[0].MoveDate.value = today.getFullYear() + "-" + monthStr + "-" + daystr;
                }
<%--                document.getElementById("BreadHeader").firstChild.data = "FarmWizard Home Page";

                if (<%=Master.IsDevenish%> == 1)
                    document.getElementById("BreadHeader").firstChild.data = "Devenish Home Page";--%>

                if(("<%=Master.IsCallLog%>") && pSyncUp) {
                    document.getElementById("Buttons").style.display = 'none';
                    document.getElementById("BreadHeader").firstChild.data = 'Call Logs';
                    document.getElementById('CallLogList').style.display = 'block';
                    showSelect(document.getElementById('CallLogList'));           
                }
           
          }

          function clickOnID(pFreezeBrand) {
              hideSelect(document.getElementById('StoredReportList'));         
              document.getElementById('StoredReportListTable').style.display = 'none';
              document.getElementById('BackToReportButton').style.display = 'block';
              findRecord(pFreezeBrand,'FreezeBrand');
          }

          function backToReport() 
          {
              showSelect(document.getElementById('StoredReportList'));              
              document.getElementById('StoredReportListTable').style.display = 'block';
              document.getElementById('BackToReportButton').style.display = 'none';
              var theTable = (document.getElementById('DetailsTable'));
              theTable.style.display = 'none';
              document.getElementById("<%=SetButtons.ClientID%>").style.display = 'none';
              document.getElementById('MenuTabs').style.display = 'none';                        
          }


          function addNRRInfo(pHerdID) {
              var sql = "SELECT * FROM DynamicLists where ListName = 'NrrValue' AND HerdID = '" + pHerdID + "'";
              db.transaction(function (transaction) {
                  transaction.executeSql(sql, [],
                  function (transaction, results) {
                      if(results.rows.item(0).Name != "") {
                          // Only set this if it is not blank for farms that dont record events.
                          document.getElementById("Status").style.display = 'block';
                          document.getElementById("Status").firstChild.data = results.rows.item(0).Name;
                      }
                   
                  },
                   function (transaction, error) {
                       //  alertWithCheck("Could not access NRR Value item in database, perhaps you need to synchronise to get latest version?" + error.message);
                   });
              });

          }



          function setSelectedIndex(s, v) {
              for ( var i = 0; i < s.options.length; i++ ) {
                  if ( s.options[i].value == v ) {
                      s.options[i].selected = true;
                      return;
                  }
              }
          }

          function openAnimalPage(freezebrand) {

            findRecord(freezebrand,"FreezeBrand");
              
            document.getElementById("CowNumber").value = "";
            document.getElementById("EventManagement").style.display = 'none';
            var eTable = (document.getElementById('EventsTable'));
            // Clear events table
            
            for (var i = eTable.rows.length - 1; i > 0; i--) {
                eTable.deleteRow(i);
            }
            eTable.style.display = 'none';

            var aTable = (document.getElementById('AllEventsTable'));
            // Clear events table
            for (var i = aTable.rows.length - 1; i > 0; i--) {
                aTable.deleteRow(i);
            }
            aTable.style.display = 'none';
          
          }

          function manHist() {
              var search;
              var tagNo;

              var isCogent = "<%=Master.IsCogent%>";

            
              tagNo = document.getElementById("CowNumber").value;
              if(tagNo == '') {
                  //tagNo = document.getElementById("CowNumberList").value;
                  //if(isCogent == "1") {
                      findRecord(tagNo,"InternalAnimalID");
                  //}
                  //else {
                  //    findRecord(tagNo,"NationalID");
                  //}
              }
              else {
                  findRecord(tagNo,"FreezeBrand");
              }
              document.getElementById("CowNumber").value = "";
              document.getElementById("EventManagement").style.display = 'none';
              var eTable = (document.getElementById('EventsTable'));
              // Clear events table
            
              for (var i = eTable.rows.length - 1; i > 0; i--) {
                  eTable.deleteRow(i);
              }
              eTable.style.display = 'none';

              var aTable = (document.getElementById('AllEventsTable'));
              // Clear events table
              for (var i = aTable.rows.length - 1; i > 0; i--) {
                  aTable.deleteRow(i);
              }
              aTable.style.display = 'none';
          
          }

          function scanPassports(pIsNewBorn) {
              document.getElementById('PassportScanner1').style.display = 'block';
              document.getElementById("Buttons").style.display = 'none';
              if(document.getElementById("BovineButtons")) {
                  document.getElementById("BovineButtons").style.display = 'none';
              }
              //document.getElementById("BreadHeader").firstChild.data = "Passport Scanner";

              var calfRearerIDList = "<%=Master.CalfRearerIDList%>";

            //var multiHerdList = document.getElementById("MultiHerd");
               
            if(pIsNewBorn) {
                if(document.getElementById("DunbiaPanel"))
                {                   
                    document.getElementById("DairyFarmList").style.display = 'block';
                    showSelect(document.getElementById("DairyFarmList"));

                    document.getElementById("CalfRearerList").style.display = 'none';
                    hideSelect(document.getElementById("CalfRearerList"));

                    document.getElementById("CommercialCheckBoxDiv").style.display = 'none';
                    hideSelect(document.getElementById("CommercialCheckBoxDiv"));

                    document.getElementById("CalfSchemeList").style.display = 'block';
                    showSelect(document.getElementById("CalfSchemeList"));

                    // Just put calf rearers on the herd selection list
                    //for(var i=multiHerdList.options.length-1;i>=0;i--)
                    //{ 
                    //    var herdID = multiHerdList.options[i].value;
                    //    if(calfRearerIDList.indexOf(herdID) < 0)
                    //    {
                    //        multiHerdList.remove(i);
                    //    }
                    //}
                }// DunbiaPanel
            }
            else {
                if(document.getElementById("DunbiaPanel"))
                {    
                    document.getElementById("DairyFarmList").style.display = 'none';
                    hideSelect(document.getElementById("DairyFarmList"));

                    document.getElementById("CalfRearerList").style.display = 'block';
                    showSelect(document.getElementById("CalfRearerList"));

                    document.getElementById("CommercialCheckBoxDiv").style.display = 'block';
                    showSelect(document.getElementById("CommercialCheckBoxDiv"));

                    document.getElementById("CalfSchemeList").style.display = 'none';
                    hideSelect(document.getElementById("CalfSchemeList"));
                    // Take Off calf rearers on the herd selection list
                    //for(var i=multiHerdList.options.length-1;i>=0;i--)
                    //{ 
                    //    var herdID = multiHerdList.options[i].value;
                    //    if(calfRearerIDList.indexOf(herdID) >= 0)
                    //    {
                    //        multiHerdList.remove(i);
                    //    }
                    //}
                }
            }
            setHerdID();
        
        }

        function showHideLogs()  {
            document.getElementById("Buttons").style.display = 'none';
            document.getElementById("BreadHeader").firstChild.data = 'Call Logs';
          
            if(document.getElementById('CallLogList').style.display == 'none') 
            {
                document.getElementById('CallLogList').style.display = 'block';
                showSelect(document.getElementById("CallLogList"));
            }
            else {
                document.getElementById('CallLogList').style.display = 'none';
                hideSelect(document.getElementById("CallLogList"));
            }
            var online = navigator.onLine;
            if(online) {
                var d = new Date();
                document.location.href ='iHerd.aspx?Type=CallLog&TimeStamp=' + d.getTime();
            }
              
        }

        function passportSave() {
            var passportsTable = document.getElementById("PassportsTable");
            var animalList = document.forms[0].Passports.value.split("\n");

            var isMoveOff = false;

            var submissionLabel = "";
            
            for(var i= 0;i<animalList.length;i++) {
                // Check if animal was selected for movement
                if(animalList[i].length > 0) {
                    var row = passportsTable.rows[i + 1];
                    var price = row.cells[4].childNodes[0].value;
                    var weight = row.cells[5].childNodes[0].value;
                    if (isNaN(weight)) {
                        App.alert("Error", "Non numeric value entered for weight " + weight);
                        return false;
                    }
                    if (isNaN(price)) {
                        App.alert("Error", "Non numeric value entered for price " + price);
                        return false;
                    }
                    var comment = row.cells[6].childNodes[0].value.replace(',',''); // Take out any comments
                    var sire = row.cells[7].childNodes[0].value;
                    var inGrade = row.cells[8].childNodes[0].value;
                    submissionLabel += animalList[i] + "," + price + "," + weight + "," + comment + "," + sire + "," + inGrade + "\n";
                }
                  
            }
            document.forms[0].ScanPassportLabel.value = submissionLabel;
            var source = "";
            var scheme = "";

            if(document.getElementById("DairyFarmList") && (document.getElementById("DairyFarmList").style.display == 'block')) {
                document.forms[0].SupplierNameLabel.value = getSelectedText("CalfSchemeSupplier");
                document.forms[0].SupplierEnterpriseOrHerdID.value = getSelectedValue("CalfSchemeSupplier");
                source =  getSelectedText("CalfSchemeSupplier");
                scheme = getSelectedText("CalfSchemeList");
            
            }
            else if(document.getElementById("CalfRearerList") && (document.getElementById("CalfRearerList").style.display == 'block')) {
                document.forms[0].SupplierNameLabel.value = getSelectedText("CalfRearers");
                document.forms[0].SupplierEnterpriseOrHerdID.value = getSelectedValue("CalfRearers");
                source =  getSelectedText("CalfRearers");
                scheme = getSelectedText("CalfSchemeList");
                isMoveOff = true;
            }
            else {
                scheme = "This herd";
                source = document.forms[0].PurchasedFromTextBox.value;
            }

            var herdID = sessionStorage.getItem('HerdID');
            document.forms[0].HidTitle.value = (animalList.length - 1) + " Passports Scanned from " + source  
                         + " for " + scheme;

            WriteFormValues("iHerd.aspx?Type=ScanPassports&HerdID=" + herdID + "&IsMoveOff=" + isMoveOff, document.forms[0], document.forms[0].HidTitle.value);
            
            var rowCount = passportsTable.rows.length;
            // Delete the entries in the  passportScreen still sitting there
            for(var k=1; k<rowCount; k++) {
                passportsTable.deleteRow(k);
                rowCount--;
                k--;
            }
            App.alert("Record", (animalList.length - 1) + " passports scanned recorded and will be uploaded on next synch");

            document.getElementById('PassportScanner1').style.display = 'block';
            document.getElementById('PassportScanner2').style.display = 'none';
            document.getElementById('SavePassportButton').style.display = 'none';
            document.getElementById('PassportsTable').style.display = 'none';
           
            document.forms[0].Passports.value = "";
            

        }

        function getSelectedText(elementId) {
            var elt = document.getElementById(elementId);

            if (elt.selectedIndex == -1)
                return null;

            return elt.options[elt.selectedIndex].text;
        }
        
        function getSelectedValue(elementId) {
            var elt = document.getElementById(elementId);

            if (elt.selectedIndex == -1)
                return null;

            return elt.options[elt.selectedIndex].value;
        }


        function passportNext() {
           
            var animalList = document.forms[0].Passports.value.split("\n");
            var passportTable = document.getElementById('PassportsTable');

            var table = document.getElementById("PassportsTable");

            if(document.forms[0].MoveDate.value == "") {
                App.alert("Select", "Please set movement date");
                return;
            }
                
            if(table.rows.length == 1) {
                for(var i= 0;i<animalList.length;i++) {
                    var animal = animalList[i];
                    if(animal.length == 0) {
                        continue;
                    }
                    else if(animal.length < 14) {
                        App.alert("Error", "Passport incorrectly scanned for animal " + (i+1) + " in list ");
                        return;
                    }
                    var nationalID = animal.substring(0,14);
                    var dob = animal.substring(14,22);
                    var sex = animal.substring(22,23);
                    var breed = animal.substring(23);

                    table = document.getElementById("PassportsTable");
                    var rowCount = table.rows.length;
                    var row = table.insertRow(rowCount);

                    var cell1 = row.insertCell(0);
                    cell1.appendChild(document.createTextNode(nationalID));

                    var cell2 = row.insertCell(1);
                    cell2.appendChild(document.createTextNode(dob));

                    var cell3 = row.insertCell(2);
                    cell3.appendChild(document.createTextNode(sex));

                    var cell4 = row.insertCell(3);
                    cell4.appendChild(document.createTextNode(breed));

                    var cell5 = row.insertCell(4);
                    var element1 = document.createElement("input");
                    element1.type = "text";
                    element1.style.width = "50px";
                    cell5.appendChild(element1);

                    var cell6 = row.insertCell(5);
                    var element2 = document.createElement("input");
                    element2.type = "text";
                    element2.style.width = "50px";
                    cell6.appendChild(element2);

                    var cell7 = row.insertCell(6);
                    var element3 = document.createElement("input");
                    element3.type = "text";
                    element3.style.width = "100px";
                    cell7.appendChild(element3);

                    var cell8 = row.insertCell(7);
                    var element4 = document.createElement("input");
                    element4.type = "text";
                    element4.style.width = "100px";
                    cell8.appendChild(element4);
                    var selectBox = document.createElement("select");
                   
                    var cell9 = row.insertCell(8);
                    var optionB = document.createElement("option");
                    optionB.text = "?";
                    optionB.value = "";
                    selectBox.add(optionB, null);
                    var option = document.createElement("option");
                    option.text = "P";
                    option.value = "P";
                    selectBox.add(option, null);    
                    var option2 = document.createElement("option");
                    option2.text = "O";
                    option2.value = "O";
                    selectBox.add(option2, null);
                    var option3 = document.createElement("option");
                    option3.text = "R";
                    option3.value = "R";
                    selectBox.add(option3, null);
                    var option4 = document.createElement("option");
                    option4.text = "U";
                    option4.value = "U";
                    selectBox.add(option4, null);
                    var option5 = document.createElement("option");
                    option5.text = "E";
                    option5.value = "E";
                    selectBox.add(option5, null);
                    cell9.appendChild(selectBox);
    
                }
            }
            document.getElementById('PassportScanner1').style.display = 'none';
            document.getElementById('PassportsTable').style.display = 'block';
            document.getElementById('PassportScanner2').style.display = 'block';
            document.getElementById('SavePassportButton').style.display = 'block';     


        }

        function markMove() {
            var herdID = sessionStorage.getItem('HerdID');
            document.forms[0].MoveHidLabel.value = document.getElementById("NationalID").firstChild.data;
            processForm("Move");
            WriteFormValues("iHerd.aspx?Type=MarkMove&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
            document.forms[0].ExitWeight.value = "";
            App.alert("Mark for move", "Mark for move has been recorded and will be transferred at next synchronisation");   
        }
        
        function retag() {
            var herdID = sessionStorage.getItem('HerdID');
            WriteFormValues("iHerd.aspx?Type=Retag&HerdID=" + herdID, document.forms[0], document.getElementById("NationalID").firstChild.data + " Retag");
            App.alert("Retag", "Retag has been recorded and will be transferred at next synchronisation");   
        }

        function clearAuditData() {
            if(confirm("Are you sure you wish to clear all fields?")) {
            //if(App.confirm("Record", "Are you sure you wish to clear all fields?", confirmRecord, pType)) {
                var myform=document.forms[0];
            
                for (var i=0; i<myform.elements.length; i++){ //loop through all form elements
                    if (myform.elements[i].type=="select-one" || myform.elements[i].type=="select-multiple"){
                        myform.elements[i].selectedIndex = 0;
                    }
                }
            }
        }
        
        function addAuditData() {
            var herdID = sessionStorage.getItem('HerdID');
            document.forms[0].AuditLiveListLabel.value = "";
            // Need a value for each 
            var myform=document.forms[0];
            
            for (var i=0; i<myform.elements.length; i++){ //loop through all form elements
                if (myform.elements[i].type=="select-one" || myform.elements[i].type=="select-multiple"){
                    // We recognise our select boxes as they are purely numeric so ignore the others
                    if(isNaN(myform.elements[i].name)) {
                        continue;
                    }
                    if(myform.elements[i].value == " ") {
                        myform.elements[i].style.backgroundColor="Red";
                        //   App.alert("Missing Value");
                        //    return(false);
                    }
                    else {
                        document.forms[0].AuditLiveListLabel.value += myform.elements[i].name;
                        if(i > 0) {
                            document.forms[0].AuditLiveListLabel.value += ",";
                        }
                    }
                }
            }
            var today = new Date();
            var month = today.getMonth() + 1;
            document.forms[0].AuditDateLabel.value = today.getDate()  + "/" +
                month + "/" + today.getFullYear();
            WriteFormValues("iHerd.aspx?Type=AddDairyWalkThrough&HerdID=" + herdID,document.forms[0], "Dairy Walk Recorded on " + document.forms[0].AuditDateLabel.value );
            App.alert("Dairy Walk", "Dairy walk Through data has been recorded and will be transferred at next synchronisation");   
        }

        function alertWithCheck(pMess) {
            if("<%=Master.IsEID%>" == "1")  {
                App.message(pMess);
            }
            else {
                App.alert("Message", pMess);
            }
        }

        function checkPassport() {
            var box = document.getElementById('Passports').value; 
            var spl = box.split('\n');
            var count = spl.length - 1;
            if(spl[count].length > 31) {
                count = count;
                App.alert('Bad read, last 2 passports must be rescanned');
                document.getElementById('Passports').value = "";
                for(var z=0;z<count;z++) 
                {
                    document.getElementById('Passports').value += spl[z] + '\n';
                }
            }
            document.getElementById('PassportsScanned').firstChild.data = count;
            
        }
        

        function setSingleEID(tag) {
            //var tag = Android.ReadTag();
            var herdID = sessionStorage.getItem('HerdID');
           
            
            if (tag.indexOf("ERROR") < 0) {
                var decimal = tag;
<%--                if("<%=Master.BTDeviceType%>" == "PTS") {
                    // For PTS the tag is in a reverse hex format
                    decimal = convertEIDTag(tag);
                }
                else if("<%=Master.BTDeviceType%>" == "GALLAGHER_HR5") {
                    // Gallagher we need to string off leading digits
                    decimal = tag.substring(2);
                }--%>
                if((decimal.indexOf("NaN") >= 0) || (decimal == '')) {
                    App.message("EID Tag not read please try again");
                    return;
                }
                //Make sure it isnt already set to a different animal
                var sql = "SELECT * FROM Cows where (ElectronicID = '" + decimal + "' AND InternalHerdID = " + herdID + ")";
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                               function (transaction, results) {
                                   
                                   // results.rows holds the rows returned by the query
                                   if (results.rows.length == 1) {
                                       App.message(decimal + " in database already");
                                   }
                                   else {
                                       document.forms[0].SetEIDLabel.value = decimal;
                                       document.forms[0].HidTitle.value = "EID set for " + document.getElementById("NationalID").firstChild.data;
                                       WriteFormValues("iHerd.aspx?Type=SetEID&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
                                       
                                       //update field
                                       document.getElementById("EIDText").firstChild.data = decimal;
                                       var updateSQL = "UPDATE Cows SET ElectronicID = '" + decimal + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";

                                       db.transaction(function (transaction) 
                                       {
                                           transaction.executeSql(updateSQL);
                                       });                                  
                                       App.alert("EID", "Setting EID for " + document.getElementById("NationalID").firstChild.data + " to " + decimal); 
                                   }
                                   
                                   
                               },
                                 function (transaction, error) {
                                     alertWithCheck("Could not read: " + error.message);
                                 });
                });

            }
        }

        function setEID() 
        {
            //  if(!Android) {
            //       alertWithCheck("You may only set electronic tags using the FarmWizard android app available from Google play");
            //      return;
            //  }
            isExpectingSetEID = true;
            App.connectBTDevice('<%=Master.BTReaderDeviceName%>', '<%=Master.BTDeviceReader%>' ,'<%=Master.BTReaderDeviceType%>');          
            //readEIDTags(isExpectingSetEID); 
            
            //readEIDTags(true);      
           
        }




        function readNfcTag(tagValue)
        {
            handleNFCTag(tagValue);
            //handleTag(tagValue, "NFCID");
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


        // New Async
        //function readTag(tagValue)
        //{
            //var tag= tagValue;      
            //tag = Android.ReadTag();

            //btRetries = 0;
            //var herdID = sessionStorage.getItem('HerdID');                             
            //var sql = "SELECT * FROM Cows where (NFCID = '" + tag +  "'OR ElectronicID='"+ tag+ "' AND InternalHerdID = " + herdID + ")";          
                
            db.transaction(function (transaction) 
            {                      
                transaction.executeSql(sql, [],                              
                    function (transaction, results)                           
                    {                              
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) 
                        {                                   
                            //Android.shortVibrate(); 
                            App.shortVibrate();
                            selectAnimal(results.rows.item(0));                                   
                        }                                 
                        else 
                        {                                      
                            //Android.shortVibrate(); 
                            App.shortVibrate();                                   
                            //setTimeout(function () { Android.shortVibrate();  }, 500);     
                            setTimeout(function () { App.shortVibrate();  }, 500);  
                            if(isExpectingSetEID == true)
                            {
                                setSingleEID(tag);
                                isExpectingSetEID = false;
                            }// if
                            else if (isExpectingSetNFC == true)
                            {
                                nfcTag(tag);
                                isExpectingSetNFC = false;
                            }// else if 
                            else
                            {  
                                App.message(tag + " Animal not found in database " + tag);
                            }// else
                        }

                    },
                                                                         
                    function (transaction, error)                                    
                    {
                            alertWithCheck("Could not read: " + error.message);
                    });
            });
        }





        //To display texbox if user click SetNfc Id button
        function setNFCID(){
            if(document.getElementById('NfcTagID').style.display=='none'){
                document.getElementById("NfcTagID").style.display = 'block';
                if(document.getElementById("NfcTagID").firstChild.data!=""){
                    document.getElementById("NfcTagID").firstChild.data="";
                }
            }
            isExpectingSetNFC = true;
        }
         
        function reassignHerd()
        {
            var herdID = sessionStorage.getItem('HerdID');

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
                 
            document.forms[0].ReassignDateLabel.value = today.getFullYear() + "-" + monthStr + "-" + daystr;

            document.forms[0].HidTitle.value = "New Herd Assignment for " + document.getElementById("NationalID").firstChild.data;
            WriteFormValues("iHerd.aspx?Type=ReassignHerd&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
            
            App.alert("Record", "Herd move has been recorded and will be transferred at next synchronisation");
        }

        function addToBCM()
        {        
            var e = document.getElementById("drpBreedingStage");
            var strBreedStage = e.options[e.selectedIndex].value;

            var freezebrand = "";

            var fb1 = document.getElementById("txtFreezeBrandBreed");
            
            if(fb1.style.display == 'none')
            {
                freezebrand = "-1";
            }
            else
            {
                if (fb1 != null)
                    freezebrand = fb1.value;
            }

            if (freezebrand != "" && strBreedStage != "0")
            {
                document.forms[0].HidTitle.value = "Adding Animal to BCM: " + document.getElementById("NationalID").firstChild.data;

                //freezebrand has changed.
                if (freezebrand != "-1")        
                {
                    WriteFormValues("iHerd.aspx?Type=ChangeFB&FB=" + freezebrand, document.forms[0], "Animal management tag changed");
                
                    //update field
                    document.getElementById("FB").firstChild.data = freezebrand;
                }

                WriteFormValues("iHerd.aspx?Type=AddToBCM&BreedingStage=" + strBreedStage, document.forms[0], document.forms[0].HidTitle.value);
            
        
                //update local database
                var updateSQL1 = "UPDATE Cows SET FreezeBrand = '" + freezebrand + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";
                var updateSQL2 = "UPDATE DynamicLists SET IsBreeding = 1 where Value = " + document.forms[0].SelectedAnimalID.value + "";
                                           
                db.transaction(function (transaction) {
                    if (freezebrand != -1)        
                    {
                        transaction.executeSql(updateSQL1);
                    }
                    transaction.executeSql(updateSQL2);
                });

                App.alert("Record", "Add to BCM has been recorded and will be transferred at next synchronisation");

                $( "#BCMSetupPanel" ).toggle( "slow", function() {
                    // Animation complete.
                });
                $( "#BCMArea" ).hide();
            }
            else
            {
                if (freezebrand == "" && strBreedStage == "0")
                {
                    App.alert("Select", "Please set a freezebrand and Breeding Stage to add this animal to the BCM");
                }
                else
                {
                    if (freezebrand == "")
                        App.alert("Select", "Please set a freezebrand to add this animal to the BCM");
                    if (strBreedStage == "0")
                        App.alert("Select", "Please select a Breeding Stage");
                }
            }
        }



        function handleNFCTag(nfcTagNumber)
        {               
            var decimal = nfcTagNumber;

            if(decimal.indexOf("NaN") >= 0) {
                return;
            }
            btRetries = 0;
                              
            var herdID = sessionStorage.getItem('HerdID');

            if (isExpectingSetNFC)
            {
                var sql = "SELECT * FROM Cows where (NFCID = '" + decimal + "'" + ")";
            
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                            function (transaction, results) {
                                // results.rows holds the rows returned by the query
                                if (results.rows.length == 1) {
                                    App.message(decimal + "Animal already in Database");
                                }
                                else {
                                    document.getElementById("NfcTagID").firstChild.data=decimal;
                                    document.forms[0].NFCID.value=document.getElementById("NfcTagID").firstChild.data;
                                    //AsyncAndroid.ScanNFCID(false);
                                    document.forms[0].HidTitle.value = "NFC ID set for " + document.getElementById("NfcTagID").firstChild.data;
                                    WriteFormValues("iHerd.aspx?Type=SetNFCID&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
                                    //update local DB
                                    var updateSQL = "UPDATE Cows SET NFCID = '" + decimal + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";
                                    transaction.executeSql(updateSQL);
                                    
                                    document.getElementById("<%=setNfcId.ClientID%>").style.display = "none";
                                    App.alert("NFC", "Nfc ID has been Added and will be transferred at next synchronisation");
                                }
                            },
                            function (transaction, error) {
                                alertWithCheck("Could not read: " + error.message);
                            });
                });

                isExpectingSetNFC = false;
            }
            else
            {
                var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + herdID + ")";
            
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                            function (transaction, results) {
                                // results.rows holds the rows returned by the query
                                if (results.rows.length == 1) {
                                    selectAnimal(results.rows.item(0));
                                  
                                }
                                else {
                                  
                                    App.message(decimal + " Animal not found in database " + decimal);
                                    initPage(false);
                                }
                            },
                            function (transaction, error) {
                                alertWithCheck("Could not read: " + error.message);
                            });
                });
                // App.alert("test "+ pSyncUp + isNfcTagAdded);
                //setTimeout(function () { nfcTag(tag); }, 6000);
            
            }
        }





        function setDraft() {
            var herdID = sessionStorage.getItem('HerdID');
            document.forms[0].HidTitle.value = "Draft set for " + document.getElementById("NationalID").firstChild.data;
            WriteFormValues("iHerd.aspx?Type=SetDraft&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
            alertWithCheck("Animal will be drafted if presented within 24 hours");
        }

        function addStockTake(pInternalAnimalID) {
            var herdID = sessionStorage.getItem('HerdID');
            var today = new Date();
            var month = today.getMonth() + 1;
            
            document.forms[0].AuditDateLabel.value = today.getDate()  + "/" + month + "/" + today.getFullYear();
            
            document.forms[0].HidTitle.value = "Stock take recorded for " + document.getElementById("NationalID").firstChild.data;
            WriteFormValues("iHerd.aspx?Type=AddStockTake&HerdID=" + herdID, document.forms[0], document.forms[0].HidTitle.value);
        }
        


        function selectAnimal(pRow) {
            var isCogent = <%=Master.IsCogent%>;
                
            document.forms[0].SelectedAnimalID.value = pRow.InternalAnimalID;
            if(StockTakeMode == true) {
                addStockTake(pRow.InternalAnimalID);
            }
            document.getElementById("Status").style.display = 'block';
            document.getElementById("Status").firstChild.data = "Viewing details for " + pRow.NationalID;
            document.getElementById("Buttons").style.display = 'none';
            var theTable = (document.getElementById('DetailsTable'));
            theTable.style.display = 'block';
                

            document.getElementById("<%=SetButtons.ClientID%>").style.display = 'block';
            document.getElementById('MenuTabs').style.display = 'block';
            
            var mvTable = (document.getElementById('MoveTable'));
            if(mvTable) {
                mvTable.style.display = 'block';
            }

            var herdMovePanel = (document.getElementById('reassignArea'));
            if(herdMovePanel) {
                var herdMovePanel1 = (document.getElementById("<%=HerdAssignPanel.ClientID%>"));
                if(herdMovePanel1.style.display == 'none') {

                    var ddlherd=document.getElementById("<%=ReassignHerdList.ClientID%>");

                    for (i=0;i<ddlherd.length;  i++) {
                        if (ddlherd.options[i].value==sessionStorage.getItem('HerdID')) {
                            ddlherd.remove(i);
                        }
                    }

                    herdMovePanel.style.display = 'inline';
                }
            
            }

            var breedCMPanel = (document.getElementById('BCMArea'));
            if(breedCMPanel) {
                var breedCMPanel1 = (document.getElementById("<%=BCMSetupPanel.ClientID%>"));
                if(breedCMPanel1.style.display == 'none') {

                    //if female
                    if (pRow.SexText == "Female")
                    {
                        //not a sheep
                        if ("<%=Master.package%>" != "SheepManager")
                        {
                            //if not in BCM already
                            var bcmSql = "SELECT IsBreeding FROM DynamicLists where ListName = 'AnimalList' and Value = " + pRow.InternalAnimalID + "";
            
                            db.transaction(function (transaction) {
                                transaction.executeSql(bcmSql, [], function (transaction, results) {
                                    var len = results.rows.length, i;
                                    if (len == 1)
                                    {
                                        //not in BCM already
                                        if (results.rows.item(0).IsBreeding == 0) 
                                        {
                                    
                                            //breedCMPanel.style.display = 'inline';
                                            breedCMPanel.style.display = 'block';

                                            //only show the FB option if it isn't already set
                                            var fb = document.getElementById("FB").firstChild.data;
                                            if (fb == "")
                                                brdFB.style.display = 'block';
                                                //brdFB.style.display = 'inline';
                                            else
                                                brdFB.style.display = 'none';

                                        }                
                                    }
                                
	
                                }, null);
                            });
                        }
                    }

                }
            
            }

            var colourChange = "";
            var textColour = "Black";
            if(pRow.CurrentStatus == "DoNotBreed") {
                colourChange =  "Black";
                textColour = "White";
            }
            else if(pRow.CurrentStatus == "InVWP") {
                colourChange =  "Orange";
            }
            else if((pRow.CurrentStatus == "OutVWP") || (pRow.CurrentStatus == "PastServiceDeadline") || (pRow.CurrentStatus == "PastAlertDeadline")) {
                colourChange =  "Red";
            }
            else if(pRow.CurrentStatus == "Served") {
                colourChange =  "White";
            }
            else if(pRow.CurrentStatus == "Heat") {
                colourChange =  "Lightgreen";
            }
            else if(pRow.CurrentStatus == "Pregnant") {
                colourChange =  "Lightblue";
            }
            else if(pRow.CurrentStatus == "PregnantMultiple") {
                colourChange =  "Pink";
            }
            else if(pRow.CurrentStatus == "DriedOff") {
                colourChange =  "Yellow";
            }
            else if(pRow.CurrentStatus == "Unknown") {//Heifer?
                colourChange =  "Lightgrey";
            }
                
            if(colourChange != "") {
                var rows = theTable.getElementsByTagName("tr"); 
                for(i = 0; i < rows.length; i++){
                    var cells = rows[i].getElementsByTagName("td"); 
                    for(var z = 0; z < cells.length; z++){
                        cells[z].style.backgroundColor = colourChange;
                    }
                    //   rows[i].style.backgroundColor = colourChange;
                    rows[i].style.color = textColour;
                    if(i == 0)
                        rows[i].style.color = "Black";
                }
                theTable.style.backgroundColor = colourChange;         
                //document.getElementById("Status").style.color = colourChange;
            }
            
            document.getElementById("Status").style.display = 'block';
            document.getElementById("Status").firstChild.data += " " +  pRow.CurrentStatus;

            setID(pRow.InternalAnimalID);
            document.getElementById("NationalID").firstChild.data = pRow.NationalID;
            document.getElementById("FB").firstChild.data = pRow.FreezeBrand;
            document.getElementById("edit_FB").style.visibility = "visible";
            document.getElementById("Breed").firstChild.data = pRow.BreedText;
            document.getElementById("Sex").firstChild.data = pRow.SexText;
            document.getElementById("Group").firstChild.data = pRow.Group;
            document.getElementById("Dam").firstChild.data = pRow.Dam;
            document.getElementById("Sire").firstChild.data = pRow.Sire;
            document.getElementById("DateOfBirth").firstChild.data = pRow.DateOfBirth;
            document.getElementById("JoinDate").firstChild.data = pRow.JoinDate;
            var today = new Date();
                
            if(pRow.DateOfBirth != pRow.JoinDate) {
                var joined = new Date(pRow.JoinDate.substring(6),
                   pRow.JoinDate.substring(3, 5) - 1, pRow.JoinDate.substring(0, 2));
                var days = (today.getTime() - joined.getTime()) / 86400000;
                days = Math.round(days * Math.pow(10, 0)) / Math.pow(10, 0);
                document.getElementById("JoinDate").firstChild.data += " (" + days + " dys)";
            }

            var dob = new Date(pRow.DateOfBirth.substring(6),
                   pRow.DateOfBirth.substring(3, 5) - 1, pRow.DateOfBirth.substring(0, 2));
            var mths = (today.getTime() - dob.getTime()) / 2635200000;
            mths = Math.round(mths * Math.pow(10, 0)) / Math.pow(10, 0);
            document.getElementById("DateOfBirth").firstChild.data += " (" + mths + " mths)";
                

            
            // Clear these
            document.getElementById("TreatmentText").innerHTML = "";
            document.getElementById("LactationStatusText").innerHTML = "";
            document.getElementById("EIDText").firstChild.data = "";

            if(pRow.ElectronicID) {
                document.getElementById("EIDText").firstChild.data = pRow.ElectronicID;
            }
           
            if(pRow.NFCID!=""){
                document.getElementById("NfcTagID").style.display='block';
                document.getElementById("NfcTagID").firstChild.data=pRow.NFCID;
                if(document.getElementById("<%=setNfcId.ClientID%>"))
                    document.getElementById("<%=setNfcId.ClientID%>").style.display='none';
                
            }
            else{
            document.getElementById("NfcTagID").style.display='block';
            document.getElementById("NfcTagID").firstChild.data="";
            }

            if(pRow.PurchasedFrom) {
                document.getElementById("JoinDate").firstChild.data += " " + pRow.PurchasedFrom;
            }
            if((pRow.BoughtPrice) && (pRow.BoughtPrice != "")) {
                document.getElementById("JoinDate").firstChild.data += " £" + pRow.BoughtPrice;
            }

            //
            document.getElementById("lblReproHist").style.display = "none";
            if(pRow.BreedHistoryText!="")
            {
                document.getElementById("ReproHistoryLabel").innerHTML = "Repro History";
                document.getElementById("BreedHistoryText").innerHTML = pRow.BreedHistoryText;
                
                document.getElementById("lblReproHist").style.display = "block";
            }
            



            document.getElementById("lblTreatment").style.display = "none";
            if((pRow.TreatmentText) && (isCogent == "0")) {
                document.getElementById("TreatmentText").innerHTML = pRow.TreatmentText;
                document.getElementById("TreatmentLabel").innerHTML = "Treatments";
                //
                document.getElementById("lblTreatment").style.display = "block";
                //
            }

            
            if(pRow.CurrentLactation) {
                document.getElementById("LactationStatusText").innerHTML = pRow.CurrentLactation;
            }
            document.getElementById("NoteText").innerHTML = pRow.NotesString;
               
            document.getElementById("lblMilkRecords").style.display = "none";
            if(pRow.MilkRecordsText != "") {
                document.getElementById("MilkRecordsText").innerHTML = pRow.MilkRecordsText;
                document.getElementById("MilkRecordsLabel").innerHTML = "Milk Records";
                document.getElementById("lblMilkRecords").style.display = "block";
            }
            else {
                document.getElementById("MilkRecordsText").innerHTML = "";
                document.getElementById("MilkRecordsLabel").innerHTML = "";
            }
            
            document.getElementById("lblWeightRecords").style.display = "none";
            
            if(pRow.WeightHistoryText) {
                document.getElementById("WeightHistoryText").innerHTML = pRow.WeightHistoryText;            
                document.getElementById("WeightHistoryText").innerHTML += "(DLWG=" + pRow.DLWG + ")";
                document.getElementById("WeightHistoryLabel").innerHTML = "Weight History";
                document.getElementById("lblWeightRecords").style.display = "block";
            }
            else {
                document.getElementById("WeightHistoryText").innerHTML = "";
            }

            //
            if (document.getElementById("<%=SetButtons.ClientID%>"))
            {
                if(document.getElementById("<%=setNfcId.ClientID%>")) 
                {
                    if(!App.androidApp()) 
                    {
                        document.getElementById("<%=setNfcId.ClientID%>").style.display = 'none';
                    }
                }
            }

            if ("<%=Master.IsMultiHerd%>" == "false") {
                document.getElementById("reassignHerdSection").style.display = 'none';
            }// if
            //
            
        }

        function findRecord(pValue,pLookUpField) {
            
            if (db) {
                db.transaction(function (transaction) 
                {
                    var herdID = sessionStorage.getItem('HerdID');
                    var sql = "SELECT * FROM Cows where " + pLookUpField + " = '" + pValue + "' and InternalHerdID = " + herdID;
                    if (pLookUpField == "NationalID") {
                        // NationalID allows for partial match
                        sql =  "SELECT * FROM Cows where NationalID like '%" + pValue + "%' and InternalHerdID = " + herdID;
                    }
             
                    transaction.executeSql(sql, [],
                       function (transaction, results) {
                           // results.rows holds the rows returned by the query
                           if (results.rows.length > 1) {
                               alertWithCheck(results.rows.length + " animals found please select one from list");
                               //var select=document.getElementById('CowNumberList');
                               select.options.length = 0;
                               for (z = 0; z < results.rows.length; z++) {
                                   var row = results.rows.item(z);
                                   select.options[select.options.length] = new Option(row.NationalID, row.NationalID);
                               }
                               //select.style.display = 'block';
                               //select.classList.remove("hide");
                               showSelect(select);
                           }
                           else if (results.rows.length == 1) {
                               selectAnimal(results.rows.item(0));
                           }
                           else 
                           {
                               if (pLookUpField == "NationalID") {
                                   alertWithCheck("No records found");
                               }
                               else {
                                   findRecord(pValue,"NationalID");
                               }
                           }
                       },
                       function (transaction, error) {
                           alertWithCheck("Could not read: " + error.message);
                       });
                });
            }
            else {
                alertWithCheck('Cant open database');
            }          
        }

        

        function errorHandler(transaction, error) {
            alertWithCheck('Oops. Error was ' + error.message + ' (Code ' + error.code + ')');
            //transaction.executeSql('INSERT INTO errors (code, message) VALUES (?, ?);',
            //             [error.code, error.message]);
            return false;
        }


        function sync(callback) {

            $(".progress").fadeIn("slow", null);

            //if("<%=Master.IsEID%>" == "1") {
                App.message("Synchronisation in process");
            //}
            //else {
            //    if (confirm("Are you sure you wish to synchronise, only confirm if you are currently online") == false) {
            //        //if(App.confirm("Record", "Are you sure you wish to synchronise, only confirm if you are currently online", confirmRecord, pType) == false) {
            //        return;
            //    }
            //}
            
            document.getElementById("Buttons").style.display = 'none';
            var mvTable = (document.getElementById('MoveTable'));
            if(mvTable) {
                mvTable.style.display = 'none';
            }
            
            ResetForms();
           
            UploadForms();

            LoadMobileDatabase(callback);
            
        }

        function viewRecentEvents() {
            var herdID = sessionStorage.getItem('HerdID');
        
            var sql = "SELECT * FROM DynamicLists where ListName = 'RecentEventList' AND HerdID = '" + herdID + "'";
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                function (transaction, results) {
                    document.getElementById("Status").style.display = 'block';
                    document.getElementById("Status").firstChild.data = results.rows.length + " events loaded";
                    document.getElementById("Buttons").style.display = 'none';
                    
                    // disabling the search feature within the navigation menu
                    var searchInput = document.getElementById("CowNumber");
                    searchInput.disabled = true;
                    searchInput.placeholder = "";
                    disableSearchPlaceholder = true;
                    //
                    
                    var aTable = document.getElementById('AllEventsTable');
                    aTable.style.display = 'block';
                    for (var i = aTable.rows.length - 1; i > 0; i--) {
                        aTable.deleteRow(i);
                    }

                    for (z = 0; z < results.rows.length; z++) {
                        var row = results.rows.item(z);
                        var rowCount = aTable.rows.length;
                        var trow = aTable.insertRow(1);
                            
                        var cell1 = trow.insertCell(0);
                        cell1.appendChild(document.createTextNode(row.Name));

                    }
                },
                 function (transaction, error) {
                     alertWithCheck("Could not access events list items in database, perhaps you need to synchronise to get latest version?" + error.message);
                 });
            });
            return;
        
        }

        function setID(pInternalAnimalID) {
            sessionStorage.removeItem('InternalAnimalID');
            sessionStorage.setItem('InternalAnimalID', pInternalAnimalID);
        }

        function dairyStoredReportList() {

            var herdID =  sessionStorage.getItem('HerdID');
            //document.getElementById('CowNumberList').style.display = 'none';
            //hideSelect(document.getElementById('CowNumberList'));
            //document.getElementById('CowNumberList').className += " hide";
              
            document.getElementById("Status").style.display = 'block';
            document.getElementById("Status").firstChild.data = "Select a list from menu to display";
            document.getElementById("Buttons").style.display = 'none';
            showSelect(document.getElementById("StoredReportList"));

            var listBox = document.getElementById("StoredReportList");
            listBox.options.length = 0;
            
            var sel = document.createElement("option");
            listBox.options.add(sel);
            sel.text = "Select Report";
            sel.value = "";
          
            var sql = "SELECT * FROM DynamicLists where ListName = 'StoredReportList' AND HerdID = '" + herdID + "'";
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                function (transaction, results) {
                    

                    // Only add one name on each table and ignore the others
                    for (z = 0; z < results.rows.length; z++) {
                     
                        var row = results.rows.item(z);
                        var count = listBox.options.length;
                        var isDuplicate = false;

                        for (var k = 0; k < count; k++) {
                            if (listBox.options[k].text == row.Name) {
                                isDuplicate = true;
                            }
                        }
                        if(!isDuplicate) {
                            var opt = document.createElement("option");
                            listBox.options.add(opt);
                            opt.text = row.Name;
                            opt.value = row.Name;
                        }
                    }
                    
                    showSelect(document.getElementById("StoredReportList"));
                },
                 function (transaction, error) {
                     alertWithCheck("Could not access report " + listName + " in database, perhaps you need to synchronise to get latest version?" + error.message);
                 });
            });
            return;
             
        }
        

        function dairyActionList() {
            
            document.getElementById("Status").style.display = 'block';
            document.getElementById("Status").firstChild.data = "7 day action list since synchronisation date";
            document.getElementById("Buttons").style.display = 'none';
            document.getElementById("ActionListTable").style.display = 'block';
            
            loadTable("readyForServiceList","ReadyForService");
            loadTable("repeatHeatList","RepeatHeat");
            loadTable("noHeatSixtyList","NoHeatSixty");
            loadTable("noHeatFortyTwoList","NoHeatFortyTwo");
            loadTable("moreServicesList","MoreServices");
            loadTable("missedHeatList","MissedHeat");
            loadTable("scannableList","Scannable");
            loadTable("negativePdList","NegativePD");
            loadTable("dueDryList","DueDry");
            loadTable("dueCalfList","DueCalf");
            loadTable("fertTreatList","FertTreat");       
        }

        function loadStoredReportList() {
            var herdID = sessionStorage.getItem('HerdID');
            

            var listName = document.getElementById('StoredReportList').value;

            if(listName == "") {
                return;
            }
        
            var sql = "SELECT * FROM DynamicLists where ListName = 'StoredReportList' and Name = '" + listName + "' AND HerdID = '" + herdID + "'";
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                function (transaction, results) {
                    var aTable = document.getElementById('StoredReportListTable');
                    aTable.style.display = 'block';
                    for (var i = aTable.rows.length - 1; i >= 0; i--) {
                        aTable.deleteRow(i);
                    }
                     
                    var actionColArray = null;
                    var fbClick = null;

                    for (z = 0; z < results.rows.length; z++) {
                        var row = results.rows.item(z);
                        var rowCount = aTable.rows.length;
                        var trow = aTable.insertRow(rowCount);
                        var colArray = row.Value.split(",");
                         
                        if(z==0) {
                            // Check if Freeze brand is first column to create a clickable column
                            if(colArray[0].indexOf("FreezeBrand") >= 0)
                            {
                                fbClick = true;
                            }
                            // Check if we want one or more action columns added
                            if(colArray[colArray.length-1].indexOf("Redirect=") >= 0)
                            {
                                actionColArray = colArray[colArray.length-1].split(";");
                            }
                            // Need to set the visual header for column names which are in the brackets
                            for(var y=0;y<colArray.length-1;y++) {
                                var startIndex = colArray[y].indexOf("(");
                                if(startIndex >= 0) {
                                    var endIndex = colArray[y].indexOf(")");
                                    colArray[y] = colArray[y].substring(startIndex+1,endIndex);
                                    
                                }
                            }

                        }
                                
                                
                         
                        for(var y=colArray.length-1;y>=0;y--) {

                            // For first column we check if this is a Freeze brand and if it is allow the user to click
                            // on it to pull up cow card
                            if((y == 0) && fbClick) {
                                var cell1 = trow.insertCell(0);
                                var link = document.createElement("a");
                                link.setAttribute("href", "#");
                                link.setAttribute("onclick", "clickOnID("+ colArray[y] + ");");
                                var linkText = document.createTextNode(colArray[y]);
                                link.appendChild(linkText);

                                // Add the link to the previously created TableCell.
                                cell1.appendChild(link);
                            }
                               
                            else if((y==colArray.length-1) &&  (actionColArray != null)) 
                            {
                                // Add Action columns
                                for(var p=0;p<actionColArray.length;p++) {
                                    var cell1 = trow.insertCell(0);
                                    var offset = 0;
                                    if(p == 0) {
                                        // first one has the redirect string
                                        offset = 9;
                                    }
                                    var redirectString =  actionColArray[p].substring(offset);
                                    var redirectName = redirectString;
                                    var startIndex = redirectString.indexOf("(");
                                    if(startIndex >= 0) {
                                        var endIndex = redirectString.indexOf(")");
                                        redirectName = redirectString.substring(startIndex+1,endIndex);
                                        redirectString = redirectString.substring(0,startIndex);
                                    }
                                   

                                    var link = document.createElement("a");
                                    link.setAttribute("href", redirectString);
                                    link.setAttribute("onclick", "setID('"+ colArray[y] + "');" );
                                    // For IE only, you can simply set the innerText of the node.
                                    // The below code, however, should work on all browsers.
                                    var linkText = document.createTextNode(redirectName);
                                    link.appendChild(linkText);

                                    // Add the link to the previously created TableCell.
                                    cell1.appendChild(link);
                                }
                            }
                            else {
                                var cell1 = trow.insertCell(0);
                                cell1.appendChild(document.createTextNode(colArray[y]));
                            }
                        }

                    }

                    
                },
                 function (transaction, error) {
                     alertWithCheck("Could not access report " + listName + " in database, perhaps you need to synchronise to get latest version?" + error.message);
                 });
            });
            return;
        
        }


        function loadTable(pListName,pSpanName) {
            var herdID = sessionStorage.getItem('HerdID');
            var ddl = document.getElementById(pSpanName);
        
            var sql = "SELECT * FROM DynamicLists where ListName = '" + pListName + "' AND HerdID = '" + herdID + "'";
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                function (transaction, results) {
                    //document.getElementById(pSpanName).firstChild.data = "";
                     
                    var selo1 = document.createElement("option");
                    if (results.rows.length > 0)
                        selo1.text = "View List";
                    else 
                        selo1.text = "";
                    selo1.value = "";           
                    ddl.options.add(selo1);

                    for (z = 0; z < results.rows.length; z++) {
                        var row = results.rows.item(z);
          
                        var selopt = document.createElement("option");
                        selopt.text = row.Name;
                        selopt.value = row.Name;
                        ddl.options.add(selopt);
                        
                        //document.getElementById(pSpanName).firstChild.data += row.Name + " ";
                    }
                    showSelect(ddl);
                },
                 function (transaction, error) {
                     alertWithCheck("Could not access " + pSpanName + " in database, perhaps you need to synchronise to get latest version?" + error.message);
                 });
            });
            return;
        
        }


        function showFieldRecords() {
            document.getElementById("Buttons").style.display = 'none';
            document.getElementById("FieldRecordsDisplay").style.display = 'block';

            // disabling the search feature within the navigation menu
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            searchInput.placeholder = "";
            disableSearchPlaceholder = true;
            //
        }



        function startButton(event) {
            if (recognizing) {
                recognition.stop();
                return;
            }
            recognition.lang = 'en-GB';
            recognition.start();
        }


     
function readOneTag() 
{
    var tag="";
            
    tag = Android.ReadTag();
           
    if((tag.indexOf("SR82") >= 0) || (tag == "") || (tag.indexOf("socket closed") >= 0) || (tag.indexOf("NaN") >= 0) || (tag.indexOf("cancelled") >= 0) || (tag.indexOf("oftware caused") >= 0))  {
        // This is if system is being shut down or app moved off
        App.message("Reading stopped");
        return;
    }
            
    else if (tag.indexOf("ERROR") < 0) {
        var decimal = tag;
        if("<%=Master.BTReaderDeviceType%>" == "PTS") {
                        // For PTS the tag is in a reverse hex format
                        //decimal = convertEIDTag(tag);
                    }
                    else if("<%=Master.BTReaderDeviceType%>" == "GALLAGHER_HR5") {
                        // Gallagher we need to string off leading digits
                        decimal = tag.substring(2);
                    }
                    if(decimal.indexOf("NaN") >= 0) {
                        return;
                    }
                    btRetries = 0;

                    var herdID = sessionStorage.getItem('HerdID');
                                
                    var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + herdID + ")";
            
                    db.transaction(function (transaction) {
                        transaction.executeSql(sql, [],
                               function (transaction, results) {
                                   // results.rows holds the rows returned by the query
                                   if (results.rows.length == 1) {
                                       Android.shortVibrate();
                                       selectAnimal(results.rows.item(0));
                                       
                                   }
                                   else {
                                       Android.shortVibrate();
                                       setTimeout(function () { Android.shortVibrate();  }, 500);
                                       App.message(decimal + " Animal not found in database " + decimal);
                                   }
                               },
                                     function (transaction, error) {
                                         alertWithCheck("Could not read: " + error.message);
                                     });
                    });
                    setTimeout(function () { readOneTag(); }, 500);
                }
                else {
                App.message(tag);
                    return;     
                }    
}



        function eventMgmt() {
            document.getElementById("Buttons").style.display = 'none';
            document.getElementById("EventManagement").style.display = 'block';
            //document.getElementById("BreadHeader").firstChild.data = 'Recorded Events Management';

            var eTable = (document.getElementById('EventsTable'));
            eTable.style.display = 'block';

            for (var i = eTable.rows.length - 1; i > 0; i--) {
                eTable.deleteRow(i);
            }

            // disabling the search feature within the navigation menu
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            searchInput.placeholder = "";
            disableSearchPlaceholder = true;
            //

            var sql = "SELECT * FROM Forms";
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                         function (transaction, results) {
                             var successful = 0;
                             var failed = 0;
                             var processing = 0;
                             var fresh = 0;
                             for (z = 0; z < results.rows.length; z++) {
                                 var row = results.rows.item(z);
                                 if (row.Status == 0) {
                                     fresh += 1;
                                 }
                                 else if (row.Status == 1) {
                                     successful += 1;
                                 }
                                 else if (row.Status == 2) {
                                     processing += 1;
                                 }
                                 else if (row.Status == 3) {
                                     failed += 1;
                                 }
                             }

                             // results.rows holds the rows returned by the query
                             
                             document.getElementById("Status").style.display = 'block';
                             document.getElementById("Status").innerHTML = "Event list: <br>Pending-" + fresh + "<br>Successful-" + successful + " <br>Processing-" + processing + " <br>Failed-" + failed;
                         },
                         function (transaction, error) {
                             alertWithCheck("Could not read: " + error.message);
                         });
            });
              
        }
       


        function processForm(pEventType) {
            if((pEventType == "Note") || (pEventType == "Move")) {
                var today = new Date();
                var month = today.getMonth() + 1;
                document.forms[0].NoteDateLabel.value = today.getDate()  + "/" +
                    month + "/" + today.getFullYear();
                if(pEventType == "Note") {
                    document.forms[0].HidTitle.value = "Note added for " + 			document.forms[0].MoveHidLabel.value;
                }
                else {
                    var weight = "";
                    if(document.forms[0].ExitWeight != null) {
                        weight = document.forms[0].ExitWeight.value;
                    }
                    //document.forms[0].HidTitle.value = document.forms[0].MoveHidLabel.value + " move " + weight + " G" + document.forms[0].MoveGroup.value ;
                    var groupWeighSelected = document.getElementById("<%=MoveGroup.ClientID%>");
                    document.forms[0].HidTitle.value = document.forms[0].MoveHidLabel.value + " move " + weight + " G" + groupWeighSelected.options[groupWeighSelected.selectedIndex].text;      	
                }
                return true;
            }
        }// processForm
        
    </script>

        <%--<input type="hidden" name="HidTitle" />
        <input type="hidden" name="AuditDateLabel" />
        <input type="hidden" name="NoteDateLabel" />
        <input type="hidden" name="MoveHidLabel" />
        <input type="hidden" name="SetEIDLabel" />
        <input type="hidden" name="AuditLiveListLabel" />
        <input type="hidden" name="ScanPassportLabel" />
        <input type="hidden" name="SupplierNameLabel" />
        <input type="hidden" name="SupplierEnterpriseOrHerdID" />
        <input type="hidden" name="ReassignDateLabel" />
        <input type="hidden" name="NFCID" />
        <input type="hidden" name="SelectedAnimalID" />
        <input type="hidden" name="DairyHerd" value="<%= Master.InDairyHerd %>" />

        --%>

            <div id="container">
                <div id="header">
                    <asp:Panel ID="CogentLogoPanel" Visible="false" runat="server">
                        <img title="Cogent Logo" alt="CLogo" width="360px" src="/images/CogentPrecisionSmall.jpg" align="middle">
                    </asp:Panel>

                    
                    <asp:Panel ID="DairyWalkThroughEntryPanel" Visible="false" runat="server">                      
                        <div class="row" style="padding-left: 20px; padding-right: 20px;">
                            <div class="col-xs-6">
                                <%--<a href="iHerd.aspx" class="btn btn-primary waves-effect waves-light">Back</a>--%>
                                <h3>
                                    <asp:Label ID="WalkThrough" runat="server"></asp:Label>
                                </h3>
                                <br />
                                Enter a score for each entry below. Click on title to show/hide that group.
                                <!--<div style="margin: 15px;">-->
                                <n0:AuditEntry TableClass="selectHolder" ID="AuditEntryList" runat="server"></n0:AuditEntry>
                                <!--</div>-->
                                <br></br>
                                <br></br>
                                <div align="center">
                                    <a href="#" class="btn btn-primary waves-effect waves-light" onclick="addAuditData();">Record Walk</a>
                                </div>
                                <div align="center">
                                    <br></br>
                                    <br></br>
                                    <a href="#" class="btn btn-primary waves-effect waves-light" onclick="clearAuditData();">Clear All Fields</a>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                </div>
            </div>
            <asp:Panel ID="MainPanel" runat="server">
                <%--<div class="breadheader">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12">
                                <nav>
                                    <div class="nav-wrapper">
                                        <form>
                                            <div class="input-field">
                                                <input id="search" type="search" required class="input-sm" name="CowNumber" id="CowNumber" placeholder="Search Animal Numbers">
                                                <label for="search"><!--<i class="material-icons">search</i>--></label>
                                                <a href="#" data-activates="mobile-sidenav" class="button-collapse"><i class="material-icons">menu</i></a>
                                                <a href="iherd.aspx?IsEID=<%=Master.IsEID%>" data-activates="mobile-sidenav" class="button-collapse"><i class="material-icons home">home</i></a>
                                                <i class="material-icons">close</i>
                                                <i class="material-icons mic">keyboard_voice</i>
                                            </div>
                                        </form>
                                    </div>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>--%>
                <%--<asp:Panel ID="MultiHerdPanel" Visible="false" runat="server">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="input-field">
                            <asp:Label ID="MultiHerdLabel" runat="server"></asp:Label><n0:MOBILEDROPDOWNLIST id="MultiHerd" class="" onchange="setHerdID();" runat="server" EnableViewState="False" DataTextField="FriendlyName" DataValueField="InternalHerdID"></n0:MOBILEDROPDOWNLIST><n0:MOBILEDROPDOWNLIST id="MultiHerdCopy" runat="server" class="hide" EnableViewState="False" DataTextField="FriendlyName" DataValueField="InternalHerdID"></n0:MOBILEDROPDOWNLIST>
                            </div>
                        </div>
                    </div>
                </asp:Panel>--%>
                <!-- /row -->



                <div class="container-fluid search-animal-numbers">
                    <div class="row">
                        <div class="col-xs-12">
                            <%--<asp:Panel ID="SearchPanel" runat="server">
                                <div id="animal-search-input">
                                    <div class="input-group input-field">

                                        <input type="text" class=" input-sm" name="CowNumber" id="CowNumber" placeholder="Search Animal Numbers" />
                                        <span class="input-group-btn">
                                            <a href="#" id="search" class="btn btn-info btn-sm" onclick="manHist();">Find</a>
                                        </span>

                                    </div>
                                </div>
                            </asp:Panel>--%>

                            <%--<div class="input-field">
                                <select name="CowNumberList" class="" onchange="manHist();" id="CowNumberList"></select>
                            </div>--%>
                            <span id="Status" style="text-align:center;">_</span>
                           
                            <table id="DetailsTable" class="table" align="center">
                                <tbody>

                                    <tr>
                                        <th class="text-right">Ear Tag:</th>
                                        <th>
                                            <span id="NationalID">_</span></th>
                                    </tr>
                                    <tr id="trManTag">
                                        <th class="text-right">Management Tag:</th>
                                        <th>
                                            <span id="FB">_</span>
                                            <span onclick="editFB();" style="font-size: 80%; color: blue; margin-left: 10px; visibility: hidden" id="edit_FB">(edit)</span></th>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Date Of Birth:</th>
                                        <td><span id="DateOfBirth">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Entry Date:</th>
                                        <td><span id="JoinDate">_</span></td>
                                    </tr>

                                    <tr>
                                        <th class="text-right">Breed:</th>
                                        <td><span id="Breed">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Sex:</th>
                                        <td><span id="Sex">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Group:</th>
                                        <td><span id="Group">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Dam:</th>
                                        <td><span id="Dam">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Sire:</th>
                                        <td><span id="Sire">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Lact Status: </th>
                                        <td><span id="LactationStatusText">_</span></td>
                                    </tr>

                                    <tr>
                                        <th class="text-right">EID</th>
                                        <td><span id="EIDText">_</span></td>
                                    </tr>
                                    <tr>
                                        <th class="text-right">Notes</th>
                                        <td><span id="NoteText">_</span></td>
                                    </tr>
                                    <tr>
                                        <th  class="text-right">NFC ID:</th>
                                        <td><span id="NfcTagID">_</span></td>
                                    </tr>
                                </tbody>
                            </table>

                            <div id="MenuTabs">
                                <%--<ul class="nav nav-tabs">
                                    <li class="active"><a href="#pane1" data-toggle="tab">Repro History</a></li>
                                    <li><a href="#pane2" data-toggle="tab"><span id="TreatmentLabel"></span></a></li>
                                    <li><a href="#pane3" data-toggle="tab"><span id="MilkRecordsLabel"></span></a></li>
                                    <li><a href="#pane4" data-toggle="tab"><span id="WeightHistoryLabel"></span></a></li>
                                </ul>

                                <div class="tab-content">
                                    <div id="pane1" class="tab-pane active">
                                        <p><span id="BreedHistoryText"></span></p>
                                    </div>
                                    <div id="pane2" class="tab-pane">
                                        <p><span id="TreatmentText"></span></p>
                                    </div>
                                    <div id="pane3" class="tab-pane">
                                        <p><span id="MilkRecordsText"></span></p>
                                    </div>
                                    <div id="pane4" class="tab-pane">
                                        <p><span id="WeightHistoryText"></span></p>
                                    </div>
                                </div>
                                <!-- /.tab-content -->--%>


                                <div class="row" >
                                    <div id="">
                                        <ul class="tabs">
                                            <li id="lblReproHist" class="tab"><a class="active" href="#test1"><span id="ReproHistoryLabel"></span></a></li>
                                            <li id="lblTreatment" class="tab"><a href="#test2"><span id="TreatmentLabel"></span></a></li>
                                            <li id="lblMilkRecords" class="tab"><a href="#test3"><span id="MilkRecordsLabel"></span></a></li>
                                            <li id="lblWeightRecords" class="tab"><a href="#test4"><span id="WeightHistoryLabel"></span></a></li>
                                        </ul>
                                    </div>
                                    <div id="test1" class="col s12"><p><span id="BreedHistoryText"></span></p></div>
                                    <div id="test2" class="col s12"><p><span id="TreatmentText"></span></p></div>
                                    <div id="test3" class="col s12"><p><span id="MilkRecordsText"></span></p></div>
                                    <div id="test4" class="col s12"><p><span id="WeightHistoryText"></span></p></div>
                                </div>

                            </div>
                            
                            <br />

                            <asp:Panel ID="MovePanel" Visible="false" runat="server">
                                <div id="MoveTable">
                                    <div id="MarkMoveSection" class="row col-xs-12">
                                        <div class="row">
                                            <div class="form-group col-xs-6">
                                                <a id="MarkMoveArea" class="btn btn-primary waves-effect waves-light" >Mark for a Move</a>
                                            </div>
                                        </div>
                                        <div id="MarkMovePanel" runat="server" class="col-xs-12" style="display: none; margin-bottom: 3em;">
                                            <div class="row">
                                                <div class="form-group col-xs-6">
                                                    <b>Exit Weight: </b>
                                                    <input type="text" class=" input-sm" name="ExitWeight" id="ExitWeight" />
                                                </div>
                                                <div class="form-group col-xs-6">
                                                    <b>Move Grp: </b>
                                                    <n0:MOBILEDROPDOWNLIST class="" id="MoveGroup" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-xs-6">
                                                        <a id="MarkMoveBtn" href="#" class="btn btn-primary waves-effect waves-light light-green" onclick="markMove();" margin-bottom: 3em;">Mark Move</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <%--<div class="form-group col-xs-6">
                                            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="markMove(); margin-bottom: 3em;">Mark Move</a>
                                        </div>--%>
                                        <div class="form-group col-xs-6">
                                            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="retag();">Order replacement tag</a>
                                        </div>
                                    </div>
                                    <div id="reassignHerdSection" class="row col-xs-12" >
                                        <div class="row">
                                            <div class="form-group col-xs-6">
                                                <a id="reassignArea" class="btn btn-primary waves-effect waves-light " style="display: none;">Reassign to a new Herd</a>
                                            </div>
                                        </div>
                                        <br />
                                        <div id="HerdAssignPanel" runat="server" class="col-xs-12" style="display: none; margin-bottom: 3em;">
                                            <div>
                                                <div class="row">
                                                    <div class="form-group col-xs-6">
                                                    <p>Reassign animals to herd (tick box if linked holding)</p>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-xs-6">
                                                    <asp:CheckBox ID="LinkedHoldingCheckBox" runat="server" Text="Linked Holding"></asp:CheckBox>
                                                </div>
                                                </div>
                                                <div>
                                                    <div class="row">
                                                        <div class="form-group col-xs-6">
                                                            <b>Herd:</b>
                                                            <n0:MobileDropDownList ID="ReassignHerdList" runat="server" EnableViewState="False" DataTextField="FriendlyName" DataValueField="InternalHerdID" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="form-group col-xs-6">
                                                        <a class="btn btn-primary waves-effect waves-light light-green" id="ReassignButton" style="margin-bottom: 3em;" onclick="reassignHerd();">Reassign Herd</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-xs-6">
                                            <a id="BCMArea" class="btn btn-primary waves-effect waves-light " style="display: none; margin-bottom: 3em;">Add to Breed Cycle Manager</a>
                                        </div>
                                        <br />
                                        <div id="BCMSetupPanel" runat="server" class="col-xs-12" style="display: none;">
                                            <div>
                                                <div class="row">
                                                    <div class="form-group col-xs-6">
                                                        <p>Add this animal to the Breed Cycle Manager</p>
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="row">
                                                        <div class="form-group col-xs-6">
                                                            <p>
                                                                <b>Breeding Stage:</b>
                                                                <n0:MOBILEDROPDOWNLIST id="drpBreedingStage" runat="server" EnableViewState="False" DataTextField="FriendlyName" DataValueField="InternalHerdID" >
                                                            <asp:ListItem Value="0">Unknown</asp:ListItem>
                                                            <asp:ListItem Value="1">Heifer</asp:ListItem>
                                                            <asp:ListItem Value="2">1st Calver</asp:ListItem>
                                                            <asp:ListItem Value="3">2nd Calver</asp:ListItem>
                                                            <asp:ListItem Value="4">3rd Calver</asp:ListItem>
                                                            <asp:ListItem Value="5">4th Calver</asp:ListItem>
                                                            <asp:ListItem Value="6">5th Calver</asp:ListItem>
                                                            <asp:ListItem Value="7">6th Calver</asp:ListItem>
                                                            <asp:ListItem Value="8">7th Calver</asp:ListItem>
                                                            <asp:ListItem Value="9">8th Calver</asp:ListItem>
                                                            <asp:ListItem Value="10">9th Calver</asp:ListItem>
                                                            <asp:ListItem Value="11">10th Calver</asp:ListItem>
                                                            <asp:ListItem Value="12">11th Calver</asp:ListItem>
                                                            <asp:ListItem Value="13">12th Calver</asp:ListItem>
                                                            <asp:ListItem Value="14">13th Calver</asp:ListItem>
                                                            <asp:ListItem Value="15">14th Calver</asp:ListItem>
                                                        </n0:MOBILEDROPDOWNLIST>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="brdFB" class="row">
                                                    <div class="form-group col-xs-6">
                                                        <p>
                                                            <b>Freeze Brand: </b>
                                                            <input type="text" name="FreezeBrand" id="txtFreezeBrandBreed">
                                                        </p>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="form-group col-xs-6">
                                                        <a class="btn btn-primary waves-effect waves-light light-green" id="AddToBCMButton" onclick="addToBCM();">Add to BCM</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>                                                                                                               
                            </asp:Panel>

                            <!-- /.tabbable -->

                            <%--<ul class="dashlist">--%>
                            <div id="BackToReportButton">
                                <li><a href="#" onclick="backToReport();">Back to Report</a></li>
                            </div>

                            <div id="Buttons">
                                <asp:Panel ID="SheepMarketPanel" Visible="false" runat="server">
                                    <div class="panel-footer">
                                            <a href="SheepMarketLot.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Add Sheep to Lot</a>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="DashboardPanel" Visible="false" runat="server">
                                    <div class="panel-footer">
                                        <a href="LamenessHomePage.aspx?IsEID=<%=Master.IsEID%>" type="button" id="Dashboard" class="btn btn-info btn-lg btn-block">Lameness Dashboard</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="FlockMobility.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Flock Mobility Score</a>
                                    </div>
                                        <div class="panel-footer">
                                            <a href="Lameness.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Individual Lameness</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="BatchLameness.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Batch Lameness Control</a>
                                        </div>
                                </asp:Panel>
                                <%--<asp:Panel ID="EIDFindPanel" Visible="true" runat="server">

                                    <div class="panel-footer">

                                        <a href="#" type="button" id="HistoryEID" onclick="readEIDTags(false);" class="btn btn-info btn-lg btn-block">View History by EID Tags</a>

                                    </div>

                                </asp:Panel>--%>

                                <asp:Panel ID="synchronise" runat="server">

                                    <div class="panel-footer">

                                        <a type="button" href="#" onclick="sync(syncComplete);" class="btn btn-info btn-lg btn-block">Synchronise</a>

                                    </div>

                                </asp:Panel>


                                <asp:Panel ID="SystemPanel" runat="server">

                                    <%--<div class="panel panel-default">--%>
                                    <%--<div class="panel-heading" role="tab" id="headingOne">
                <%--<h4 class="panel-title">
                 <%--<button type="button" class ="btn btn-info btn-md btn-block" padding="10px 30px" data-toggle="collapse" data-parent="#accordion" data-target="#data1">View System Options</button>--%>
                                    <%--</h4>--%>

                                    <%-- </div>--%>
                                    <div id="data1">

                                        <asp:Panel ID="ScanPassportPanel" Visible="false" runat="server">
                                            Click link below to carry out action. You must select a herd before scanning passports.
                                            <div class="panel-footer">
                                                <a href="#" type="button" onclick="scanPassports(true)" class="btn btn-info btn-lg btn-block">Scan new born calf passports</a>
                                            </div>
                                            <div class="panel-footer">
                                                <a href="#" type="button" onclick="scanPassports(false)" class="btn btn-info btn-lg btn-block">Scan reared calf passports</a>
                                            </div>
                                            <div class="panel-footer">
                                                <a href="#" type="button" onclick="showHideLogs()" class="btn btn-info btn-lg btn-block">View Call Logs</a>
                                            </div>
                                        </asp:Panel>
                                        <div class="panel-footer">
                                            <a href="#" onclick="eventMgmt();" type="button" class="btn btn-info btn-lg btn-block">Events Management</a>
                                        </div>
                                    </div>


                                </asp:Panel>

                                <asp:Panel ID="SheepPanel" Visible="false" runat="server">
                                  
                                    <div class="panel-footer">
                                        <a href="AddPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Add New</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="Birth.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Lambing</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="FosterPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Foster</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="TreatmentPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Treatment</a>
                                    </div>
                                    <%--<asp:Panel ID="EIDPanelApp" Visible="false" runat="server">--%>
                                        <div class="panel-footer">
                                            <a href="MarkForMove.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Mark for Move</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="StockTake.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Stock Take</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="WeighPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Weigh</a>
                                        </div>
                                        <div class="panel-footer">
                                                <a href="GroupWeigh.aspx?" type="button" class="btn btn-info btn-lg btn-block">Group Weigh</a>
                                        </div>
                                    <%--</asp:Panel>--%>
                                    <div class="panel-footer">
                                        <a href="DeathPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Death</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="SalePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Sale</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="ConditionScorePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Condition Score</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="ReTag.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">ReTag</a>
                                    </div>

                                    <div class="panel-footer">
                                        <a href="TakePicturePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Take Picture</a>
                                    </div>

                                </asp:Panel>

                                <asp:Panel ID="BreedingPanel" runat="server">
                                    <%--<div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingTwo">--%>
                                    <%-- <h4 class="panel-title">
                <button type="button" class ="btn btn-info btn-md btn-block" data-toggle="collapse" data-parent="#accordion" data-target="#data2">View Breeding Options</button>
               </h4>
                   </div>--%>
                                    <div class="panel-footer">
                                        <a href="HeatPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Heat</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="AIService.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">AI Service</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="BullServicePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Bull Service</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="ScanningPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Scanning</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="DryOffPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Dry Off</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="CalvingPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Calving</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="StillBornAbortDestroyedCalfPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Still Born/Abort/Destroyed Calf</a>
                                    </div>
                                </asp:Panel>


                                <asp:Panel ID="BovinePanel" runat="server">
                                    <%--<div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingThree">
                <h4 class="panel-title">
                <button type="button" class ="btn btn-info btn-md btn-block" data-toggle="collapse" data-parent="#accordion" data-target="#data3">View Bovine Options</button>
                    </h4>
                    </div>
                    </div>--%>
                                    <div id="BovineButtons">
                                        <div class="panel-footer">
                                            <a href="#" type="button" onclick="scanPassports(false)" class="btn btn-info btn-lg btn-block">Scan passports into herd</a>
                                        </div>
                                        <asp:Panel ID="BovineTreatmentPanel" runat="server">
                                            <div class="panel-footer" >
                                                <a href="TreatmentPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Treatment</a>
                                            </div>
                                        </asp:Panel>
                                        <div class="panel-footer">
                                            <a href="DeathPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Death</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="SalePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Sale</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="MobilityScorePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Mobility Score</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="ConditionScorePage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Condition Score</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="WeighPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Weigh</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="StockTake.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Stock Take</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="MarkForMove.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Mark for Move</a>
                                        </div>
                                        <div class="panel-footer">
                                            <a href="#" onclick="viewRecentEvents()" type="button" class="btn btn-info btn-lg btn-block">All Recorded Events</a>
                                        </div>
                                        <%--<%--<asp:Panel ID="WeighPanel" Visible="false" runat="server">
                                            <div class="panel-footer">
                                                <a href="SingleWeigh.aspx?" type="button" class="btn btn-info btn-lg btn-block">Single Weigh</a>
                                            </div>--%>
                                            <div class="panel-footer">
                                                <a href="GroupWeigh.aspx?" type="button" class="btn btn-info btn-lg btn-block">Group Weigh</a>
                                            </div>
                                        <%--</asp:Panel>--%>
                                    </div>
                                </asp:Panel>

                                <%--</div>
                    </div>--%>
                                <asp:Panel ID="VetActionPanel" Visible="false" runat="server">
                                    <%-- <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingfive">
                                    <h4 class="panel-title">
                                    <button type="button" class ="btn btn-info btn-md btn-block" data-toggle="collapse" data-parent="#accordion" data-target="#tech">View Technician Options</button>
                                        </h4>
                                        </div>
                                        </div>--%>
                                    <%--<div id="tech" class="collapse">--%>
                                    <div class="panel-footer">
                                        <a href="VetAction.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Vet Action</a>
                                    </div>
                                    <div class="panel-footer">
                                        <a href="DoNotBreed.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Do Not Breed</a>
                                    </div>
                                    <%--</div>--%>
                                </asp:Panel>
                                
                                <asp:Panel ID="DairyWalkThroughPanel" Visible="false" runat="server">
                                    <div class="panel-footer">
                                        <a href="iHerd.aspx?Type=DairyWalkThrough" type="button" class="btn btn-info btn-lg btn-block">Record Walk Through</a>
                                    </div>
                                </asp:Panel>

                                <asp:Panel ID="FieldRecordsPanel" Visible="false" runat="server">
                                    <div class="panel-footer">
                                        <a type="button" href="#" class="btn btn-info btn-lg btn-block" onclick="showFieldRecords()">Field Records</a>
                                    </div>
                                </asp:Panel>

                                <asp:Panel ID="ChangeHerd" Visible="false" runat="server">
                                    <div class="panel-footer">
                                        <a href="ChangeHerdPage.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Change Herd</a>
                                    </div>
                                </asp:Panel>

                                <asp:Panel ID="NotePanel" runat="server">
                                    <div class="panel-footer">
                                        <a href="AddNote.aspx?IsEID=<%=Master.IsEID%>" type="button" class="btn btn-info btn-lg btn-block">Add Note</a>
                                    </div>
                                </asp:Panel>

                                <asp:Panel ID="ReportPanel" Visible="false" runat="server">

                                    <%--<button type="button" class ="btn btn-info btn-md btn-block" data-toggle="collapse" data-parent="#accordion" data-target="#report">View Reports</button>--%>


                                    <asp:Panel ID="DairyReportPanel" Visible="false" runat="server">

                                        <div class="panel-footer">
                                            <a href="#" onclick="dairyActionList()" type="button" class="btn btn-info btn-lg btn-block">Dairy Action List</a>
                                        </div>
                                    </asp:Panel>
                                    <asp:Panel ID="DairyStoredReportPanel" Visible="false" runat="server">
                                        <div class="panel-footer">
                                            <a href="#" onclick="dairyStoredReportList()" type="button" class="btn btn-info btn-lg btn-block">Dairy Report List</a>
                                        </div>

                                    </asp:Panel>


                                </asp:Panel>
                            </div>
                            
                            <div class="panel-body">

                                <div id="CallLogList">
                                    Notes to Add:<asp:TextBox ID="AddNotesTextBox" runat="server" Width="600px"></asp:TextBox>
                                    <asp:DataGrid class="table table-blue" runat="server" ID="LogCallGrid" DataKeyField="CallLogID" AllowPaging="False" OnItemCommand="ButtonPushed" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:ButtonColumn ButtonType="PushButton" CommandName="Confirm" Text="Confirm">
                                                <ItemStyle Font-Bold="True" Font-Size="Larger"></ItemStyle>
                                            </asp:ButtonColumn>
                                            <asp:BoundColumn DataField="CreationDate" HeaderText="Date Logged"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="StatusText" HeaderText="Status"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="LoggedByText" HeaderText="Logged By"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="SupplierText" HeaderText="Supplier"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="SchemeText" HeaderText="Scheme"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="NoAvailable" HeaderText="No Available"></asp:BoundColumn>
                                            <asp:BoundColumn DataField="Notes" HeaderText="Notes"></asp:BoundColumn>
                                            <asp:ButtonColumn ButtonType="PushButton" CommandName="Reject" Text="Reject">
                                                <ItemStyle Font-Bold="True" Font-Size="Larger"></ItemStyle>
                                            </asp:ButtonColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </div>
                            </div>
                        </div>

                        <div id="PassportScanner1" align="center">

                            <asp:Panel ID="DunbiaPanel" Visible="false" runat="server">
                                Select Supplier, Scheme, click on Box Below and Start Scanning Passports then click Next</br>
                                <div id="DairyFarmList">
                                    <h4>Dairy Farm Supplier</h4>

                                    <n0:MOBILEDROPDOWNLIST class="" id="CalfSchemeSupplier" DataValueField="EnterpriseID" DataTextField="CompanyName" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST></br>
                                </div>
                                <div id="CalfRearerList">
                                    <h4>Calf Rearer</h4>
                                    <n0:MOBILEDROPDOWNLIST class="" id="CalfRearers" DataValueField="InternalHerdID" DataTextField="CompanyName" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST></br>
                                </div>
                                <h4>Scheme</h4>
                                <div id="CommercialCheckBoxDiv">
                                    <asp:CheckBox ID="CommercialCheckBox" runat="server" Text="Move to Commercial" Font-Bold="True"></asp:CheckBox></div>

                                <n0:MOBILEDROPDOWNLIST class="" id="CalfSchemeList" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
                                </br>
                            </asp:Panel>
                            <asp:Panel ID="PurchasedFromPanel" Visible="false" runat="server">
                                Purchased From:<asp:TextBox ID="PurchasedFromTextBox" class="" runat="server" Width="600px"></asp:TextBox>
                            </asp:Panel>
                            <h4>Movement Date:</h4>
                            <input type="date" id="MoveDate" name="MoveDate" class="">

                            <span id="PassportsScanned">_</span>
                            <br />
                            <asp:TextBox ID="Passports" runat="server" Width="600px" Height="200px" TextMode="MultiLine"></asp:TextBox>
                            </br></br>
                            <asp:CheckBox ID="UpdateBCMS" runat="server" Text="Update BCMS" Font-Bold="True"></asp:CheckBox>

                            <a href="#" id="NextPassportButton" class="btn btn-success btn-lg" onclick="passportNext();">Next</a>
                        </div>

                        <div id="PassportScanner2">
                             Enter Weight/Price/Sire/Grade and Click Save
                            <div class="row">
                                <div class="form-group col-xs-6">
                                    <table id="PassportsTable" class="table table-blue">
                                        <tbody>
                                            <tr>
                                                <th>ID</th>
                                                <th>DOB</th>
                                                <th>Sex</th>
                                                <th>Breed</th>
                                                <th>Price</th>
                                                <th>Wght</th>
                                                <th>Comment</th>
                                                <th>Sire</th>
                                                <th>InGrade</th>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            </br></br>
                            <a href="#" id="SavePassportButton" class="btn btn-success btn-lg" onclick="passportSave();">Save</a>
                        </div>

                        <div id="FieldRecordsDisplay">
                            <div class="panel-body">
                                <div class="panel-footer">

                                    <%--<a href="iFieldEvent.aspx?Type=PastureWalk" type="button" class="btn btn-info btn-lg btn-block">Pasture Walk</a>--%>
                                    <a href="FieldEventPage.aspx?Type=PastureWalk" type="button" class="btn btn-info btn-lg btn-block">Pasture Walk</a>
                                </div>
                                <div class="panel-footer">
                                    <%--<a href="iFieldEvent.aspx?Type=FarmOrganicManure" type="button" class="btn btn-info btn-lg btn-block">Record Manure</a>--%>
                                    <a href="FieldEventPage.aspx?Type=FarmOrganicManure" type="button" class="btn btn-info btn-lg btn-block">Record Manure</a>
                                </div>
                                <div class="panel-footer">
                                    <%--<a href="iFieldEvent.aspx?Type=Fertiliser" type="button" class="btn btn-info btn-lg btn-block">Record Fertiliser</a>--%>
                                    <a href="FieldEventPage.aspx?Type=Fertiliser" type="button" class="btn btn-info btn-lg btn-block">Record Fertiliser</a>
                                </div>
                                <div class="panel-footer">
                                    <%--<a href="iFieldEvent.aspx?Type=Spray" type="button" class="btn btn-info btn-lg btn-block">Record Spray</a>--%>
                                    <a href="FieldEventPage.aspx?Type=Spray" type="button" class="btn btn-info btn-lg btn-block">Record Spray</a>
                                </div>
                                <div class="panel-footer">
                                    <%--<a href="iFieldEvent.aspx?Type=Lime" type="button" class="btn btn-info btn-lg btn-block">Record Lime</a>--%>
                                    <a href="FieldEventPage.aspx?Type=Lime" type="button" class="btn btn-info btn-lg btn-block">Record Lime</a>
                                </div>
                            </div>
                        </div>

                        <div id="EventManagement">
                            <div class="panel-body">

                                <div class="panel-footer">

                                    <a href="#" onclick="ListEvents(0);" class="btn btn-info btn-lg btn-block" type="button">View Pending Events</a>
                                </div>
                                <div class="panel-footer">
                                    <a href="#" onclick="ListEvents(3);" class="btn btn-info btn-lg btn-block" type="button">View Failed Events</a>
                                </div>
                                <div class="panel-footer">
                                    <a href="#" onclick="ListEvents(1);" class="btn btn-info btn-lg btn-block" type="button">View Successful Events</a>
                                </div>
                                <div class="panel-footer">
                                    <a href="#" onclick="DelAllEvents();" class="btn btn-info btn-lg btn-block" type="button">Clear All Events</a>
                                </div>


                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group col-xs-6">
                                <table id="EventsTable" class="table table-blue">
                                    <tbody>
                                        <tr>
                                            <th>Date Time</th>
                                            <th>Title</th>
                                            <th>Response</th>
                                            <th>Click to Delete</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group col-xs-6">
                                <table id="AllEventsTable" class="table table-blue">
                                    <tbody>
                                        <tr>
                                            <th>Event Details</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="input-field">
                            <select id="StoredReportList" onchange="loadStoredReportList()" class="selectHolder"></select>
                        </div>

                        <div class="row">
                            <div class="form-group col-xs-6">
                                <table id="StoredReportListTable" class="table table-blue">
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <%--<br />
                        <br />--%>
                        <div id="SetButtons" runat="server">
                            <br/>
                            <%--<br/>
                            <br/>--%>
                            <div class="row">
                                <div class="form-group col-xs-6">
                                    <a id="setEid" class="btn btn-success btn-lg" href="#" onclick="setEID();" runat="server">Set EID</a> 
                                    <a id="setNfcId" class="btn btn-success btn-lg" href="#" onclick="setNFCID();" runat="server">Set NFC ID</a> 
                                    <a id="setDraft" class="btn btn-success btn-lg" href="#" onclick="setDraft();" runat="server">Draft</a> 
                                </div>
                            </div>
                            <%--<br/>--%>

                        </div>

                        <table id="ActionListTable" class="table table-blue">
                            <tbody>

                                <tr>
                                    <td valign="top">
                                        <b>Ready for Service:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="ReadyForService"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>Possible Repeat Heats:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="RepeatHeat"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>No Heat 60+ days:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="NoHeatSixty"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>No Heat 42-60 days:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="NoHeatFortyTwo"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>3+ Services & not preg:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="MoreServices"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>Missed Heat:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="MissedHeat"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>Ready For Scan:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="Scannable"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>Negative PD:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="NegativePD"></select></td>
                                </tr>

                                <tr>
                                    <td valign="top">
                                        <b>Due Dry:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="DueDry"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>Due Calf:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="DueCalf"></select></td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>Due fertility treat:</b>
                                    </td>
                                    <td valign="top">
                                        <select id="FertTreat"></select></td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>

            </asp:Panel>



    <script type="text/javascript">
        $( "#reassignArea" ).click(function() {
            $( "#<%=HerdAssignPanel.ClientID%>" ).toggle( "slow", function() {
                // Animation complete.
            });
            $( "#reassignArea" ).hide();
        });
        $( "#ReassignButton" ).click(function() {
            $( "#<%=HerdAssignPanel.ClientID%>" ).toggle( "slow", function() {
                // Animation complete.
            });
            $( "#reassignArea" ).show();
        });


        $( "#BCMArea" ).click(function() {
            $( "#<%=BCMSetupPanel.ClientID%>" ).toggle( "slow", function() {
                // Animation complete.
            });
            //$( "#BCMArea" ).hide();
        });
        $( "#AddToBCMButton" ).click(function() {
            $( "#<%=MarkMovePanel.ClientID%>" ).toggle( "slow", function() {
                // Animation complete.
            });
            $( "#BCMArea" ).show();
        });


        $( "#MarkMoveArea" ).click(function() {
            $( "#<%=MarkMovePanel.ClientID%>" ).toggle( "slow", function() {
                // Animation complete.
            });
            //$( "#MarkMoveArea" ).hide();
        });
        $( "#MarkMoveBtn" ).click(function() {
            $( "#<%=MarkMovePanel.ClientID%>" ).toggle( "slow", function() {
                // Animation complete.
            });
            $( "#MarkMoveArea" ).show();
        });
        


        function editFB(){
            var add = false;
            //display fb in text box and allow edit
            //var newFB = window.prompt("Please enter new Management Tag:", document.getElementById("FB").firstChild.data);
            App.textInput("Please enter", "Please enter new Management Tag: ", "newFBCheck" , add, false);
                     
            //var isDairy = document.forms[0].DairyHerd.value;
            ////if it has changed, update the screen
            //if (newFB != null)
            //{
            //    if (newFB != document.getElementById("FB").firstChild.data)
            //    {
            //        //check the database for duplicate:
            //        var sql = "SELECT * FROM Cows where FreezeBrand = '" + newFB + "' AND InternalAnimalID != " + document.forms[0].SelectedAnimalID.value + "";
            //        db.transaction(function (transaction) {
            //            transaction.executeSql(sql, [],
            //                       function (transaction, results) {
                                   
            //                           // results.rows holds the rows returned by the query
            //                           if (results.rows.length >= 1) {
            //                               //if non dairy show confirm... 
            //                               if (isDairy != "true"){
            //                                   //if (confirm("Freeze Brand is already in use - would you like to continue?")) {
            //                                   if(App.confirm("Record", "Freeze Brand is already in use - would you like to continue?", freezeBrandCheck, newFB)) {
            //                                       add = true;
            //                                   }
            //                               }
            //                               else
            //                               {
            //                                   //otherwise say no.
            //                                   App.alert("Error", "Error: Freeze Brand is already in use")
            //                                   add = false;
            //                               }
            //                           }
            //                           else {
            //                               //no other freezebrands set the same
            //                               add = true;
            //                           }

                                       
            //                           if (add == true)
            //                           {
            //                               WriteFormValues("iHerd.aspx?Type=ChangeFB&FB=" + newFB, document.forms[0], "Animal management tag changed");
                                        
            //                               //update field
            //                               document.getElementById("FB").firstChild.data = newFB;

            //                               //update local DB
            //                               var updateSQL = "UPDATE Cows SET FreezeBrand = '" + newFB + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";
            //                               transaction.executeSql(updateSQL);

            //                               App.alert("Record", "New Management Tag has been recorded and will be transferred at next synchronisation");   
            //                           }

            //                       },
            //                         function (transaction, error) {
            //                             alertWithCheck("Could not read: " + error.message);
            //                         });
            //        });

            //    }
            //}

        }


        function newFBCheck(pId, pValue){
            if(pValue !== false){
                var addFB = pId;
                var isDairy = document.forms[0].DairyHerd.value;
                var newFB = pValue;

                //if it has changed, update the screen
                if (newFB != null)
                {
                    if (newFB != document.getElementById("FB").firstChild.data)
                    {
                        //check the database for duplicate:
                        var sql = "SELECT * FROM Cows where FreezeBrand = '" + newFB + "' AND InternalAnimalID != " + document.forms[0].SelectedAnimalID.value + "";
                        db.transaction(function (transaction) {
                            transaction.executeSql(sql, [],
                                       function (transaction, results) {
                                   
                                           // allowing the Management Tag to be set to blank/empty
                                           if(newFB == "")
                                           {
                                               App.confirm("Record", "Management Tag is blank - would you like to continue?", freezeBrandCheck, newFB);
                                               //addFB = true;
                                           }// if
                                           else
                                           {
                                               // results.rows holds the rows returned by the query
                                               if (results.rows.length >= 1) {
                                                   //if non dairy show confirm... 
                                                   if (isDairy != "true"){
                                                       //if (confirm("Freeze Brand is already in use - would you like to continue?")) {
                                                       App.confirm("Record", "Management Tag is already in use - would you like to continue?", freezeBrandCheck, newFB);
                                                       //if(App.confirm("Record", "Management Tag is already in use - would you like to continue?", freezeBrandCheck, newFB)) 
                                                       //{
                                                       //    addFB = true;
                                                       //}
                                                   }
                                                   else
                                                   {
                                                       //otherwise say no.
                                                       App.alert("Error", "Error: Management Tag is already in use")
                                                       addFB = false;
                                                   }
                                               }
                                               else {
                                                   //no other freezebrands set the same
                                                   addFB = true;
                                               }
                                           }// else
                                       


                                           if (addFB == true)
                                           {
                                               WriteFormValues("iHerd.aspx?Type=ChangeFB&FB=" + newFB, document.forms[0], "Animal management tag changed");
                                        
                                               //update field
                                               document.getElementById("FB").firstChild.data = newFB;

                                               //update local DB
                                               var updateSQL = "UPDATE Cows SET FreezeBrand = '" + newFB + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";
                                               transaction.executeSql(updateSQL);

                                               App.alert("Record", "New Management Tag has been recorded and will be transferred at next synchronisation");   
                                           }

                                       },
                                         function (transaction, error) {
                                             alertWithCheck("Could not read: " + error.message);
                                         });
                        });

                    }
                }
            }// != false
        }// newFBCheck


        function freezeBrandCheck(pId, pValue) {
            
            var newFB = pId;

            if (pValue == false) {
            return;
            }
            else {
                var sql = "UPDATE Cows SET FreezeBrand = '" + newFB + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";
                            
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],                              
                        function (transaction, results) {
                            WriteFormValues("iHerd.aspx?Type=ChangeFB&FB=" + newFB, document.forms[0], "Animal management tag changed");
                                        
                            //update field
                            document.getElementById("FB").firstChild.data = newFB;

                            ////update local DB
                            //var updateSQL = "UPDATE Cows SET FreezeBrand = '" + newFB + "' where InternalAnimalID = " + document.forms[0].SelectedAnimalID.value + "";
                            transaction.executeSql(sql);

                            App.alert("Record", "New Management Tag has been recorded and will be transferred at next synchronisation");   

                        },
                     
                        function (transaction, error) {
                            alertWithCheck("Could not read: " + error.message);
                        });
                });
            }// else
        }// freezeBrandCheck


        

        function animalResults(pId, pValue) {
            if (pValue == false) {
                return;
            }
            else {
                var value = pValue;
                if (isNaN(value)) {
                    App.textInput("Please enter", "Please enter Days Pregnant (must be numeric):", "animalResults", pId, true)
                }
                else {
                    App.alert("TEST", "test test test " + value);
                }// else
            }// else
        }// animalResults


    </script>

    <style>
        .btn-lg{
            font-weight: 700;
            font-size: 20px;
            height: inherit !important;
        }
    </style>
   

</asp:Content>

