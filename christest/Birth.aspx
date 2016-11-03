<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="Birth.aspx.cs" Inherits="HybridAppWeb.Birth" %>

<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <asp:Panel ID="HolsteinPanel" Visible="false" runat="server">
            <tbody>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Width="71px">Concept
                                            Date:</asp:Label></td>
                    <td colspan="4">
                        <n0:MOBILEDROPDOWNLIST class="selectHolder" id="ConceptionDay" runat="server" EnableViewState="False">
                            <asp:ListItem Value="0">N/A</asp:ListItem>
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
                        </n0:MOBILEDROPDOWNLIST>
                        <n0:MOBILEDROPDOWNLIST class="selectHolder" id="ConceptionMonth" runat="server" EnableViewState="False">
                            <asp:ListItem Value="0">N/A</asp:ListItem>
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
                        </n0:MOBILEDROPDOWNLIST>
                        <n0:MOBILEDROPDOWNLIST class="selectHolder" id="ConceptionYear" runat="server" EnableViewState="False">
                            <asp:ListItem Value="0">N/A</asp:ListItem>
                            <asp:ListItem Value="2008">2008</asp:ListItem>
                            <asp:ListItem Value="2009">2009</asp:ListItem>
                            <asp:ListItem Value="2010">2010</asp:ListItem>
                            <asp:ListItem Value="2011">2011</asp:ListItem>
                            <asp:ListItem Value="2012">2012</asp:ListItem>
                            <asp:ListItem Value="2013">2013</asp:ListItem>
                            <asp:ListItem Value="2014">2014</asp:ListItem>
                            <asp:ListItem Value="2015">2015</asp:ListItem>
                        </n0:MOBILEDROPDOWNLIST>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Font-Bold="True" Width="70px">Calf
                                            Serial No:</asp:Label></td>
                    <td>
                        <asp:TextBox ID="SerialNo" runat="server" Width="33px" MaxLength="4"></asp:TextBox>
                    </td>
                    <td></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Bold="True">Dam: </asp:Label></td>
                    <td colspan="3">
                        <asp:Label ID="DamLabel" runat="server"></asp:Label></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Font-Bold="True">Twin Info:</asp:Label></td>
                    <td colspan="3">
                        <asp:DropDownList class="selectHolder" ID="TwinInfo" runat="server" EnableViewState="False">
                            <asp:ListItem Value="N">None</asp:ListItem>
                            <asp:ListItem Value="TB">Twin(other bull)</asp:ListItem>
                            <asp:ListItem Value="TH">Twin(other heifer)</asp:ListItem>
                            <asp:ListItem Value="TBH">Triplet(others 1 heifer 1 bull)</asp:ListItem>
                            <asp:ListItem Value="TBB">Triplet(others both bulls)</asp:ListItem>
                            <asp:ListItem Value="THH">Triplet(others both heifers)</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Font-Bold="True">Sup Registry:</asp:Label></td>
                    <td>
                        <asp:DropDownList class="selectHolder" ID="SRGrade" runat="server" EnableViewState="False">
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="A">A</asp:ListItem>
                            <asp:ListItem Value="B">B</asp:ListItem>
                            <asp:ListItem Value="A">C</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td colspan="2"></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:CheckBox ID="HolsteinCheckBox" runat="server" Width="176px" Text="Tick to register with HUK" Font-Bold="True"></asp:CheckBox>
                    </td>
                    <td colspan="2"></td>
                    <td></td>
                </tr>
            </tbody>
        </asp:Panel>

    <asp:Panel ID="BirthPanel" Visible="false" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <div class="row">
                        <div class="form-group col-xs-6">
                            Select if no calf,stillborn or slaughtered
                               <n0:MobileDropDownList ID="CalfStillBornNotes" runat="server" class="form-control">
                               </n0:MobileDropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="FreezeBrandLabel" runat="server" Font-Bold="True" Width="86px">Calf FB:</asp:Label>
                            </p>
                            <asp:TextBox ID="CalfFreezeBrand" class="form-control input-sm" runat="server" MaxLength="10"></asp:TextBox>
                        </div>

                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="Label1" runat="server" Font-Bold="True">Calf Eartag:</asp:Label>
                            </p>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="CalfEarTag" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
                        </div>

                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="Label2" runat="server" Font-Bold="True">Sex of the calf:</asp:Label>
                            </p>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="Sex" runat="server" EnableViewState="False">
                                <asp:ListItem Value="Female" selected="true">Female</asp:ListItem>
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Bull">Bull</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="Label12" runat="server" Font-Bold="True">Breed of calf:</asp:Label>
                            </p>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="Breed" runat="server"></n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="Label11" runat="server" Font-Bold="True">Colour of the calf:</asp:Label>
                            </p>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="Colour" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="NameLabel" runat="server" Font-Bold="True" Width="86px">Calf Name (no Prefix or Serial):</asp:Label>
                            </p>
                            <asp:TextBox ID="Name" runat="server" Width="500px" MaxLength="40" Height="32px"></asp:TextBox>
                        </div>
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="Label13" runat="server" Font-Bold="True">Birth Diff</asp:Label>
                            </p>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="BirthDifficulty" runat="server" EnableViewState="False">
                                <asp:ListItem Value="NoAssistance">No Assist</asp:ListItem>
                                <asp:ListItem Value="SlightAssistance">Moderate Farm Assist</asp:ListItem>
                                <asp:ListItem Value="Assistance">Moderate Vet Assist</asp:ListItem>
                                <asp:ListItem Value="Difficult">Difficult Farmer Assist</asp:ListItem>
                                <asp:ListItem Value="VetAssistance">Difficult Vet Assist</asp:ListItem>
                                <asp:ListItem Value="Ceasarian">Ceasarian</asp:ListItem>
                                <asp:ListItem Value="StillBorn">Still Born</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <asp:Label ID="Label3" runat="server" Font-Bold="True">Calf for
                                            breeding:</asp:Label>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="KeepForBreeding" runat="server" EnableViewState="False">
                                <asp:ListItem Value="No">No</asp:ListItem>
                                <asp:ListItem Value="Yes" Selected="True">Yes</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>

                        </div>
                        <div class="form-group col-xs-6">

                            <p>
                                <asp:Label ID="Label10" runat="server" Font-Bold="True">Paternity
                                                Type</asp:Label>
                            </p>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="PaternityType" runat="server" EnableViewState="False">
                                <asp:ListItem Value="Natural">Natural</asp:ListItem>
                                <asp:ListItem Value="Straw" selected="True">Straw</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <asp:Label ID="SireEarTagLabel" runat="server" Font-Bold="True">Sire Ear Tag:</asp:Label>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="BullBirthEarTag" runat="server"></n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <p>
                                <asp:Label ID="Label9" runat="server" Font-Bold="True">Aft Birth</asp:Label>
                            </p>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="AfterBirthDelivered" runat="server" EnableViewState="False">
                                <asp:ListItem Value="No">No</asp:ListItem>
                                <asp:ListItem Value="Yes" Selected="True">Yes</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">

                            <asp:Label ID="SireNameLabel" runat="server" Font-Bold="True">Sire
                                            Name:</asp:Label>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="BirthNameOfServiceList" runat="server"></n0:MOBILEDROPDOWNLIST>
                            <div style="margin-top: 5px"></div>
                            <asp:TextBox ID="SireName" CssClass="form-control input-sm" runat="server" MaxLength="60"></asp:TextBox>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="SireList1" runat="server" DataTextField="DisplayText" DataValueField="SireStockID"></n0:MOBILEDROPDOWNLIST>

                            <asp:CheckBox ID="AphisBirthCheckBox" runat="server" Width="300px" Text="Tick to register with Aphis / BCMS" Font-Bold="True" Checked="True"></asp:CheckBox>

                            <asp:CheckBox ID="BreedCheckBox" runat="server" Width="300px" Text="Tick to stop breeding this cow" Font-Bold="True"></asp:CheckBox>

                        </div>
                    </div>
                </div>
            </div>
            <p align="center">
                <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput('Birth');">Save Birth</a>
            </p>

            <td valign="top"></td>

        </asp:Panel>

    <asp:Panel ID="LambingPanel" Visible="true" runat="server">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <strong>
                                <asp:Label ID="Label6789" runat="server" Font-Bold="True"><%=Master.Mother%> EID :</asp:Label>
                            </strong>
                            <asp:TextBox ID="DamEIDTag" runat="server" readonly="true" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="form-group col-xs-6">
                            <strong>
                                <asp:Label ID="Label27" runat="server" Font-Bold="True">Visible Tag :</asp:Label>
                            </strong>
                            <asp:TextBox ID="DamNationalID" CssClass="form-control" runat="server" MaxLength="20"></asp:TextBox>
                        </div>
                    </div>
                    <span id="MgmtTag">_</span>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <strong>
                                <asp:Label ID="Label28" runat="server" Font-Bold="True">Birth Diff :</asp:Label>
                            </strong>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="EIDBirthDifficulty" runat="server" EnableViewState="False">
                                <asp:ListItem Value="0">No Assist</asp:ListItem>
                                <asp:ListItem Value="1">Moderate Farm Assist</asp:ListItem>
                                <asp:ListItem Value="2">Moderate Vet Assist</asp:ListItem>
                                <asp:ListItem Value="3">Difficult Farmer Assist</asp:ListItem>
                                <asp:ListItem Value="4">Difficult Vet Assist</asp:ListItem>
                                <asp:ListItem Value="5">Ceasarian</asp:ListItem>
                                <asp:ListItem Value="6">Still Born</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <strong>
                                <asp:Label ID="Label29" runat="server" Font-Bold="True">Aft Birth :</asp:Label>
                            </strong>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="EIDAfterBirthDelivered" runat="server" EnableViewState="False">
                                <asp:ListItem Value="No">No</asp:ListItem>
                                <asp:ListItem Value="Yes" Selected="True">Yes</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>

                    <div align="center">

                        <a href="#" id="ReadLambs" class="btn btn-primary waves-effect waves-light" onclick="scanChildTag();">Read <%=Master.Child%> Tags</a>
                        <%--<a href="#" onclick="insertRow();" class="btn btn-primary waves-effect waves-light"><i class="material-icons">add</i></a>--%>
                    </div>
                    <br />

                    <div class="row">
                        <div class="form-group col-xs-12">
                            <div id="lambingTable">

                            </div>
                        </div>
                    </div>

                    <%--<div class="row">
                        <div class="form-group col-xs-12">
                            <table class="dataGrid" align="center" id="LambTable" style="font-family: Times New Roman; border-collapse: collapse" cellspacing="0" rules="all" border="1">
                                <tbody>
                                    <tr style="font-weight: bold; color: white; background-color: #ffcc66">
                                        <td id="T1"><%=Master.Child%></td>
                                        <td id="T2">Male?</td>
                                        <td id="T3">Wght</td>
                                        <td id="T4">Lmbing Ease</td>
                                        <td id="T5">Vigr</td>
                                        <td id="T6">InTrn Eyes</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>--%>

                    <div class="row">
                        <div class="form-group col-xs-6">
                            <strong><%=Master.Child%>Breed :</strong>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="LambBreed" runat="server" DataValueField="ShortBreed" DataTextField="DisplayText"></n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <asp:CheckBox ID="BirthCrossCheckBox" runat="server" Text="Is Cross?" Font-Bold="True"></asp:CheckBox>
                            <strong>Stillborns :</strong>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="Fatalities" runat="server" EnableViewState="False">
                                <asp:ListItem Value="0" Selected="True">0</asp:ListItem>
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <strong><%=Master.Father%> :</strong>

                            <n0:MOBILEDROPDOWNLIST class="form-control" id="RamTag" runat="server" DataValueField="SireNationalID" DataTextField="SireDisplay"></n0:MOBILEDROPDOWNLIST>

                        </div>
                    </div>
                    <div align="center">
                        <br></br>
                        <a href="#" id="AddLambing" class="btn btn-primary waves-effect waves-light" onclick="addLambing('<%=Master.herdID%> ');">Add Birth</a>
                    </div>
                </div>
            </div>
        </asp:Panel>

    <script type = "text/javascript">

        var db;
        var scanChild=false;

        function checkInput() {
            var herdID = sessionStorage.getItem('HerdID');
            var isEID = "<%=Master.IsEID%>";
            if(isEID==1){
                if(document.getElementById("<%=DamEIDTag.ClientID%>").value == "") 
                {
                    App.message("No Ewe ID scanned");
                    return false;
                }
            }
            document.forms[0].HidTitle.value = "Recorded Birth animals";
            WriteFormValues("Birth.aspx?Type=AddEIDBirth"  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
            var msg ="Birth has been recorded and will be transferred at next synchronisation";
            if(isEID==1)  App.message(msg); 
                else
                App.alert("Result", msg);
            
            document.getElementById("form1").reset();
        }

        function scanChildTag(){
            scanChild=true;
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
                            
                                nfcEidBirth(row.Exception, row.ElectronicID, row.NationalID, row.FreezeBrand, row.LastCalvedDate, row.Alert, row.LastServedTo, row.Group);
                        }
                        else {
                            App.alert("Result","No records found");
                        }
                    },
                 function (transaction, error) {
                     App.alert("Error","Could not read: " + error.message);
                 });
                });
            }
            else {
                App.alert("Database", 'Cant open database');
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
                                              var skip = false;

                                              if(row.Exception!=''){
                                                  App.alert("Exception",row.Exception);
                                              }
                                              if(row.withdrawalDate!=''){
                                                  alertWithdrawal(row.WithdrawalDate);
                                              }
                                              if (scanChild) {
                                                  App.message(tag + " in database already");
                                              } else 
                                              {
                                                  EidBirth(row.Exception, tag, row.NationalID, row.FreezeBrand, row.LastCalvedDate, row.Alert, row.LastServedTo, row.Group);                                                                                                
                                              }

                                          }
                                          else{
                                              if(scanChild) addLamb(tag);
                                          }
                                      },
                           function(transaction, error) {
                               App.alert("Error","Could not read: " + error.message);
                           });
                              });
        }


        <%--function readNfcTag(nfcTagNumber)
        {
            var herdID=sessionStorage.getItem('HerdID');
             var decimal=nfcTagNumber;
              var child="<%=Master.Child%>";
             //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0)) {
                  
                 var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + herdID + ")";
                  db.transaction(function(transaction) {
                      transaction.executeSql(sql, [],
                          function(transaction, results) {
                              //var listBox = document.getElementById("EIDAnimalList");
                              //var opt = document.createElement("option");
                              
                              // results.rows holds the rows returned by the query
                              if (results.rows.length == 1) {
                                  var row = results.rows.item(0);
                                  var skip = false;
                                 
                                  if(row.Exception!=''){
                                      App.alert("Exception",row.Exception);
                                  }
                                  if(row.WithdrawalDate!=''){
                                      Master.alertWithdrawal(row.WithdrawalDate,"EIDBirth");
                                  }
                                  if (child) {
                                      App.message(decimal + " in database already");
                                  } else { 
                                      EidBirth(row.Exception, row.ElectronicID, row.NationalID, row.FreezeBrand, row.LastCalvedDate, row.Alert, row.LastServedTo, row.Group);
                                    
                                  }
                              }
                        },
                          function(transaction, error) {
                              App.alert("Error","Could not read: " + error.message);
                          });
                });

            //}
         }--%>


        function EidBirth(pException,pEIDTag,pDamNationalID,pFreezeBrand,pLastCalvedDate,pAlert,pAssocRam,pGroup)
        {
            var table = document.getElementById("LambTable");
            var rowCount = table.rows.length;
            // Delete any lambs needing to be written
            //for(var k=1; k<rowCount; k++) {
            //    table.deleteRow(k);
            //    rowCount--;
            //    k--;
            //}
            if(pException) {
                App.alert("Exception", pException);
            }
            if (pAlert == "1") {
                App.alert("Success","You have configured FarmWizard to alert you of group " + pGroup);
            }
            // Check when last lambed
            if(pLastCalvedDate) {
                var lastLambedOn=new Date(pLastCalvedDate.substring(6),
                             pLastCalvedDate.substring(3,5) - 1,pLastCalvedDate.substring(0,2));
                var today = new Date();
                var days = (today.getTime() - lastLambedOn.getTime())/86400000;
                if(days < 200) {
                    App.alert("Result", "Dam recently lambed on " + pLastCalvedDate);
                    return;
                }
            }
            var damEidTag=document.getElementById("<%=DamEIDTag.ClientID%>").value;
            var damNationalID=document.getElementById("<%=DamNationalID.ClientID%>").value;
            if((damEidTag=="")&&(damNationalID=="")){
                document.getElementById("<%=DamEIDTag.ClientID%>").value = pEIDTag;
                document.getElementById("<%=DamNationalID.ClientID%>").value = pDamNationalID;
                document.getElementById("MgmtTag").firstChild.data = pFreezeBrand;
            }
            else{
                addLamb(pEIDTag);
            }
            if(pAssocRam) {
                setSelectedIndex(document.getElementById("<%=RamTag.ClientID%>"),pAssocRam);
            }
        }


        function initPage() 
        {          
            var isEID = "<%=Master.IsEID%>";
            var eventType;
            if(isEID == 1)
            {
                eventType = "EIDBirth";
            }
            else
            {
                eventType = "Birth";
            }

            db = OpenDatabase();
            if (!db) {
                alert("Cannot open database");
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

            SetDates(eventType);
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName) {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }
            // If animalID is set then get it
            var defaultAnimalID = sessionStorage.getItem('InternalAnimalID');

            // Fill up the various lists
            //FillDynamicList("AnimalList", "AnimalList", HerdID, 1, defaultAnimalID);
            
            //FillDynamicList("DoneObservedBy", "DoneObservedBy", HerdID,0);
            
           <%-- if (eventType == "Birth") {
                //FillDynamicList("<%=CalfEarTag.ClientID%>", "CalfEarTag", HerdID, 0);
                //FillDynamicList("<%=Breed.ClientID%>", "Breed", HerdID, 0);
                //FillDynamicList("<%=BullBirthEarTag.ClientID%>", "BullBirthEarTag", HerdID, 0, "N/A");
                
                // Set selected index of bull birth ear tag to be 0
                //FillDynamicList("<%=SireList1.ClientID%>", "SireList", HerdID, 0);             
            }--%>


            <%--if (isEID == 1) {
                document.getElementById('selectedAnimalsTable').style.display = 'block';
                //document.getElementById('StartScanButton').style.display = 'none';
                //hideSelect(document.getElementById('StartScanButton')); // 
                if(<%=Master.IsInnova%> == "0") {
                    if(document.getElementById('Lambtable')){
                        document.getElementById('T4').style.display = 'none';
                        document.getElementById('T5').style.display = 'none';
                        document.getElementById('T6').style.display = 'none';
                    }// if
                }// if
            }// if--%>

            /////
            var tableID = "LambTable";
            var table1 = document.getElementById(tableID);
            if (table1 == null) {
                createTable();
            }
            /////
        }// initPage



        function createTable() {
            var tableID = "LambTable";
            var table = document.createElement('table');
            table.id = tableID;
            table.style.padding = "4px";
            table.style.margin = "4px";

            ////////////////////////////////////////
            var header = table.createTHead();
            var row = header.insertRow(0);
            var cell = document.createElement('th');
            cell.innerHTML = "<%=Master.Child%>";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            row.appendChild(cell);

            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Male?";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Wght";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Lmbing Ease";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "Vigr";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);

            var header = table.createTHead();
            var tr = table.tHead.children[0];
            var cell = document.createElement('th');
            cell.innerHTML = "InTrn Eyes";
            cell.style.padding = "5px";
            cell.style.margin = "5px";
            tr.appendChild(cell);
            ////////////////////////////////////////

            var newtbody = document.createElement('tbody');
            table.appendChild(newtbody);

            //add the table to the DOM
            document.getElementById('lambingTable').appendChild(table);
        }// createTable


        // to come back too
        //function insertRow()
        //{
        //    var tableID = "LambTable";
        //    var table = document.getElementById(tableID);
        //    var tbody = table.getElementsByTagName("tbody")[0];
        //    var rowCount = tbody.rows.length;
        //    var row = tbody.insertRow(-1);

        //    var InternalIDHidCell = row.insertCell(0);
        //    var element9 = document.createElement("input");
        //    element9.type = "number";
        //    //element9.value = value;
        //    element9.style.width = '60px';
        //    element9.align = "center";
        //    InternalIDHidCell.appendChild(element9);

        //    var cell2 = row.insertCell(1);
        //    var checkbox = document.createElement('input');
        //    checkbox.type = "checkbox";
        //    checkbox.name = "name";
        //    checkbox.value = "value";
        //    checkbox.id = "id";    
        //    cell2.appendChild(checkbox);

        //    var cell5 = row.insertCell(6);
        //    var element8 = document.createElement("input");
        //    element8.id = "myCheckbox" + InternalID;
        //    element8.type = "checkbox";
        //    element8.style.textAlign = "center";
        //    //
        //    var label = document.createElement("label");
        //    label.setAttribute("for", element8.id);
        //    //
        //    cell5.appendChild(element8);
        //    cell5.appendChild(label);


        //    var cell2 = row.insertCell(2);
        //    var element9 = document.createElement("input");
        //    element9.type = "number";
        //    //element9.value = value;
        //    element9.style.width = '60px';
        //    element9.align = "center";
        //    cell2.appendChild(element9);

        //    var cell2 = row.insertCell(3);
        //    var element9 = document.createElement("input");
        //    element9.type = "number";
        //    //element9.value = value;
        //    element9.style.width = '60px';
        //    element9.align = "center";
        //    cell2.appendChild(element9);

        //    var cell2 = row.insertCell(4);
        //    var element9 = document.createElement("input");
        //    element9.type = "number";
        //    //element9.value = value;
        //    element9.style.width = '60px';
        //    element9.align = "center";
        //    cell2.appendChild(element9);

        //    var cell2 = row.insertCell(5);
        //    var element9 = document.createElement("input");
        //    element9.type = "number";
        //    //element9.value = value;
        //    element9.style.width = '60px';
        //    element9.align = "center";
        //    cell2.appendChild(element9);

        //    var newCell = row.insertCell(6);
        //    newCell.style.padding = "5px";
        //    newCell.style.margin = "5px";
        //    var deletebtn = document.createElement("button");
        //    deletebtn.className = "btn btn-danger btn-xs";
        //    deletebtn.appendChild(document.createTextNode("delete"));
        //    deletebtn.onclick = function () {
        //        deleteFromList(cells[0].innerText, cells[1].innerText, true);
        //        return false;
        //    };
        //    newCell.appendChild(deletebtn);
        //}



        function addLambing() {
            var lambList = "";

            var table = document.getElementById("LambTable");
            var rowCount = table.rows.length;
         
            for(var i=1; i<rowCount; i++) {
                var row = table.rows[i];
                lambList = lambList + row.cells[0].childNodes[0].value;
                var chkbox = row.cells[1].childNodes[0];
                if(null != chkbox && true == chkbox.checked) {
                    lambList = lambList + ",M";
                }
                else {
                    lambList = lambList + ",F";
                }
               
                lambList = lambList + "," + row.cells[2].childNodes[0].value;
               
                if(row.cells[3]) {
                    lambList = lambList + "," + row.cells[3].childNodes[0].value;
                }
                if(row.cells[4]) {
                    lambList = lambList + "," + row.cells[4].childNodes[0].value;
                }
               
                if(row.cells[5]) {
                    lambList = lambList + "," + row.cells[5].childNodes[0].value;
                }
               
                if(i<rowCount) {
                    lambList = lambList + ":";
                }
            }
            if(lambList) {
                document.forms[0].LambList.value = lambList;
            }

            for(var k=1; k<rowCount; k++) {
                table.deleteRow(k);
                rowCount--;
                k--;
            }

            return(checkInput());


        }
    

        function manSearchAdd() 
        {
            var tagNo = document.getElementById("ManTag").value;
            //if (tagNo == '') {
            //    tagNo = document.getElementById("FullNumberList").value;
            //}       
            var herdID = sessionStorage.getItem('HerdID');
       
            var sql =  "SELECT * FROM Cows where NationalID like '%" + tagNo + "%' and InternalHerdID = '" + herdID + "'";
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
                        //    if(row.Exception!=''){
                        //        App.alert("Exception",row.Exception);
                        //    }
                        //    if(row.WithdrawalDate!=''){
                        //        alertWithdrawal(row.WithdrawalDate);
                        //    }
                          
                        //    nfcEidBirth(row.Exception, row.ElectronicID, row.NationalID,row.FreezeBrand,row.LastCalvedDate,row.Alert,row.LastServedTo,row.Group);                                  
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

    
        function manSearchSelect()
        {    
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
                            if(row.Exception!=''){
                                App.alert("Exception",row.Exception);
                            }
                            if(row.WithdrawalDate!=''){
                                alertWithdrawal(row.WithdrawalDate);
                            }
                          
                            nfcEidBirth(row.Exception, row.ElectronicID, row.NationalID,row.FreezeBrand,row.LastCalvedDate,row.Alert,row.LastServedTo,row.Group);                                  
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


        function nfcEidBirth(pException,pEIDTag,pDamNationalID,pFreezeBrand,pLastCalvedDate,pAlert,pAssocRam,pGroup)
        {
            var table = document.getElementById("LambTable");
            var rowCount = table.rows.length;
            // Delete any lambs needing to be written
            //for(var k=1; k<rowCount; k++) {
            //    table.deleteRow(k);
            //    rowCount--;
            //    k--;
            //}
            if(pException) {
                alert(pException);
            }
            if (pAlert == "1") {
                alert("You have configured FarmWizard to alert you of group " + pGroup);
            }
            // Check when last lambed
            if(pLastCalvedDate) {
                var lastLambedOn=new Date(pLastCalvedDate.substring(6),
                             pLastCalvedDate.substring(3,5) - 1,pLastCalvedDate.substring(0,2));
                var today = new Date();
                var days = (today.getTime() - lastLambedOn.getTime())/86400000;
                if(days < 200) {
                    alert("Dam recently lambed on " + pLastCalvedDate);
                    return;
                }
            }
            var damEidTag=document.getElementById("<%=DamEIDTag.ClientID%>").value;
            var damNationalID=document.getElementById("<%=DamNationalID.ClientID%>").value;
            if((damEidTag=="")&&(damNationalID=="")){
                document.getElementById("<%=DamEIDTag.ClientID%>").value = pEIDTag;
                document.getElementById("<%=DamNationalID.ClientID%>").value = pDamNationalID;
                document.getElementById("MgmtTag").firstChild.data = pFreezeBrand;
            }
            else{
                addLamb(pEIDTag);
            }
            if(pAssocRam) {
                setSelectedIndex(document.getElementById("<%=RamTag.ClientID%>"),pAssocRam);
            }
        }

          function addLamb(pTagNo)
          {
              var search;
              var i;
              var tagCnt = 0;
              var addedTags=new Array();

              // Delete any rows to start with
              // var table = document.getElementById("LambTable");
              // var rowCount = table.rows.length;

              var tableID = "LambTable";
              var table = document.getElementById(tableID);
              var tbody = table.getElementsByTagName("tbody")[0];
              var rowCount = tbody.rows.length;

              if(pTagNo == document.getElementById("<%=DamEIDTag.ClientID%>").value) {
                  alert("Ewe tag scanned");
                  return;
              }
              else {
                  // check if already added
                  for(var i=1; i<rowCount; i++) {
                      var erow = table.rows[i];
                      var lamb = erow.cells[0].childNodes[0].value;
                      if(lamb == pTagNo) {
                          alert("Lamb already scanned");
                          return;
                      }
                  }

                  //var row = table.insertRow(rowCount);
                  var row = tbody.insertRow(-1);

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
                  element3.type = "number";
                  element3.style.width = "50px";
                  cell3.appendChild(element3);

               
                  <%--//if(<%=Master.IsInnova%> == "1") {--%>

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

                      $('select').material_select();
                  //}
              }
              return;

          }

        function seachOnAnimalID(animalID) 
        {
            var isEID = "<%=Master.IsEID%>";
            var eventType;
            if(isEID == 1)
            {
                eventType = "EIDBirth";
            }
            else
            {
                eventType = "Birth";
            }
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

                            // Set Days Pregnant
                            if (eventType == 'Birth') {
                                selectOption("SireList1", row.LastServedTo, 5);
                            }
                        }
                    },
                      function (transaction, error) {
                          alert("Could not read: " + error.message);
                      });
            });
            return true;
        }
    </script>

</asp:Content>
