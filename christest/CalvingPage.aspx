<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="CalvingPage.aspx.cs" Inherits="HybridAppWeb.CalvingPage" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:Panel ID="CalvingEIDPanel" Visible="true" runat="server">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label33" runat="server" Font-Bold="True"><%=Master.Mother%> EID :</asp:Label>
                    </strong>
                    <asp:TextBox ID="CalvingDamEIDTag" runat="server" readonly="true" CssClass="form-control" MaxLength="20"></asp:TextBox>
                </div>
                <div class="form-group col-xs-6">
                    <strong>                        
                        <asp:Label ID="Label34" runat="server" Font-Bold="True">Visible Tag :</asp:Label>
                    </strong>
                    <asp:TextBox ID="CalvingDamNationalIDTag" CssClass="form-control" runat="server" MaxLength="20"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>Select if no calf,stillborn or slaughtered :</strong>
                                    <n0:MobileDropDownList ID="CalvingStillBornNotes" runat="server" class="form-control">
                                    </n0:MobileDropDownList>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label35" runat="server" Font-Bold="True">Calf EID :</asp:Label>
                    </strong>
                    <asp:TextBox ID="CalvingCalfEID" CssClass="form-control" readonly="true" runat="server" MaxLength="20" ></asp:TextBox>
                </div>

                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="CalvingFreezeBrandLabel" runat="server" Font-Bold="True">Calf FB :</asp:Label>
                    </strong>
                    <asp:TextBox ID="CalvingCalfFreezeBrand" class="form-control input-sm" runat="server" MaxLength="10"></asp:TextBox>
                </div>

            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="CalvingCalfNationalID" runat="server" Font-Bold="True">Calf Visible Tag :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalfEidEarTag" onchange="updateEIDfromVisible()" runat="server" EnableViewState="False">
                        <asp:ListItem selected="true"></asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>

                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="CalvingSexLabel" runat="server" Font-Bold="True">Sex of the calf :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingSex" runat="server" EnableViewState="False">
                        <asp:ListItem Value="Female" selected="true">Female</asp:ListItem>
                        <asp:ListItem Value="Male">Male</asp:ListItem>
                        <asp:ListItem Value="Bull">Bull</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                    <asp:Label ID="CalvingBreedLabel" runat="server" Font-Bold="True">Breed of calf :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingBreed" runat="server"></n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="CalvingColourLabel" runat="server" Font-Bold="True">Colour of the calf :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingColour" runat="server" EnableViewState="False"></n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label36" runat="server" Font-Bold="True">Calf Size :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingCalfSize" runat="server">
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="True">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <strong>
                        <asp:Label ID="Label37" runat="server" Font-Bold="True">Calf Vigour :</asp:Label>
                    </strong>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingCalfVigour" runat="server" EnableViewState="False">
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="True">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="CalvingNameLabel" runat="server" Font-Bold="True">Calf Name (no Prefix or Serial) :</asp:Label>
                        </strong>
                    </p>
                    <asp:TextBox ID="CalvingName" runat="server" class="form-control input-sm" MaxLength="40" Height="32px"></asp:TextBox>
                </div>
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="CalvingBirthDifficultylbl" runat="server" Font-Bold="True">Birth Diff :</asp:Label>
                        </strong>
                    </p>

                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingBirthDiff" runat="server" EnableViewState="False">
                        <asp:ListItem Value="NoAssistance" Selected="True">No Assist</asp:ListItem>
                        <asp:ListItem Value="SlightAssistance">Moderate Farm Assist</asp:ListItem>
                        <asp:ListItem Value="Assistance">Moderate Vet Assist</asp:ListItem>
                        <asp:ListItem Value="Difficult">Difficult Farm Assist</asp:ListItem>
                        <asp:ListItem Value="VetAssistance">Difficult Vet Assist</asp:ListItem>
                        <asp:ListItem Value="Ceasarian">Ceasarian</asp:ListItem>
                        <asp:ListItem Value="StillBorn">Still Born</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="Label38" runat="server" Font-Bold="True">Malrepresentation :</asp:Label>
                        </strong>
                    </p>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingMalrepresentation" runat="server" EnableViewState="False">
                        <asp:ListItem Value="no" Selected="True">No</asp:ListItem>
                        <asp:ListItem Value="yes">Yes</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="Label39" runat="server" Font-Bold="True">Docility :</asp:Label>
                        </strong>
                    </p>

                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingDocility" runat="server" EnableViewState="False">
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3" Selected="True">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="5">5</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="CalvingKeepForBreedingLabel" runat="server" Font-Bold="True">Calf for breeding :</asp:Label>
                        </strong>
                    </p>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingKeepForBreeding" runat="server" EnableViewState="False">
                        <asp:ListItem Value="No" Selected="True">No</asp:ListItem>
                        <asp:ListItem Value="Yes">Yes</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>

                </div>
                <div class="form-group col-xs-6">

                    <p>
                        <strong>
                            <asp:Label ID="CalvingPaternityTypeLabel" runat="server" Font-Bold="True">Paternity Type :</asp:Label>
                        </strong>
                    </p>

                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingPaternityType" runat="server" onchange="showSireList(this);" EnableViewState="False">
                        <asp:ListItem Value="Natural">Natural</asp:ListItem>
                        <asp:ListItem Value="Straw" selected="True">Straw</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="CalvingSireNameLabel" runat="server" Font-Bold="True">Sire Name :</asp:Label>
                        </strong>
                    </p>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingStrawSireList" runat="server" DataTextField="DisplayText" DataValueField="SireStockID"></n0:MOBILEDROPDOWNLIST>
                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingNaturalSireList" style="display:none"  runat="server"></n0:MOBILEDROPDOWNLIST>
                            
                </div>
                <div class="form-group col-xs-6">
                    <p>
                        <strong>
                            <asp:Label ID="CalvingAftBirthLabel" runat="server" Font-Bold="True">Aft Birth :</asp:Label>
                        </strong>
                    </p>

                    <n0:MOBILEDROPDOWNLIST class="form-control" id="CalvingAfterBirthDelivered" runat="server" EnableViewState="False">
                        <asp:ListItem Value="No">No</asp:ListItem>
                        <asp:ListItem Value="Yes" Selected="True">Yes</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-xs-6">

                    <asp:CheckBox ID="CalvingAphisBirthCheckBox" runat="server" Text="Tick to register with Aphis / BCMS" Font-Bold="True" Checked="True"></asp:CheckBox>
                </div>
                <div class="form-group col-xs-6">
                    <asp:CheckBox ID="CalvingBreedCheckBox" runat="server"  Text="Tick to stop breeding this cow" Font-Bold="True"></asp:CheckBox>
                </div>
            </div>
        </div>
        <div align="center">
            <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput();">Save Birth</a>
        </div>

        <td valign="top"></td>

    </div>
       </asp:Panel>
    
    
    <asp:Panel ID="BirthEIDPanel" Visible="false" runat="server">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab">
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong><asp:Label ID="Label6789" runat="server" Font-Bold="True"><%=Master.Mother%> EID :</asp:Label></strong>
                    <asp:TextBox ID="DamEIDTag" runat="server" readonly="true" CssClass="form-control" MaxLength="20"></asp:TextBox>
                </div>
                <div class="form-group col-xs-6">
                    <strong><asp:Label ID="Label27" runat="server" Font-Bold="True">Visible Tag :</asp:Label></strong>
                    <asp:TextBox ID="DamNationalID" CssClass="form-control" runat="server" MaxLength="20"></asp:TextBox>
                </div>
            </div>
            <span id="MgmtTag">_</span>
            <div class="row">
                <div class="form-group col-xs-6">
                    <strong><asp:Label ID="Label28" runat="server" Font-Bold="True">Birth Diff :</asp:Label></strong>

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
                    <strong><asp:Label ID="Label29" runat="server" Font-Bold="True">Aft Birth :</asp:Label></strong>


                    <n0:MOBILEDROPDOWNLIST class="form-control" id="EIDAfterBirthDelivered" runat="server" EnableViewState="False">
                        <asp:ListItem Value="No">No</asp:ListItem>
                        <asp:ListItem Value="Yes" Selected="True">Yes</asp:ListItem>
                    </n0:MOBILEDROPDOWNLIST>
                </div>
            </div>

            <div align="center">

                <a href="#" id="ReadLambs" class="btn btn-primary waves-effect waves-light" onclick="readBTTags(1);">Read <%=Master.Child%> Tags</a>
            </div>


            <table class="dataGrid" align="center" id="LambTable" style="font-family: Times New Roman; border-collapse: collapse" cellspacing="0" rules="all" border="1">
                <tbody>
                    <tr style="font-weight: bold; color: white; background-color: #ffcc66">
                        <td id="T1">
                            <%=Master.Child%></td>
                        <td id="T2">Male?</td>
                        <td id="T3">Wght</td>
                        <td id="T4">Lmbing Ease</td>
                        <td id="T5">Vigr</td>
                        <td id="T6">InTrn Eyes</td>
                    </tr>
                </tbody>
            </table>

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
    
    
    <asp:Panel ID="HolsteinPanel" runat="server">
        <div class="row">
            <div class="form-group col-xs-12">    
                <tbody>
                    <tr>
                        <td>
                            <strong><asp:Label ID="Label4" runat="server" Font-Bold="True">Concept Date :</asp:Label></strong>

                        </td>
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
                            <strong><asp:Label ID="Label5" runat="server" Font-Bold="True">Calf Serial No :</asp:Label></strong>
                        </td>
                        <td>
                            <asp:TextBox ID="SerialNo" runat="server" Width="80px" MaxLength="4"></asp:TextBox>
                        </td>
                        <td></td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td>
                            <strong><asp:Label ID="Label6" runat="server" Font-Bold="True">Dam :</asp:Label></strong>
                        </td>
                        <td colspan="3">
                            <asp:Label ID="DamLabel" runat="server"></asp:Label></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <strong><asp:Label ID="Label8" runat="server" Font-Bold="True">Twin Info :</asp:Label></strong>
                        </td>
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
                            <strong><asp:Label ID="Label7" runat="server" Font-Bold="True">Sup Registry :</asp:Label></strong>
                        </td>
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
                            <asp:CheckBox ID="HolsteinCheckBox" runat="server" Text="Tick to register with HUK" Font-Bold="True"></asp:CheckBox>
                        </td>
                        <td colspan="2"></td>
                        <td></td>
                    </tr>
                </tbody>
            </div>
        </div>
    </asp:Panel>
    
    <script type = "text/javascript">

        //
        var db;
        //

        function checkInput() 
        {
            var pType = "EIDCalving";
            var isEID = "<%=Master.IsEID%>";
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

            var getLocation = false;

            document.forms[0].HidAnimalsToAdd.value = ""; // need to clear this

            if (isEID == 1) 
            {            
                // Remove the calf nationalID
                // Taking this out for now
                //document.forms[0].HidCalfNationalID.value = document.getElementById("CalfEarTag").value;
                //removeOptions(document.getElementById("CalfEarTag"));
                if(pType == "EIDCalving") 
                {
                    if(document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value == "") 
                    {
                        App.message("No Dam ID scanned");
                        return false;
                    }                
            
                    if (!document.getElementById("<%=CalvingAphisBirthCheckBox.ClientID%>").checked)
                    {
                        if (confirm('You have chosen not to register this calf - Are you sure?'))
                        //if(App.confirm("Record", 'You have chosen not to register this calf - Are you sure?', confirmRecord, pType))
                        {
                            // Save it!
                        } 
                        else 
                        {
                            return false;
                        }
                    }              
                    var selectedtag = document.getElementById("<%=CalfEidEarTag.ClientID%>");
                    var selectedText = selectedtag.options[selectedtag.selectedIndex].text;

                    document.forms[0].hidCalfVisibleTag.value = selectedText;          
                    document.forms[0].HidAnimalList.value = "";
                }  

                document.forms[0].HidTitle.value = "Recorded " + pType + " for " + count + " animals";    
            }

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
                var opts = document.forms[0].AnimalList;
           
                if (opts) {
                    document.forms[0].HidAnimalList.value = opts.value;
                    document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
                    if (document.forms[0].HidAnimalList.value == "0") {
                        App.alert("Please Select", "Please select or type a cow number");
                        return false;
                    }
                    if (processForm("") == false) {
                        return false;
                    }
                }
               
                var scorelist='';
                //this is commented out until the database supports it
                //if (getLocation == true)
                //    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
                //else
                WriteFormValues("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
                var msg = pType + " has been recorded and will be transferred at next synchronisation";

                if (isEID != 1) 
                {
                    App.alert("Result", msg);
                }
                else  {
                    App.message(msg); 
                    document.getElementById("form1").reset();
                }  
        
            }
            // Always return false so that for doesnt get submitted
            return(false);
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

                            document.getElementById("<%=CalvingDamNationalIDTag.ClientID%>").value = row.NationalID;
                            if(row.ElectronicID)
                                document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value = row.ElectronicID;
                            else
                                document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value = "0";
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
                            ////var listBox = document.getElementById("EIDAnimalList");
                            ////var opt = document.createElement("option");

                            // results.rows holds the rows returned by the query
                            if (results.rows.length == 1) {

                                var row = results.rows.item(0);
                                var skip = false;

                                if (row.Exception != '') {
                                    App.alert("Exception", row.Exception);
                                }
                                if (row.withdrawalDate != '') {
                                    alertWithdrawal(row.WithdrawalDate);
                                }
                                nfcEidCalving(row.Exception, tag, row.NationalID, row.FreezeBrand, row.LastCalvedDate, row.Alert, row.LastServedTo, row.Group);

                                if (skip == false) {
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

                                var val = document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value;
                                if ((val == null) || (val == "")) {
                                    //Dam not scanned yet?
                                    App.message(tag + " Animal not found");
                                    App.message("Please scan Dam first");
                                } else {
                                    nfcEidCalving(null, tag, null, null, null, null, null, null);
                                }
                            }
                            else {
                                
                                App.message(tag + " Animal not found");
                            }

                            },

                            function (transaction, error) {
                                App.alert("Error", "Could not read: " + error.message);
                            });
                    });
            }

        function nfcEidCalving(pException, pEIDTag, pDamNationalID, pFreezeBrand, pLastCalvedDate, pAlert, pAssocRam, pGroup) {
            if (pException) {
                App.alert("Exception", pException);
            }
            if (pAlert == "1") {
                App.alert("Success", "You have configured FarmWizard to alert you of group " + pGroup);
            }
            // Check when last calved
            if (pLastCalvedDate) {
                var lastCalvedOn = new Date(pLastCalvedDate.substring(6),
                             pLastCalvedDate.substring(3, 5) - 1, pLastCalvedDate.substring(0, 2));
                var today = new Date();
                var days = (today.getTime() - lastCalvedOn.getTime()) / 86400000;
                if (days < 200) {
                    App.alert("Success", "Dam recently calved on " + pLastCalvedDate);
                    return;
                }
            }
            var damEidTag = document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value;
            var damNationalID = document.getElementById("<%=CalvingDamNationalIDTag.ClientID%>").value;
            if ((damEidTag == "") && (damNationalID == "")) {
                document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value = pEIDTag;
                document.getElementById("<%=CalvingDamNationalIDTag.ClientID%>").value = pDamNationalID;
                //document.getElementById("CalvingDamTag").firstChild.data = pFreezeBrand;

                //got the Dam, now scan the calf.
                App.message("Please Scan the Calf EID");
                App.shortVibrate();
                //readBTTags();
                return;
            }
            else {
                if (pEIDTag == document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value) {

                    App.message("Please Scan the Calf EID");
                    App.shortVibrate();
                    //readBTTags();
                    return;

                }
                else {

                    var found = false;
                    var el = document.getElementById("<%=CalfEidEarTag.ClientID%>");
                    for (var i = 0; i < el.options.length; i++) {
                        if (el.options[i].value == pEIDTag) {
                            //select it
                            found = true;

                            document.getElementById("<%=CalvingCalfEID.ClientID%>").value = pEIDTag;
                            document.getElementById("<%=CalvingCalfEID.ClientID%>").readOnly = true;

                            el.selectedIndex = i;

                            stopReadingBTTags();

                            break;
                        }
                    }
                    if (!found) {
                        //the EID tag is not in the free tag list.
                        App.message("EID is not in the Free Tag list, Please try again.");
                        App.shortVibrate();
                        //readBTTags();
                        return;
                    }

                }

            }
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

                            document.getElementById("<%=CalvingDamNationalIDTag.ClientID%>").value = row.NationalID;
                            document.getElementById("<%=CalvingDamEIDTag.ClientID%>").value = row.ElectronicID;

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



        function updateEIDfromVisible() {
            var el = document.getElementById("<%=CalfEidEarTag.ClientID%>");
            var strEIDTag = el.options[el.selectedIndex].value;

            document.getElementById("<%=CalfEidEarTag.ClientID%>").value = strEIDTag;
        }


        //function readNfcTag(nfcTagNumber)
        //{
        //    var decimal=nfcTagNumber;
        //        var sql = "SELECT * FROM Cows where (NFCID = '" + decimal +  "'OR ElectronicID='"+ decimal+ "' AND InternalHerdID = " + HerdID + ")";
        //        db.transaction(function(transaction) {
        //            transaction.executeSql(sql, [],
        //                function(transaction, results) {
        //                    ////var listBox = document.getElementById("EIDAnimalList");
        //                    ////var opt = document.createElement("option");
                              
        //                    // results.rows holds the rows returned by the query
        //                    if (results.rows.length == 1) 
        //                    {
        //                        var row = results.rows.item(0);
        //                        var skip = false;
                                 
        //                        if(row.Exception!=''){
        //                            App.alert("Exception", row.Exception);
        //                        }
        //                        if(row.WithdrawalDate!=''){
        //                            alertWithdrawal(row.WithdrawalDate,"EIDCalving");
        //                        }                             
        //                            nfcEidCalving(row.Exception, row.ElectronicID, row.NationalID, row.FreezeBrand, row.LastCalvedDate, row.Alert, row.LastServedTo, row.Group);
                                
 
        //                        if (skip == false)                                   
        //                        {                                     
        //                            var exists=false;                                    
        //                            $('#EIDAnimalList option').each(function () 
        //                            {
        //                            if (this.text == row.ElectronicID) {
        //                                exists=true;
        //                            }
        //                            });
                                       
        //                            if(!exists)
        //                            {                                           
        //                                listBox.options.add(opt, 0);                                           
        //                                opt.text = row.ElectronicID;                                           
        //                                opt.value = row.InternalAnimalID;                                         
        //                                setSelectedIndex(listBox, opt.value);                                         
        //                                var counter = document.getElementById("Count");                                         
        //                                counter.value = listBox.length;                                         
        //                                addToList(row.ElectronicID, null);
        //                            }
        //                        }                                                                     
        //                    }
        //                    else 
        //                    {
                                    
        //                            App.message(decimal + " Animal not found");
        //                    }
        //            },
        //                function(transaction, error) 
        //                {
        //                    App.alert("Error", "Could not read: " + error.message);
        //                });             
        //        });
        //}


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
            SetDates("EIDCalving");
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
                document.getElementById('selectedAnimalsTable').style.display = 'block';              
                
                //document.getElementById('StartScanButton').style.display = 'none';
                //document.getElementById('ReadMotherTag').style.display = 'inline';
                
                FillDynamicList("<%=CalfEidEarTag.ClientID%>", "CalfEidEarTag", HerdID, 0);
                FillDynamicList("<%=CalvingBreed.ClientID%>", "Breed", HerdID, 0);
                FillDynamicList("<%=CalvingStrawSireList.ClientID%>", "SireList", HerdID, 0);
                FillDynamicList("<%=CalvingNaturalSireList.ClientID%>", "BullBirthEarTag", HerdID, 0, "N/A");              
                        
            //}
        }


        function confirmRecord(pId, pValue) {
            if (pValue == false) {
                return false;
            }// if
            else {
                if (searchFBBatchAfter("EIDCalving") == false) {
                    return false;
                    //$('#EIDAnimalList').empty();
                    checkInput();
                }
                //$('#EIDAnimalList').empty();
                checkInput();
                return false;
            }// else
        }// confirmRecord


        function processForm() {
            setHidTitle();
            var cowList = document.forms[0].AnimalList;
            if (cowList && cowList.selectedIndex == 0) {
                if (document.forms[0].HidAnimalsToAdd.value == "") {
                    App.alert("Please Select", "No cow selected");
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
