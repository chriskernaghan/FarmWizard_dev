<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="AddPage.aspx.cs" Inherits="HybridAppWeb.AddPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <asp:CheckBox ID="SameDetailCheckBox" runat="server" Text="Assign details below to all animals?"></asp:CheckBox>

                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Sex :</b>
                        
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="NewSex" runat="server" EnableViewState="False">
                                <asp:ListItem Value="Female" selected="true">Female</asp:ListItem>
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Breed :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="NewBreed" runat="server" DataValueField="Breed" DataTextField="DisplayText"></n0:MOBILEDROPDOWNLIST>

                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Class :</b>                     
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="NewClass" runat="server"></n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Join Date :</b>
                         <input type="text" name="JoinDateText" onfocus="(this.type='date')" id="joininputdate" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Date of Birth :</b>
                       <input type="text" name="DOBDateText" onfocus="(this.type='date')" id="dobinputdate" class="form-control">
                        </div>
                        <div class="form-group col-xs-6">
                            <b>From:</b>
                            <asp:TextBox ID="PurchasedFrom" CssClass="form-control input-sm" runat="server" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Group :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="JoinGroup" runat="server" DataValueField="ID" DataTextField="Name" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Ewe :</b>
                            <a href="#" class="btn btn-primary waves-effect waves-light" onclick=addEweScan();>Scan</a>

                            <asp:TextBox ID="DamTextBox" runat="server" class="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6 ">
                            <b>Defect/Siblings :</b>
                        
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="CongenitalDefect" runat="server" DataValueField="TypeID" DataTextField="AphisTypeName" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>

                            <div style="margin-top: 5px"></div>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="SiblingInfo" runat="server" EnableViewState="False">
                                <asp:ListItem Value="0">N/A</asp:ListItem>
                                <asp:ListItem Value="1">Single</asp:ListItem>
                                <asp:ListItem Value="2">Twin</asp:ListItem>
                                <asp:ListItem Value="3">Trip</asp:ListItem>
                                <asp:ListItem Value="4">Quad</asp:ListItem>
                                <asp:ListItem Value="5">Quin</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>

                    </div>
                    <td colspan="2">
                        <asp:CheckBox ID="CrossCheckBox" runat="server" Text="Is Cross?"></asp:CheckBox>
                        <asp:CheckBox ID="MarkMoveCheckBox" runat="server" Text="Mark Move?"></asp:CheckBox>
                        <div class="row">
                            <div class="form-group col-xs-6">
                                <b>Notes :</b>
                                <!--<asp:TextBox ID="Notessss" class="form-control input-sm" runat="server" Height="100px" Width="200%" MaxLength="50"></asp:TextBox>-->
                                <asp:TextBox name="Note" ID="Note" class="form-control input-sm" runat="server" MaxLength="50" style="resize:none" Height="120" Width="200%" TextMode="MultiLine"></asp:TextBox>
               
                            </div>
                        </div>

                        <div align="center">

                            <a href="#" id="A1" class="btn btn-primary waves-effect waves-light" onclick="checkInput()">Add New</a>
                        </div>
                </div>
            </div>

    <script type = "text/javascript">

        //
        var db;
        var eweScan=false;
        //

        function checkInput() {
              var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var herdID = sessionStorage.getItem('HerdID');

            if (isEID == 1) 
            { 
                //var animals = document.getElementById("EIDAnimalList").options;
                //var count = animals.length;
           
                //if (count == 0) {
                //    App.message("No animals scanned.");
                //    return false;
                //}

                //var animalList = "";
           
            
                //for (var k = 0; k < count; k++) {
                //    if (k > 0) {
                //        animalList += ",";
                //    }
                //    animalList = animalList + animals[k].value;
                //}

                //document.forms[0].HidAnimalList.value = animalList;
                //animals.length = 0;
                ////document.forms[0].Count.value = "";
            
                var getLocation = false;
                var animalListEID = "";
                var animalListNFC = "";
                var eidnfclist = getAllFromList();

                var count = eidnfclist.length;
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

                document.forms[0].HidTitle.value = "Recorded" + count + " New animals";
            }

            WriteFormValues("AddPage.aspx?Type=AddNew&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            var msg = "AddNew has been recorded and will be transferred at next synchronisation";

            //deleteAllFromList();

            if (isEID != 1) 
            {
                App.alert("Result", msg);
            }
            else  {
                App.message(msg); 
                document.getElementById("form1").reset();
            }  
            
            // Always return false so that for doesnt get submitted
            return(false);
        }

        function addEweScan(){
            eweScan=true;
        }


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
                            var row = results.rows.item(0);
                                damNum = row.NationalID;
                               document.getElementById("<%=DamTextBox.ClientID%>").value=damNum;
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
            var pForLambs=0;
            //var herdID = sessionStorage.getItem('HerdID');
            
            //var sql = "SELECT * FROM Cows where (ElectronicID = '" + tag + "' AND InternalHerdID = " + herdID + ")";
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                    function (transaction, results) {
                        //var listBox = document.getElementById("EIDAnimalList");
                        //var opt = document.createElement("option");
                        // results.rows holds the rows returned by the query
                        var damNum = "";

                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) 
                        {
                            if(!eweScan){
                                var row = results.rows.item(0);
                                if (row.Exception != '') {
                                    App.alert("Exception", row.Exception);
                                }
                                if (row.withdrawalDate != '') {
                                    alertWithdrawal(row.WithdrawalDate);
                                }
                                App.message(tag + " in database already");
                            }
                            else{
                                var row = results.rows.item(0);
                                damNum = row.NationalID;
                                document.getElementById("<%=DamTextBox.ClientID%>").value=damNum;
                            }
                        } 
                        else {
                            var row = results.rows;
                            if(eweScan){
                                App.message(tag + " Dam not yet in database will add as EID");
                                damNum = tag;
                            }
                            else if(tagType == "ElectronicID")
                            {
                                if(readTagFor != "")
                                {
                                    addToList(tag, readTagFor);
                                    readTagFor = "";
                                }// if
                                else{
                                    addToList(tag, null);
                                }
                            }// else if
                            else{
                                if (pForLambs) {
                                    addLamb(tag);
                                }

                                
                                addToList(null, tag);
                                

                                //if ((nfc != "") && (nfc != tag)){
                                //    addToList(tag, nfc);
                                //}
                                //else if (!setEid){
                                //    addToList(tag, null);
                                //}      
                            }
                        }
                    },
                    function (transaction, error) {
                        App.alert("Error", "Could not read: " + error.message);
                    });
            });
                App.message(tag);
                return;
                                             
        }

        function initPage() 
        {
            var isEID = "<%=Master.IsEID%>";
            if(isEID == 1)
            {
               // document.getElementById("Mansearch").innerHTML = "Manual Add";
                if (document.getElementById('ReadMotherTag')) {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }
                //document.getElementById('selectedAnimalsTable').style.display = 'block';
            }            
        
            db = OpenDatabase();
            if (!db) 
            {
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
            SetDates("AddNew");
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            SetDates('New');
            if (herdName) 
            {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');
                        
            // disabling the search feature within the navigation menu
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            searchInput.placeholder = "";
            disableSearchPlaceholder = true;
        }

        function deleteAllFromList() {
            var tableID = "AnimalListTable";
            var table = document.getElementById(tableID);
            document.getElementById('selectedAnimalsTable').removeChild(table);
        }

        function addNew(eventType) {
            var voiceRespM;
            var cont = true;
            var found = false;
            var scan = false;
            while (cont) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("Is sex male or female?");
                var voiceRespM = AsyncAndroid.GetVoiceCommand();
                if ((voiceRespM == "male") || (voiceRespM == "mail")) {
                    setSelectedIndex(document.getElementById("NewSex"), "Male");
                    break;
                } else if (voiceRespM == "female") {
                    setSelectedIndex(document.getElementById("NewSex"), "Female");
                    break;
                }
        else if(voiceRespM=="skip"){
            break;
        }
        else if((voiceRespM=="stop")||(voiceRespM=="cancel") || (voiceRespM=="exit") ){
            window.location.history.back();
            cont = false;
        }
    }
    for(var l=1;l<4;l++){
        AsyncAndroid.ConvertTextToVoicePromptResponse("What is the breed?");
        var voiceRespM = AsyncAndroid.GetVoiceCommands();
        var arrStr = voiceRespM.replace('[', '');
        arrStr = arrStr.replace(']', '');
        var result= arrStr.split(',');
        var i=0;
        var text;
        while(i<result.length && found ==false){
            if(result[i]=="skip"){
                found=true;
                break;
            }
             else if (selectOption("NewBreed", result[i], 8) != "") {
                found=true;
                break;
            }
            i++;
        }
        if(found){
            break;
        }
    }
    if(found==false){
        AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
        window.loaction.href="AddPage.aspx?&IsEID=<%=Master.IsEID%>";
    }
    else if(found)
    {
        found=false;
    }
    for(var l=1;l<4;l++){
        AsyncAndroid.ConvertTextToVoicePromptResponse("Ewe, Lamb or Ram?");
        var voiceRespM = AsyncAndroid.GetVoiceCommands();
        var arrStr = voiceRespM.replace('[', '');
        arrStr = arrStr.replace(']', '');
        var result= arrStr.split(',');
        var i=0;
        var text;
        while(i<result.length && found ==false){
            if(result[i]=="skip"){
                found=true;
                break;
            }
           else if (selectOption("NewClass", result[i], 3) != "") {
                found=true;
                break;
            }
            i++;
        }
        if(found){
            break;
        }
    }
    if(found==false){
        AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
         window.loaction.href="AddPage.aspx?&IsEID=<%=Master.IsEID%>";
        }
        else if(found)
        {
            found=false;
        }
        while (cont) {
            AsyncAndroid.ConvertTextToVoicePromptResponse("What is the age in months? just speak the number");
            var voiceRespM = AsyncAndroid.GetVoiceCommand();
            if((voiceRespM =='stop')||(voiceRespM =='cancel')||(voiceRespM =='exit')) {
                window.location.history.back;
            }
            else if(voiceRespM == 'skip'){
                break;
            }  
            else if(voiceRespM=='one'){
                voiceRespM="1";
            }
            if (isNaN(voiceRespM)) {
                voiceRespM = window.prompt("Please enter animals (must be numeric):", "");
                //App.textInput("Please enter", "Please enter animals (must be numeric): ", "animalResults", pNationalID, true);
            }
            var t = new Date();

            t.setMonth(t.getMonth()- voiceRespM );
            var date= formatDate(t);
            document.getElementById("dobinputdate").value=date;
            break;
        }
        for(var l=1;l<4;l++){
            AsyncAndroid.ConvertTextToVoicePromptResponse("What is the group?");
            var voiceRespM = AsyncAndroid.GetVoiceCommands();
            var arrStr = voiceRespM.replace('[', '');
            arrStr = arrStr.replace(']', '');
            var result= arrStr.split(',');
            var i=0;
            var text;
            while(i<result.length && found ==false){
                if(result[i]=="skip"){
                    found=true;
                    break;
                }
                else if (selectOption("JoinGroup", result[i], 3) != "") {
                    found=true;
                    break;
                }
                i++;
            }
            if(found){
                break;
            }
        }
        if(found==false){
            AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
             window.loaction.href="AddPage.aspx?&IsEID=<%=Master.IsEID%>";
        }
           
        if ("<%=Master.IsMulti%>" == "true") {
        document.getElementById('SameDetailCheckBox').checked = true;
    }
    if(cont){
        var ewelist=document.getElementById("<%=DamTextBox.ClientID%>").value;
        if(ewelist==""){
            AsyncAndroid.ConvertTextToVoicePromptResponse("Please confirm to scan Ewe? Answer Yes, or No");
            voiceRespM = AsyncAndroid.GetVoiceCommand();
            if(voiceRespM!='no'){
                if(bluetoothVR){
                    App.message("Please scan EID");
                    setTimeout(function() { readDamTag(); }, 6000);
                }
                else{
                    App.message("Please scan NFC");
                    AsyncAndroid.EweScan();
                }
            }
        }
    }
    setTimeout(function() { checkInput(); }, 12000);
            
        }

        function addLamb(pTagNo)
          {
              var search;
              var i;
              var tagCnt = 0;
              var addedTags=new Array();

              // Delete any rows to start with
              var table = document.getElementById("LambTable");
              var rowCount = table.rows.length;
              if(pTagNo == document.forms[0].DamEIDTag.value) {
                  App.alert("Tag Scanned","Ewe tag scanned");
                  return;
              }
              else {
                  // check if already added
                  for(var i=1; i<rowCount; i++) {
                      var erow = table.rows[i];
                      var lamb = erow.cells[0].childNodes[0].value;
                      if(lamb == pTagNo) {
                          App.alert("Already Scanned", "Lamb already scanned");
                          return;
                      }
                  }

                  var row = table.insertRow(rowCount);

                  var cell1 = row.insertCell(0);
                  var element2 = document.createElement("input");
                  element2.type = "text";
                  element2.value = pTagNo;
                  element2.style.width = "150px";
                  cell1.appendChild(element2);

                  var cell2 = row.insertCell(1);
                  var element1 = document.createElement("input");
                  element1.id = "myCheckbox" + pTagNo;
                  element1.type = "checkbox";
                  element1.style.textAlign = "center";
                  //
                  var label = document.createElement("label");
                  label.setAttribute("for", element1.id);
                  //
                  cell2.appendChild(element1);
                  cell2.appendChild(label);



                  var cell3 = row.insertCell(2);
                  var element3 = document.createElement("input");
                  element3.type = "text";
                  element3.style.width = "50px";
                  cell3.appendChild(element3);

               
                  if(<%=Master.IsInnova%> == "1") {

                      var cell4 = row.insertCell(3);
                      var selectBox = document.createElement("select");
                      var option = document.createElement("option");
                      option.text = "1";
                      option.value = "1";
                      selectBox.add(option, null);    
                      var option2 = document.createElement("option");
                      option2.text = "2";
                      option2.value = "2";
                      selectBox.add(option2, null);
                      var option3 = document.createElement("option");
                      option3.text = "3";
                      option3.value = "3";
                      selectBox.add(option3, null);
                      var option4 = document.createElement("option");
                      option4.text = "4";
                      option4.value = "4";
                      selectBox.add(option4, null);
                      var option5 = document.createElement("option");
                      option5.text = "5";
                      option5.value = "5";
                      selectBox.add(option5, null);
                      cell4.appendChild(selectBox);

                      var cell5 = row.insertCell(4);
                      var selectBox2 = document.createElement("select");
                      option = document.createElement("option");
                      option.text = "0";
                      option.value = "0";
                      selectBox2.add(option, null);
                      option2 = document.createElement("option");
                      option2.text = "1";
                      option2.value = "1";
                      selectBox2.add(option2, null);
                      option3 = document.createElement("option");
                      option3.text = "2";
                      option3.value = "2";
                      selectBox2.add(option3, null);
                      option4 = document.createElement("option");
                      option4.text = "3";
                      option4.value = "3";
                      selectBox2.add(option4, null);
                      option5 = document.createElement("option");
                      option5.text = "4";
                      option5.value = "4";
                      selectBox2.add(option5, null);
                      cell5.appendChild(selectBox2);

                      var cell6 = row.insertCell(5);
                      var selectBox3 = document.createElement("select");
                      option = document.createElement("option");
                      option.text = "0";
                      option.value = "0";
                      selectBox3.add(option, null);
                      option2 = document.createElement("option");
                      option2.text = "1";
                      option2.value = "1";
                      selectBox3.add(option2, null);
                      option3 = document.createElement("option");
                      option3.text = "2";
                      option3.value = "2";
                      selectBox3.add(option3, null);
                      cell6.appendChild(selectBox3);
                  }
              }
              return;

          }
     
          //function readNfcTag(nfcTagNumber){
          //    var pForLambs=0;
          //    var decimal=nfcTagNumber;
          //    //if ((Master.checkForDuplicate(decimal) == 0) && (decimal != "") && (decimal.indexOf("NaN") < 0)) {
                  
          //        var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + HerdID + ")";
          //        db.transaction(function(transaction) {
          //            transaction.executeSql(sql, [],
          //                function(transaction, results) {
          //                    //var listBox = document.getElementById("EIDAnimalList");
          //                    //var opt = document.createElement("option");
                              
          //                    // results.rows holds the rows returned by the query
          //                    if (results.rows.length == 1) {
          //                        var row = results.rows.item(0);
          //                        var skip = false;
                                 
          //                        if(row.Exception!=''){
          //                            App.alert("Exception", row.Exception);
          //                        }
          //                        if(row.WithdrawalDate!=''){
          //                            alertWithdrawal(row.WithdrawalDate,"AddNew");
          //                        }
          //                        App.message(decimal + " in database already");
          //                    }else{
          //                        if (pForLambs) 
          //                        {
          //                            addLamb(decimal); 
          //                        } else 
          //                        {
          //                            if(decimal.length==15){
          //                                opt.text = opt.value= decimal;
          //                                listBox.options.add(opt,0);
          //                                setSelectedIndex(listBox, opt.value);
          //                                var counter = document.getElementById("Count");
          //                                counter.value = listBox.length;
          //                                addToList(decimal, decimal);
          //                            }
          //                            else if(decimal.length<15)
          //                            {  
          //                                var confirmWrite= confirm("Please scan EID");
          //                                //var confirmWrite = App.confirm("Record", "Please scan EID", confirmRecord, pType);
          //                                if(confirmWrite){
          //                                    if (bReaderConnected) {
          //                                        //read the tag and callback to BTScannedTag with the nfc tag
          //                                        setTimeout(function() { 
          //                                            if (bReaderConnected) {
          //                                                App.message("Ready to scan tag...");
          //                                                Android.ReadTagFor(decimal);
          //                                            }
          //                                        }, 300);
          //                                    }
          //                                }
          //                                else{ 
          //                                    addToList(null, decimal);}
          //                            }
          //                        }
          //                    }
                                      
          //                      App.message(decimal + " Animal not found");
          //              },
          //                function(transaction, error) {
          //                    App.alert("Error", "Could not read: " + error.message);
          //                });
          //      });

          //  //}
          //}


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

</asp:Content>
