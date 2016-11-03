<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="SingleWeigh.aspx.cs" Inherits="HybridAppWeb.SingleWeigh" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="row">
            <div class="form-group col-xs-6">
                <strong>
                    <asp:Label ID="singleWeighLbl" runat="server" Font-Bold="True">Weight :</asp:Label>
                </strong>                
                <asp:TextBox ID="Weight" CssClass="form-control" runat="server" MaxLength="60"></asp:TextBox>
                <asp:Label ID="weightlabel" runat="server"></asp:Label>
            </div>
        </div>
        <div align="center">
            <br />
            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Weight</a>
        </div>
    </div>

    <script type = "text/javascript">

        //
        var db;
        //

        function checkInput() 
        {
            var pType = "Weigh";
            if(pType=="Weigh")
            {
                var mystring = document.getElementById('<%=this.Weight.ClientID%>').value;
                if(mystring=="")
                {
                    App.alert("Enter", "Please enter the weight");
                    return false;
                }
            }
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
        }// checkInput


        function submit()
        {
            var pType = "Weigh";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

            var opts = document.forms[0].AnimalList;
           
            if (opts) {
                document.forms[0].HidAnimalList.value = opts.value;
                document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
                if (document.forms[0].HidAnimalList.value == "0") {
                    App.alert("Select", "Please select or type a cow number");
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
            WriteFormValues("SingleWeigh.aspx?Type=AddWeigh&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            var msg = "Weigh has been recorded and will be transferred at next synchronisation";

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
                App.alert("Result", msg);
            }
            else
            {
                App.message(msg);                 
            }
            document.getElementById("form1").reset();

            return true;
        }//


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
            SetDates("Weigh");

            HerdID = sessionStorage.getItem('HerdID');
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
            

            if (isEID == 1) 
            {           
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if (document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }                    
            }
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


        function configWeighTable() {
            HerdID = sessionStorage.getItem('HerdID');

            //var sql = "SELECT * FROM Cows where [Group] = '" + document.forms[0].WeighGroup.value + "' and InternalHerdID = '" + HerdID + "'";
            var sql = "SELECT * FROM Cows where [Group] = '" + document.forms[0].WeighGroup[document.forms[0].WeighGroup.selectedIndex].text + "' and InternalHerdID = '" + HerdID + "'";

            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
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
                                     element.type = "checkbox";
                                     cell6.appendChild(element);

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
