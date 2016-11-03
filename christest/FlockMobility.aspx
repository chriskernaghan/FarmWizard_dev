<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="FlockMobility.aspx.cs" Inherits="HybridAppWeb.FlockMobility" %>

<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType VirtualPath="_App.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <b>Field Name</b>
                    <n0:MobileDropDownList class="form-control" ID="FieldList" onchange='fieldListTextChange(this);' runat="server" EnableViewState="False" DataTextField="ListBoxText" DataValueField="InternalFieldID">
                    </n0:MobileDropDownList>
                </div>
                <div class="form-group col-xs-6">
                    <b>No of Animals in Field</b>
                    <asp:TextBox ID="NoOfAnimals" TextMode="Number" CssClass="form-control input-sm" onchange='noofAnimalsTextChange(this)' runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <b>Pasture Length</b>
                    <n0:MobileDropDownList class="form-control" ID="PastureLength" onchange='pastureLengthTextChange(this);' runat="server" EnableViewState="False">
                    </n0:MobileDropDownList>
                </div>
                <div class="form-group col-xs-6">
                    <b>Pasture Type</b>
                    <n0:MobileDropDownList class="form-control" ID="PastureType" onchange='pastureTypeTextChange(this);' runat="server" EnableViewState="False">
                    </n0:MobileDropDownList>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <b>Sheep Category</b>
                    <n0:MobileDropDownList class="form-control" ID="AnimalType"  runat="server" EnableViewState="False">
                        <%--  <asp:ListItem Value="Lamb" >Lamb</asp:ListItem>--%>
                        <%-- <asp:ListItem Value="Ewe">Ewe</asp:ListItem>--%>
                    </n0:MobileDropDownList>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <div align="center">

                        <table class="sample" id="ScoreTable">
                            <tbody>
                                <tr>
                                    <th id="S1">Flock Score</th>
                                    <th id="S2">No Of Animals  </th>

                                </tr>
                                <tr>
                                    <td>0</td>
                                    <td>
                                        <input type="number"  id="score1" /></td>

                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>
                                        <input type="number"  id="score2" /></td>

                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>
                                        <input type="number" id="score3"  /></td>

                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>
                                        <input type="number" id="score4"  /></td>

                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>
                                        <input type="number" id="score5"  /></td>

                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>
                                        <input type="number" id="score6" /></td>

                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
            <br />
            <div align="center">
                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="saveFlockScore();">Save FlockScore</a>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        ///<reference path="/Script/jquery-ui.min.js" />
        ///<reference path="/Script/HybridApp.js" />

        var isCommitted;

        function initPage()
        {
            var isEID = "<%=Master.IsEID%>";
            var HerdID = sessionStorage.getItem('HerdID');
            SetDates('FlockMobility');
            db = OpenDatabase();
            if (!db) {
                alert("Database","Cannot open database");
                return;
            }
            if (document.getElementById('FullNumberList')) {
                document.getElementById('FullNumberList').style.display = 'none';
                hideSelect(document.getElementById('FullNumberList')); // hiding the new select
                document.getElementById('FullNumberList').options.length = 0;
            }
            btRetries = 0;
            isCommitted = 0;


            // disabling the search feature within the navigation menu
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            searchInput.placeholder = "";
            disableSearchPlaceholder = true;
        }

        function saveFlockScore() {
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var totalAnimal = 0;
            var table = document.getElementById("ScoreTable");
            if (document.getElementById("<%=NoOfAnimals.ClientID%>").value == "") {
                App.alert("Please Enter","No of animals may not be blank");
            }
            else {
                var noOfAnimals = document.getElementById("<%=NoOfAnimals.ClientID%>").value;
                var scorelist = '';
                var rowCount = table.rows.length;
                var count = 0;
                for (var i = 1; i < rowCount; i++) {
                    var row = table.rows[i];
                    var score = row.cells[0].childNodes[0].nodeValue;
                    var animals = document.getElementById("score" + [i]).value;
                    if (animals != "") {
                        if (isNaN(animals)) {
                            App.alert("Must be Number","Non numeric value entered for Animal");
                            return;
                        }
                        count += 1;
                        scorelist += score + "," + animals;
                        if (i < rowCount - 1) {
                            scorelist += ",";
                        }
                    } if (animals != "") {
                        totalAnimal += parseInt(animals);
                    }
                }
                if (noOfAnimals != totalAnimal) {
                    App.alert("Must be Same","Total Score Animals should be equal to No of Animals in Field");
                } else {
                    document.forms[0].HidWeighList.value = scorelist;
                    var title = '';
                    if (document.getElementById("Eidinputdate")) {
                        title = document.getElementById("Eidinputdate").value + " " + document.forms[0].HidWeighList.value;
                    }
                    else { title = document.getElementById("inputdate").value + " " + document.forms[0].HidWeighList.value; }
                    // document.forms[0].DoneDay.value + "/" + document.forms[0].DoneMonth.value + " " + document.forms[0].HidWeighList.value;
                    WriteFormValues("FlockMobility.aspx?Type=AddFlockMobility&HerdID=" + herdID, document.forms[0], title);
                    var msg = count + " Flock Score has been recorded and will be transferred at next synchronisation";

                    if ("<%= Master.HandsFree %>" != "") {
                    if ("<%= Master.IsMulti %>" == "true") {
                        AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
                        var voiceRespM = AsyncAndroid.GetVoiceCommand();
                        if (voiceRespM != "no") {
                            handsFreeFlockMobility("FlockMobility");
                        }
                    }
                    isCommitted = 1;
                    AsyncAndroid.ConvertTextToVoice(msg);
                    setTimeout(function () { returnToMain(); }, 1000);
                }
                    else {
                        if(isEID!=1)
                            App.alert("Result", msg);
                        else App.message(msg)
                    document.getElementById("form1").reset();
                }
                isCommitted = 1;
            }
        }
    }
    function handsFreeFlockMobility(eventType) {
        var voiceRespM;
        var found = false;
        for (var z = 1; z < 4; z++) {
            AsyncAndroid.ConvertTextToVoicePromptResponse("What is the FieldName?");
            voiceRespM = AsyncAndroid.GetVoiceCommands();
            var arrStr = voiceRespM.replace('[', '');
            arrStr = arrStr.replace(']', '');
            var result = arrStr.split(',');
            var y = 0;;
            var text;
            while (y < result.length && found == false) {
                if (result[y] == 'skip') {
                    found = true;
                    break;
                }
                else if (selectOption("FieldList", result[y], 6) != "") {
                    found = true;
                    break;
                }
                y++;
            }
            if (found) {
                break;
            }
        }
        if (found == false) {
            AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
            window.loaction.href = "FlockMobility.aspx?IsEID=<%=Master.IsEID %>";
            }
            else if (found) {
                found = false;
            }
            while (true) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Number of animals in field");
                voiceRespM = AsyncAndroid.GetVoiceCommand();
                if ((voiceRespM == 'stop') || (voiceRespM == 'cancel') || (voiceRespM == 'exit')) {
                    window.location.history.back;
                }
                else if (voiceRespM == 'skip') {
                    break;
                }
                else if (voiceRespM == 'one') {
                    voiceRespM = "1";
                }
                if (isNaN(voiceRespM)) {
                    voiceRespM = window.prompt("Please enter animals (must be numeric):", "");
                    //App.textInput("Please enter", "Please enter animals (must be numeric): ", "animalResults", pNationalID, true);
                }
                if (!isNaN(voiceRespM)) {
                    document.getElementById("<%=NoOfAnimals.ClientID%>").value = voiceRespM;
                    break;
                }
                else {
                    App.alert("Please Enter Number","Must be Numeric");
                }
            }

            for (var z = 1; z < 4; z++) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("What is the Pasture Type?");
                voiceRespM = AsyncAndroid.GetVoiceCommands();
                var arrStr = voiceRespM.replace('[', '');
                arrStr = arrStr.replace(']', '');
                var result = arrStr.split(',');
                var y = 0;;
                var text;
                while (y < result.length && found == false) {
                    if (result[y] == 'skip') {
                        found = true;
                        break;
                    }
                    else if (selectOption("PastureType", result[y], 4) != "") {
                        found = true;
                        break;
                    }
                    y++;
                }
                if (found) {
                    break;
                }
            }
            if (found == false) {
                AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                window.loaction.href = "FlockMobility.aspx?IsEID=<%=Master.IsEID %>";
            }
            else if (found) {
                found = false;
            }
            for (var z = 1; z < 4; z++) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("What is the Pasture Length?");
                voiceRespM = AsyncAndroid.GetVoiceCommands();
                var arrStr = voiceRespM.replace('[', '');
                arrStr = arrStr.replace(']', '');
                var result = arrStr.split(',');
                var y = 0;;
                var text;
                while (y < result.length && found == false) {
                    if (result[y] == 'skip') {
                        found = true;
                        break;
                    }
                    else {
                        if (result[y] == "short")
                            document.getElementById("<%=PastureLength.ClientID%>").options[2].selected = true;
                        else if (result[y] == "medium")
                            document.getElementById("<%=PastureLength.ClientID%>").options[1].selected = true;
                        else if (result[y] == "long")
                            document.getElementById("<%=PastureLength.ClientID%>").options[0].selected = true;
                        else
                            if (selectOption("PastureLength", result[y], 4) != "") {
                            }
                        found = true;
                        break;
                    }
                    y++;
                }
                if (found) {
                    break;
                }
            }
            if (found == false) {
                AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                window.loaction.href = "FlockMobility.aspx?IsEID=<%=Master.IsEID %>";
            }
            else if (found) {
                found = false;
            }
            for (var z = 1; z < 4; z++) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("What is the Sheep Category?");
                voiceRespM = AsyncAndroid.GetVoiceCommands();
                var arrStr = voiceRespM.replace('[', '');
                arrStr = arrStr.replace(']', '');
                var result = arrStr.split(',');
                var y = 0;;
                var text;
                while (y < result.length && found == false) {
                    if (result[y] == 'skip') {
                        found = true;
                        break;
                    }
                    else if (selectOption("AnimalType", result[y], 3) != "") {
                        found = true;
                        break;
                    }
                    y++;
                }
                if (found) {
                    break;
                }
            }
            if (found == false) {
                AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                window.loaction.href = "FlockMobility.aspx?IsEID=<%=Master.IsEID %>";
            }
            checkOnScore("0", "1");
            checkOnScore("1", "2");
            checkOnScore("2", "3");
            checkOnScore("3", "4");
            checkOnScore("4", "5");
            checkOnScore("5", "6");
            saveFlockScore();
        }
        function checkOnScore(pValue, fieldID) {
            AsyncAndroid.ConvertTextToVoicePromptResponse("Please say number of animals in flock score " + pValue);
            var voiceRespM = AsyncAndroid.GetVoiceCommand();
            if ((voiceRespM == 'stop') || (voiceRespM == 'cancel') || (voiceRespM == 'exit')) {
                window.loaction.href = "FlockMobility.aspx?IsEID=<%=Master.IsEID %>";
            }
            else if (voiceRespM != 'skip') {
                if (isNaN(voiceRespM)) {
                    voiceRespM = window.prompt("Please enter animals (must be numeric):", "");
                    //App.textInput("Please enter", "Please enter animals (must be numeric): ", "animalResults", pNationalID, true);
                }
                document.getElementById("score" + fieldID).value = voiceRespM;
            }
        }
        function fieldListTextChange() {
            document.getElementById("<%=NoOfAnimals.ClientID%>").focus();
        }
        function noofAnimalsTextChange() {
            document.getElementById("<%=PastureLength.ClientID%>").focus();
        }
        function pastureLengthTextChange() {
            document.getElementById("<%=PastureType.ClientID%>").focus();
        }
        function pastureTypeTextChange() {
            document.getElementById("<%=AnimalType.ClientID%>").focus();
        }
       


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
                    App.alert("TEST", "test" + value);
                }// else
            }// else
        }// animalResults
    </script>

</asp:Content>
