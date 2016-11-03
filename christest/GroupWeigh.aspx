<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="GroupWeigh.aspx.cs" Inherits="HybridAppWeb.GroupWeigh" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="row">
            <div class="form-group col-xs-6">
                <strong>
                    <asp:Label ID="groupWeighLbl" runat="server" Font-Bold="True">Select Group :</asp:Label>
                </strong> 
                                 
                <n0:MOBILEDROPDOWNLIST class="form-control" id="WeighGroup" onchange="configWeighTable();" runat="server"></n0:MOBILEDROPDOWNLIST>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-xs-6">
<%--                <table align="center" class="sample" id="WeighTable">
                    <tbody>
                        <tr>
                            <td id="T1">National ID</td>
                            <td id="T2">FB</td>
                            <td id="T5">Weight</td>
                            <td id="T6">Move?</td>
                            <td id="T3">Last Kg</td>
                            <td id="T4">On</td>
                        </tr>
                    </tbody>
                </table>--%>
                <div id="groupWeighAnimalsTable">

                </div>
            </div>            
        </div>
        <div style="margin-top: 5px"></div>
        <div align="center">
            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="saveWeights();">Save Weights</a>
        </div>
    </div>

    <script type = "text/javascript">

        //
        var db;
        //

        function checkInput() 
        {
            var pType = "GroupWeigh";
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
                    App.alert("Please enter", "Cant enter \" in the cow number box");
                    return false;
                }
                if (alwaysConfirmFlag == "1")
                {
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
            else 
            {
                return true;
            }
            // Always return false so that for doesnt get submitted
            return(false);
        }// checkInput

       
        function submit()
        {
            var pType = "GroupWeigh";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

            //var opts = document.forms[0].AnimalList;
           
            //if (opts) {
            //    document.forms[0].HidAnimalList.value = opts.value;
            //    document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
            //    if (document.forms[0].HidAnimalList.value == "0") {
            //        App.alert("Please select", "Please select or type a cow number");
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
            WriteFormValues("GroupWeigh.aspx?Type=AddGroupWeigh&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            var msg = pType + " has been recorded and will be transferred at next synchronisation";
                
            if("<%=Master.HandsFree%>" != "") 
            {
                if ("<%=Master.IsMulti%>" == "true")
                {
                    AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
                    var  voiceRespM = AsyncAndroid.GetVoiceCommand();
                    if(voiceRespM!="no")
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
                App.alert("Results", msg);
            }
            else  
            {
                App.message(msg);                   
            }
            document.getElementById("form1").reset();

            //var aniTable = document.getElementById("WeighTable");
            //if (aniTable != null)
            //    aniTable.parentNode.removeChild(aniTable);

            return true;
        }// submit


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
            if (isEID == 0) 
            {
                var theTextBox = document.getElementById("filterInput");
                //   theTextBox.style["width"] = "220px";
            } 
            SetDates("GroupWeigh");
            var HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
            //FillDynamicList("AnimalList", "AnimalList", HerdID, 0, defaultAnimalID);
            
            if (defaultAnimalID) {
                seachOnAnimalID(defaultAnimalID);
            }

            //FillDynamicList("DoneObservedBy", "DoneObservedBy", HerdID,0);
                
            //document.forms[0].AnimalList.style.display = 'none';
            //document.forms[0].filterInput.style.display = 'none';
            //$('#findbutton').hide();
            FillDynamicList("<%=WeighGroup.ClientID%>", "GroupList", HerdID, 0);          

            if (isEID == 1) 
            {           
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if (document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }                    
            }

            // disabling the search feature within the navigation menu
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            searchInput.placeholder = "";
            disableSearchPlaceholder = true;
        }


        function saveWeights() {
            var weightList = ''; // Build CSV list of animals,weights then
            var table = document.getElementById("WeighTable");
            var rowCount = table.rows.length;
            var count = 0;

            for (var i = 1; i < rowCount; i++) {
                var row = table.rows[i];
                var nationalID = row.cells[0].childNodes[0].nodeValue;
                var weight = row.cells[2].childNodes[0].value;

                if (weight != "") {
                    if (isNaN(weight)) {
                        App.alert("Wrong type", "Non numeric value entered for weight " + nationalID);
                        return false;
                    }
                    var chkbox = row.cells[3].childNodes[0];
                    count += 1;

                    weightList += nationalID + "," + weight;
                    if (null != chkbox && true == chkbox.checked) {
                        weightList += ",M"; // M for move
                    }
                    else {
                        weightList += ",K"; // K for Kepp
                    }


                    if (i < rowCount - 1) {
                        weightList += ",";
                    }
                }
            }
            // Put the weight list value in the animals string

            //document.forms[0].HidWeighList.value = weightList;
            //var title;

            //if (document.getElementById("Eidinputdate")) {
            //    title = document.getElementById("Eidinputdate") + " " + document.forms[0].HidWeighList.value;
            //}
            //else { title = document.getElementById("inputdate").value + " " + document.forms[0].HidWeighList.value; }
            // document.forms[0].DoneDay.value + "/" + document.forms[0].DoneMonth.value + " " + document.forms[0].HidWeighList.value;
            //WriteFormValues("GroupWeigh.aspx?Type=AddGroupWeigh?&HerdID=" + HerdID, document.forms[0], title);
            //var msg = count + "Group Weigh has been recorded and will be transferred at next synchronisation";

            //App.alert("Result", count + " weights recorded");
            //document.getElementById("form1").reset();

            isCommitted = 1;
            if (checkInput()) {
                return submit();
            }
            else {
                return false;
            }
        }
        
        function searchFB(filterInput, postEntry) {

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

<%--                            WriteFormValues("GroupWeigh.aspx?Type=AddGroupWeigh?HerdID=" + HerdID, document.forms[0], document.forms[0].HidTitle.value);
                            if ("<%=Master.IsEID%>" == "1") {
                                App.message("Group Weigh has been recorded and will be transferred at next synchronisation");
                            }
                            else {
                                App.alert("Record", "Group Weigh has been recorded and will be transferred at next synchronisation");
                            }
                            isCommitted = 1;--%>
                        }

                        else if (results.rows.length > 1) {
                            App.alert("Result", "More than one matching cow found " + results.rows.length);
                            return false;
                        }
                        else {

                            return (searchTag(filterInput));
                        }
                    
                        App.alert("Result", "No matching cows for " + filterInput);
                    
                    return false;
                },
                  function (transaction, error) {
                      App.alert("Error", "Could not read: " + error.message);
                  });
        });
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
                            App.alert("Result", "More than one matching cow found, try a more exact tag " + results.rows.length);
                            return false;
                        }
                        else {
                            App.alert("Result", "No matching cows for " + filterInput);
                            return false;
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
            });
            return true;
        }


        function configWeighTable()
        {
            var HerdID = sessionStorage.getItem('HerdID');
            var groupWeighSelected = document.getElementById("<%=WeighGroup.ClientID%>");

            var sql = "SELECT * FROM Cows where [Group] = '" + groupWeighSelected.options[groupWeighSelected.selectedIndex].text + "' and InternalHerdID = '" + HerdID + "'";
            //var sql = "SELECT * FROM Cows where [Group] = '" + document.getElementById("<%=WeighGroup.ClientID%>").value + "' and InternalHerdID = '" + HerdID + "'";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }

            //
            var tableID = "WeighTable";
            var table1 = document.getElementById(tableID);
            if (table1 == null) {
                createTable();
            }
            //

            // Want to get all animals in selected group and put in a table
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                             function (transaction, results) {
                                 var table = document.getElementById('WeighTable');
                                 for (var i = table.rows.length - 1; i > 0; i--) {
                                     table.deleteRow(i);
                                 }
                                 for (z = 0; z < results.rows.length; z++) {
                                     var animalRow = results.rows.item(z);
                                     var rowCount = table.rows.length;
                                     var row = table.insertRow(1);

                                     var cell1 = row.insertCell(0);
                                     cell1.appendChild(document.createTextNode(animalRow.NationalID));

                                     var cell2 = row.insertCell(1);
                                     cell2.appendChild(document.createTextNode(animalRow.FreezeBrand));

                                     var cell5 = row.insertCell(2);
                                     var element = document.createElement("input");
                                     element.type = "textbox";
                                     element.style.width = '50px';
                                     cell5.appendChild(element);

                                     var cell6 = row.insertCell(3);
                                     var element = document.createElement("input");
                                     element.id = "myCheckbox" + animalRow.NationalID;
                                     element.type = "checkbox";
                                     element.style.textAlign = "center";                                  
                                     //
                                     var label = document.createElement("label");
                                     label.setAttribute("for", element.id);
                                     //
                                     cell6.appendChild(element);
                                     cell6.appendChild(label);




                                     var cell3 = row.insertCell(4);
                                     cell3.appendChild(document.createTextNode(animalRow.LastWeight));

                                     var cell4 = row.insertCell(5);
                                     cell4.appendChild(document.createTextNode(animalRow.LastWeightDate));
                                 }

                             },
                             function (transaction, error) {
                                 App.alert("Error", "Could not read: " + error.message);
                             });
            });
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
                          App.alert("Error", "Could not read: " + error.message);
                      });
            });
            return true;
        }


        function confirmRecord(pId, pValue)
        {
            if (pValue == false) {
                return false;
            }// if
            else {
                document.getElementById("filterInput").value = "";
                submit();
                return true;
            }// else
        }// confirmRecord


        // creating the weight records table
        function createTable() {
            var tableID = "WeighTable";

            var table = document.createElement('table');
            table.id = tableID;
            table.style.padding = "4px";
            table.style.margin = "4px";

            ////////////////////////////////////////
            var header = table.createTHead();
            var row = header.insertRow(0);
            var cell = document.createElement('th');
            cell.innerHTML = "National ID";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            row.appendChild(cell);

            var header = table.createTHead();
            //var row = header.insertRow(0);
            //var cell = document.createElement('th');
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "FB";
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
            cell.innerHTML = "Weight";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            //var row = header.insertRow(0);
            //var cell = document.createElement('th');
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Move?";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Last Kg";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            //create header for Animal
            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "On";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            var newtbody = document.createElement('tbody');
            table.appendChild(newtbody);


            //add the table to the DOM
            document.getElementById('groupWeighAnimalsTable').appendChild(table);
        }


    </script>

</asp:Content>
