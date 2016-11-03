<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="TreatmentPage.aspx.cs" Inherits="HybridAppWeb.TreatmentPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="row">
                <div class="form-group col-xs-6">
                    <div class="input-group input-field">
                        <b>Select <span class="balloon-this">animal</span> :</b>
                        <input type="text" class="input-sm autocomplete" name="CowNumber" id="CowNumber" placeholder="Search animal" />
                    </div>
                </div>
                <div class="form-group col-xs-6">
                    <strong>Medication 1 :</strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="MedTreatment" runat="server"></n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>Medication 2 :</strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="MedTreatment2" runat="server"></n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>History :</strong><span id="TreatHistoryText"></span>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label14" runat="server" Font-Bold="True">Administrator :</asp:Label></td>
                    </strong>            
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="DoneByBox" runat="server"></n0:MOBILEDROPDOWNLIST>
                    <div style="margin-top: 5px"></div>
                    <asp:TextBox ID="DoneByTextBox" class="form-control input-sm" runat="server" Width="104px" MaxLength="70"></asp:TextBox>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="TreatReasonLabel" runat="server" Font-Bold="True">Treatment  Reason :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="TreatmentReason" runat="server"></n0:MOBILEDROPDOWNLIST>
                    <div style="margin-top: 5px"></div>
                    <asp:TextBox ID="TreatmentReasonTextBox" CssClass="form-control input-sm" runat="server" Width="102px" MaxLength="20"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="TreatmentDateLabel" runat="server" Font-Bold="True">Treat Date :</asp:Label>
                    </strong>
                    <input type="text" name="TreatmentDateText" onfocus="(this.type='date')" id="Treatmentinputdate" class="form-control">
                </div>
                <%--<N0:MOBILEDROPDOWNLIST class="selectHolder" id="TreatmentDay" runat="server">
                                        <asp:ListItem Value="1">01</asp:ListItem>
                                        <asp:ListItem Value="2">02</asp:ListItem>
                                        <asp:ListItem Value="3">03</asp:ListItem>
                                        <asp:ListItem Value="4">04</asp:ListItem>
                                        <asp:ListItem Value="5">05</asp:ListItem>
                                        <asp:ListItem Value="6">06</asp:ListItem>
                                        <asp:ListItem Value="7">07</asp:ListItem>
                                        <asp:ListItem Value="8">08</asp:ListItem>
                                        <asp:ListItem Value="9">09</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="11">11</asp:ListItem>
                                        <asp:ListItem Value="12">12</asp:ListItem>
                                        <asp:ListItem Value="13">13</asp:ListItem>
                                        <asp:ListItem Value="14">14</asp:ListItem>
                                        <asp:ListItem Value="15">15</asp:ListItem>
                                        <asp:ListItem Value="16">16</asp:ListItem>
                                        <asp:ListItem Value="17">17</asp:ListItem>
                                        <asp:ListItem Value="18">18</asp:ListItem>
                                        <asp:ListItem Value="19">19</asp:ListItem>
                                        <asp:ListItem Value="20">20</asp:ListItem>
                                        <asp:ListItem Value="21">21</asp:ListItem>
                                        <asp:ListItem Value="22">22</asp:ListItem>
                                        <asp:ListItem Value="23">23</asp:ListItem>
                                        <asp:ListItem Value="24">24</asp:ListItem>
                                        <asp:ListItem Value="25">25</asp:ListItem>
                                        <asp:ListItem Value="26">26</asp:ListItem>
                                        <asp:ListItem Value="27">27</asp:ListItem>
                                        <asp:ListItem Value="28">28</asp:ListItem>
                                        <asp:ListItem Value="29">29</asp:ListItem>
                                        <asp:ListItem Value="30">30</asp:ListItem>
                                        <asp:ListItem Value="31">31</asp:ListItem>
                                    </N0:MOBILEDROPDOWNLIST>
                                    <N0:MOBILEDROPDOWNLIST class="selectHolder" id="TreatmentMonth" runat="server">
                                        <asp:ListItem Value="1">01</asp:ListItem>
                                        <asp:ListItem Value="2">02</asp:ListItem>
                                        <asp:ListItem Value="3">03</asp:ListItem>
                                        <asp:ListItem Value="4">04</asp:ListItem>
                                        <asp:ListItem Value="5">05</asp:ListItem>
                                        <asp:ListItem Value="6">06</asp:ListItem>
                                        <asp:ListItem Value="7">07</asp:ListItem>
                                        <asp:ListItem Value="8">08</asp:ListItem>
                                        <asp:ListItem Value="9">09</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="11">11</asp:ListItem>
                                        <asp:ListItem Value="12">12</asp:ListItem>
                                    </N0:MOBILEDROPDOWNLIST>
                                    <N0:MOBILEDROPDOWNLIST class="selectHolder" id="TreatmentYear" runat="server">
                                               
                                    </N0:MOBILEDROPDOWNLIST>
                                    <N0:MOBILEDROPDOWNLIST class="selectHolder" id="TreatmentTime" runat="server">
                                        <asp:ListItem Value="09:00">AM</asp:ListItem>
                                        <asp:ListItem Value="17:00">PM</asp:ListItem>
                                    </N0:MOBILEDROPDOWNLIST>--%>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="TreatFinishedLabel" runat="server" Font-Bold="True">Treat Fin :</asp:Label>
                    </strong>
                    <input type="text" name="TreatmentFinishedDateText" onfocus="(this.type='date')" id="TreatmentDateFinishedinput" class="form-control">
                </div>
            </div>
            <%--<N0:MOBILEDROPDOWNLIST class="selectHolder" id="FinishedDay" runat="server">
                                        <asp:ListItem Value="1">01</asp:ListItem>
                                        <asp:ListItem Value="2">02</asp:ListItem>
                                        <asp:ListItem Value="3">03</asp:ListItem>
                                        <asp:ListItem Value="4">04</asp:ListItem>
                                        <asp:ListItem Value="5">05</asp:ListItem>
                                        <asp:ListItem Value="6">06</asp:ListItem>
                                        <asp:ListItem Value="7">07</asp:ListItem>
                                        <asp:ListItem Value="8">08</asp:ListItem>
                                        <asp:ListItem Value="9">09</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="11">11</asp:ListItem>
                                        <asp:ListItem Value="12">12</asp:ListItem>
                                        <asp:ListItem Value="13">13</asp:ListItem>
                                        <asp:ListItem Value="14">14</asp:ListItem>
                                        <asp:ListItem Value="15">15</asp:ListItem>
                                        <asp:ListItem Value="16">16</asp:ListItem>
                                        <asp:ListItem Value="17">17</asp:ListItem>
                                        <asp:ListItem Value="18">18</asp:ListItem>
                                        <asp:ListItem Value="19">19</asp:ListItem>
                                        <asp:ListItem Value="20">20</asp:ListItem>
                                        <asp:ListItem Value="21">21</asp:ListItem>
                                        <asp:ListItem Value="22">22</asp:ListItem>
                                        <asp:ListItem Value="23">23</asp:ListItem>
                                        <asp:ListItem Value="24">24</asp:ListItem>
                                        <asp:ListItem Value="25">25</asp:ListItem>
                                        <asp:ListItem Value="26">26</asp:ListItem>
                                        <asp:ListItem Value="27">27</asp:ListItem>
                                        <asp:ListItem Value="28">28</asp:ListItem>
                                        <asp:ListItem Value="29">29</asp:ListItem>
                                        <asp:ListItem Value="30">30</asp:ListItem>
                                        <asp:ListItem Value="31">31</asp:ListItem>
                                    </N0:MOBILEDROPDOWNLIST>
                                    <N0:MOBILEDROPDOWNLIST class="selectHolder" id="FinishedMonth" runat="server">
                                        <asp:ListItem Value="1">01</asp:ListItem>
                                        <asp:ListItem Value="2">02</asp:ListItem>
                                        <asp:ListItem Value="3">03</asp:ListItem>
                                        <asp:ListItem Value="4">04</asp:ListItem>
                                        <asp:ListItem Value="5">05</asp:ListItem>
                                        <asp:ListItem Value="6">06</asp:ListItem>
                                        <asp:ListItem Value="7">07</asp:ListItem>
                                        <asp:ListItem Value="8">08</asp:ListItem>
                                        <asp:ListItem Value="9">09</asp:ListItem>
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="11">11</asp:ListItem>
                                        <asp:ListItem Value="12">12</asp:ListItem>
                                    </N0:MOBILEDROPDOWNLIST>
                                    <N0:MOBILEDROPDOWNLIST class="selectHolder" id="FinishedYear" runat="server">
                                            
                                    </N0:MOBILEDROPDOWNLIST>
                                    <N0:MOBILEDROPDOWNLIST class="selectHolder" id="FinishedTime" runat="server">
                                        <asp:ListItem Value="09:00">AM</asp:ListItem>
                                        <asp:ListItem Value="17:00">PM</asp:ListItem>
                                    </N0:MOBILEDROPDOWNLIST>
                                </td>
                            </tr>--%>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="QuantityLabel" runat="server" Font-Bold="True">Med 1 Quantity/Animal :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="QuantityOfMedicine" runat="server" EnableViewState="False">
                        <asp:ListItem Value="1">01</asp:ListItem>
                        <asp:ListItem Value="2">02</asp:ListItem>
                        <asp:ListItem Value="3">03</asp:ListItem>
                        <asp:ListItem Value="4">04</asp:ListItem>
                        <asp:ListItem Value="5">05</asp:ListItem>
                        <asp:ListItem Value="6">06</asp:ListItem>
                        <asp:ListItem Value="7">07</asp:ListItem>
                        <asp:ListItem Value="8">08</asp:ListItem>
                        <asp:ListItem Value="9">09</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="11">11</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                        <asp:ListItem Value="13">13</asp:ListItem>
                        <asp:ListItem Value="14">14</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="16">16</asp:ListItem>
                        <asp:ListItem Value="17">17</asp:ListItem>
                        <asp:ListItem Value="18">18</asp:ListItem>
                        <asp:ListItem Value="19">19</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="21">21</asp:ListItem>
                        <asp:ListItem Value="22">22</asp:ListItem>
                        <asp:ListItem Value="23">23</asp:ListItem>
                        <asp:ListItem Value="24">24</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="26">26</asp:ListItem>
                        <asp:ListItem Value="27">27</asp:ListItem>
                        <asp:ListItem Value="28">28</asp:ListItem>
                        <asp:ListItem Value="29">29</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="31">31</asp:ListItem>
                        <asp:ListItem Value="32">32</asp:ListItem>
                        <asp:ListItem Value="33">33</asp:ListItem>
                        <asp:ListItem Value="34">34</asp:ListItem>
                        <asp:ListItem Value="35">35</asp:ListItem>
                        <asp:ListItem Value="36">36</asp:ListItem>
                        <asp:ListItem Value="37">37</asp:ListItem>
                        <asp:ListItem Value="38">38</asp:ListItem>
                        <asp:ListItem Value="39">39</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                        <asp:ListItem Value="41">41</asp:ListItem>
                        <asp:ListItem Value="42">42</asp:ListItem>
                        <asp:ListItem Value="43">43</asp:ListItem>
                        <asp:ListItem Value="44">44</asp:ListItem>
                        <asp:ListItem Value="45">45</asp:ListItem>
                        <asp:ListItem Value="46">46</asp:ListItem>
                        <asp:ListItem Value="47">47</asp:ListItem>
                        <asp:ListItem Value="48">48</asp:ListItem>
                        <asp:ListItem Value="49">49</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="55">55</asp:ListItem>
                        <asp:ListItem Value="60">60</asp:ListItem>
                        <asp:ListItem Value="65">65</asp:ListItem>
                        <asp:ListItem Value="70">70</asp:ListItem>
                        <asp:ListItem Value="75">75</asp:ListItem>
                        <asp:ListItem Value="80">80</asp:ListItem>
                        <asp:ListItem Value="85">85</asp:ListItem>
                        <asp:ListItem Value="90">90</asp:ListItem>
                        <asp:ListItem Value="95">95</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                        <asp:ListItem Value="150">150</asp:ListItem>
                        <asp:ListItem Value="200">200</asp:ListItem>
                        <asp:ListItem Value="250">250</asp:ListItem>
                        <asp:ListItem Value="300">300</asp:ListItem>
                        <asp:ListItem Value="350">350</asp:ListItem>
                        <asp:ListItem Value="400">400</asp:ListItem>
                        <asp:ListItem Value="450">450</asp:ListItem>
                        <asp:ListItem Value="500">500</asp:ListItem>
                        <asp:ListItem Value="550">550</asp:ListItem>
                        <asp:ListItem Value="600">600</asp:ListItem>
                        <asp:ListItem Value="650">650</asp:ListItem>
                        <asp:ListItem Value="700">700</asp:ListItem>
                        <asp:ListItem Value="750">750</asp:ListItem>
                        <asp:ListItem Value="800">800</asp:ListItem>
                        <asp:ListItem Value="850">850</asp:ListItem>
                        <asp:ListItem Value="900">900</asp:ListItem>
                        <asp:ListItem Value="950">950</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Quantity2Label" runat="server" Font-Bold="True">Med 2 Quantity/Animal :</asp:Label>
                    </strong>   
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="QuantityOfMedicine2" runat="server" EnableViewState="False">
                        <asp:ListItem Value="1">01</asp:ListItem>
                        <asp:ListItem Value="2">02</asp:ListItem>
                        <asp:ListItem Value="3">03</asp:ListItem>
                        <asp:ListItem Value="4">04</asp:ListItem>
                        <asp:ListItem Value="5">05</asp:ListItem>
                        <asp:ListItem Value="6">06</asp:ListItem>
                        <asp:ListItem Value="7">07</asp:ListItem>
                        <asp:ListItem Value="8">08</asp:ListItem>
                        <asp:ListItem Value="9">09</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="11">11</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                        <asp:ListItem Value="13">13</asp:ListItem>
                        <asp:ListItem Value="14">14</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="16">16</asp:ListItem>
                        <asp:ListItem Value="17">17</asp:ListItem>
                        <asp:ListItem Value="18">18</asp:ListItem>
                        <asp:ListItem Value="19">19</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="21">21</asp:ListItem>
                        <asp:ListItem Value="22">22</asp:ListItem>
                        <asp:ListItem Value="23">23</asp:ListItem>
                        <asp:ListItem Value="24">24</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="26">26</asp:ListItem>
                        <asp:ListItem Value="27">27</asp:ListItem>
                        <asp:ListItem Value="28">28</asp:ListItem>
                        <asp:ListItem Value="29">29</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="31">31</asp:ListItem>
                        <asp:ListItem Value="32">32</asp:ListItem>
                        <asp:ListItem Value="33">33</asp:ListItem>
                        <asp:ListItem Value="34">34</asp:ListItem>
                        <asp:ListItem Value="35">35</asp:ListItem>
                        <asp:ListItem Value="36">36</asp:ListItem>
                        <asp:ListItem Value="37">37</asp:ListItem>
                        <asp:ListItem Value="38">38</asp:ListItem>
                        <asp:ListItem Value="39">39</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                        <asp:ListItem Value="41">41</asp:ListItem>
                        <asp:ListItem Value="42">42</asp:ListItem>
                        <asp:ListItem Value="43">43</asp:ListItem>
                        <asp:ListItem Value="44">44</asp:ListItem>
                        <asp:ListItem Value="45">45</asp:ListItem>
                        <asp:ListItem Value="46">46</asp:ListItem>
                        <asp:ListItem Value="47">47</asp:ListItem>
                        <asp:ListItem Value="48">48</asp:ListItem>
                        <asp:ListItem Value="49">49</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="55">55</asp:ListItem>
                        <asp:ListItem Value="60">60</asp:ListItem>
                        <asp:ListItem Value="65">65</asp:ListItem>
                        <asp:ListItem Value="70">70</asp:ListItem>
                        <asp:ListItem Value="75">75</asp:ListItem>
                        <asp:ListItem Value="80">80</asp:ListItem>
                        <asp:ListItem Value="85">85</asp:ListItem>
                        <asp:ListItem Value="90">90</asp:ListItem>
                        <asp:ListItem Value="95">95</asp:ListItem>
                        <asp:ListItem Value="100">100</asp:ListItem>
                        <asp:ListItem Value="150">150</asp:ListItem>
                        <asp:ListItem Value="200">200</asp:ListItem>
                        <asp:ListItem Value="250">250</asp:ListItem>
                        <asp:ListItem Value="300">300</asp:ListItem>
                        <asp:ListItem Value="350">350</asp:ListItem>
                        <asp:ListItem Value="400">400</asp:ListItem>
                        <asp:ListItem Value="450">450</asp:ListItem>
                        <asp:ListItem Value="500">500</asp:ListItem>
                        <asp:ListItem Value="550">550</asp:ListItem>
                        <asp:ListItem Value="600">600</asp:ListItem>
                        <asp:ListItem Value="650">650</asp:ListItem>
                        <asp:ListItem Value="700">700</asp:ListItem>
                        <asp:ListItem Value="750">750</asp:ListItem>
                        <asp:ListItem Value="800">800</asp:ListItem>
                        <asp:ListItem Value="850">850</asp:ListItem>
                        <asp:ListItem Value="900">900</asp:ListItem>
                        <asp:ListItem Value="950">950</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label15" runat="server" Font-Bold="True">Activity :</asp:Label></td>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="Activity" runat="server" DataTextField="TypeName" DataValueField="TypeID"></n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="MastitisLabel" runat="server" Font-Bold="True">Quarter :</asp:Label></td>
                    </strong>
                                        
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="UdderQuarter" runat="server">
                        <asp:ListItem Value="0">N/A</asp:ListItem>
                        <asp:ListItem Value="1">LF</asp:ListItem>
                        <asp:ListItem Value="2">RF</asp:ListItem>
                        <asp:ListItem Value="3">LH</asp:ListItem>
                        <asp:ListItem Value="4">RH</asp:ListItem>
                        <asp:ListItem Value="5">LF_RF</asp:ListItem>
                        <asp:ListItem Value="6">LF_LH</asp:ListItem>
                        <asp:ListItem Value="7">LF_RH</asp:ListItem>
                        <asp:ListItem Value="8">RF_LH</asp:ListItem>
                        <asp:ListItem Value="9">RF_RH</asp:ListItem>
                        <asp:ListItem Value="10">LH_RH</asp:ListItem>
                        <asp:ListItem Value="11">LF_RF_LH</asp:ListItem>
                        <asp:ListItem Value="12">LF_LH_RH</asp:ListItem>
                        <asp:ListItem Value="13">RF_LH_RH</asp:ListItem>
                        <asp:ListItem Value="14">LF_RF_RH</asp:ListItem>
                        <asp:ListItem Value="15">All</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="NotesLabel" runat="server" Font-Bold="True">Notes :</asp:Label></td>
                    </strong>                    
                    <asp:TextBox ID="VetNotes" class="form-control input-sm" runat="server" MaxLength="50" Height="100px" Width="200%" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
            <div align="center">
                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Treatment</a>
            </div>
        </div>
    </div>

    <script type = "text/javascript">

        var db;
        var isCommitted;

        function checkInput() 
        {
            var pType = "Treatment";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";
            var HerdID = sessionStorage.getItem('HerdID');

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
        }


        function submit()
        {
            var pType = "Treatment";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

			//var opts = document.forms[0].AnimalList;
           
			//if (opts) {
			//	document.forms[0].HidAnimalList.value = opts.value;
			//	document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
			//	if (document.forms[0].HidAnimalList.value == "0") {
			//		App.alert("Please Select","Please select or type a cow number");
			//		return false;
			//	}
			//	if (processForm() == false) {
			//		return false;
			//	}
			//}
		   
			var scorelist='';
			//this is commented out until the database supports it
			//if (getLocation == true)
			//    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			//else
			WriteFormValues("TreatmentPage.aspx?Type=Add" + pType  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

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
			else  {
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
            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                    function (transaction, results) {
                        //var listBox = document.getElementById("EIDAnimalList");
                        //var opt = document.createElement("option");

                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) {

                            var row = results.rows.item(0);
                            if (row.Exception != '') {
                                App.alert("Exception", row.Exception);
                            }
                            if (row.withdrawalDate != '') {
                                alertWithdrawal(row.WithdrawalDate);
                            }
                           
                                //if (document.getElementById("EIDAnimalList") != null) {
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
                            App.message(tag + "Animal not found")
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
            db = OpenDatabase();
            if (!db) 
            {
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
            if (isEID == 0) 
            {
                var theTextBox = document.getElementById("filterInput");
                //   theTextBox.style["width"] = "220px";
            } 
            SetDates('Treatment');
            var HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) 
            {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
            //FillDynamicList("AnimalList", "AnimalList", HerdID, 0, defaultAnimalID);
           
            if (defaultAnimalID) 
            {
                seachOnAnimalID(defaultAnimalID);
            }
            
            FillDynamicList("<%=TreatmentReason.ClientID%>",'TreatmentReason',HerdID,0);
            FillDynamicList("<%=DoneByBox.ClientID%>", "DoneBy", HerdID, 0);
            FillDynamicList("<%=MedTreatment.ClientID%>", "MedicineList", HerdID, 0);
            FillDynamicList("<%=MedTreatment2.ClientID%>", "MedicineList", HerdID, 0,"0");
            
            
           
            if (isEID == 1) 
            {
            
                document.getElementById('selectedAnimalsTable').style.display = 'block';
      
                if(document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }
            }

            //
            var searchInput = document.getElementById("CowNumber");
            searchInput.disabled = true;
            changeSearchPlaceHolder("Record Treatment");
            //
        }


        function seachOnAnimalID(animalID)
        {
            var HerdID = sessionStorage.getItem('HerdID');
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

                            //if(document.getElementById('EIDEntryPanel')){
                            //    if((document.getElementById("EIDAnimalList").options.length)!=0){
                            //        document.getElementById("TreatHistoryText").firstChild.data = row.TreatmentText;
                            //    }
                            //}
                            //else{
                            //    document.getElementById("TreatHistoryText").firstChild.data = row.TreatmentText;
                            //}
                            
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
                App.alert("Enter", "Please enter 1 or more cow numbers seperated by a comma");
                return false;
            }
            if (searchFB(filterInput, false) == false) {
                return false;
            }
        }

        function searchFB(filterInput, postEntry)
        {
            var HerdID = sessionStorage.getItem('HerdID');
            // Search database Datastore
            var sql = "SELECT * FROM Cows where (FreezeBrand = '" + filterInput + "' AND InternalHerdID = " + HerdID + ")";
            var extraFilter = sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                sql += extraFilter;
            }
            db.transaction(function (transaction)
            {
                transaction.executeSql(sql, [],
                    function (transaction, results)
                    {
                        // results.rows holds the rows returned by the query
                        if (results.rows.length == 1) {
                            var row = results.rows.item(0);

                            document.forms[0].HidAnimalList.value = row.InternalAnimalID;
                            document.forms[0].HidAnimalNos.value = row.FreezeBrand;

                            setSelectedIndex(document.getElementById("AnimalList"), row.InternalAnimalID);
                            if (postEntry == false)
                            {
                                document.getElementById("TreatHistoryText").firstChild.data = row.TreatmentText;        
                            }
                            else
                            {
                                // Write the form to the offline cache
                                if (processForm() == false)
                                {
                                    return false;
                                }
                                WriteFormValues("TreatmentPage.aspx?Type=AddTreatment&HerdID=" + HerdID, document.forms[0], document.forms[0].HidTitle.value);
                                if("<%=Master.IsEID%>" == "1")  {
                                    App.message("Treatment has been recorded and will be transferred at next synchronisation");
                                }
                                else {
                                    App.alert("Result", "Treatment has been recorded and will be transferred at next synchronisation");
                                }
                                isCommitted = 1;
                            }
                        }
                        else if (results.rows.length > 1) {
                            App.alert("Cow Found","More than one matching cow found " + results.rows.length);
                            return false;
                        }
                        else
                        {  
                            return (searchTag(filterInput));                       
                        }
                    },
                      function (transaction, error) {
                          App.alert("Error","Could not read: " + error.message);
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


        //function readNfcTag(nfcTagNumber)
        //{
        //      var decimal=nfcTagNumber;
        //      //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0))
        //      //{                 
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
        //                              alertWithdrawal(row.WithdrawalDate,"Treatment");
        //                          }
                                
        //                              if (skip == false) {
        //                                  var exists=false;
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

        function processForm(pEventType) {

            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("No selection", "No group selected");
                    return false;
                }
            }

            if (ValidateTreatmentDates() == false) {
                return false;
            }
            // Check start date < end date
            var startDate = new Date();
            var endDate = new Date();
            endDate = document.getElementById("TreatmentDateFinishedinput").value;
            //endDate.setFullYear(document.forms[0].FinishedYear.value,
            //	document.forms[0].FinishedMonth.value -1, document.forms[0].FinishedDay.value);
            startDate = document.getElementById("Treatmentinputdate").value;
            //startDate.setFullYear(document.forms[0].TreatmentYear.value,
            //	document.forms[0].TreatmentMonth.value - 1,document.forms[0].TreatmentDay.value);
            if (endDate < startDate) {
                alert("Treatment finish date is less than treatment start date, please check");
                return false;
            }
            // Check activity or medicine selected
            if ((document.forms[0].MedTreatment.value == "0") && (document.forms[0].Activity.value == "0")) {
                alert("You must select either a medicine OR an activity");
                return false;
            }

            document.forms[0].IsSubmitted.value = true;
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

    </script>

</asp:Content>
