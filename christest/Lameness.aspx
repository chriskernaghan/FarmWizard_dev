<%@ Page Title="" Language="C#" MasterPageFile="_App.Master" AutoEventWireup="true" CodeBehind="Lameness.aspx.cs" Inherits="HybridAppWeb.Lameness" %>
<%@ Register TagPrefix="n0" Namespace="UIControls" Assembly="SourceConsole" %>
<%@ MasterType  VirtualPath="_App.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="panel panel-default">
        <div class="panel panel-default">
                <div class="panel-heading" role="tab">
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>How many days was animal lame for? :</b>
                            <asp:TextBox ID="LamenessDays" TextMode="Number" CssClass="form-control input-sm" onchange='LamenessDaysOnTextChange(this)' runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Field Name :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="LamenessField" runat="server" onchange='LamenessFieldTextChange(this)' EnableViewState="False" DataTextField="ListBoxText" DataValueField="InternalFieldID">
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>No Of Sheep in Field :</b>
                            <asp:TextBox ID="FieldSheep" TextMode="Number"  CssClass="form-control input-sm" onchange='FieldTextChange(this)' runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Treatment Category :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="TreatCategory" onchange='TreatCategoryTextChange(this)' runat="server"></n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Medicine 1 :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="LamenessMed" onchange='LamenessMedTextChange(this)' runat="server"></n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <strong>
                                <asp:Label ID="Label31" runat="server" Font-Bold="True">Medicine 1 Quantity per animal :</asp:Label>
                            </strong>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="AnimalQuantity" onchange='AnimalQunatityTextChange(this)' runat="server" EnableViewState="False">
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
                            <b>Foot Overgrown :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="FootOvergrown" onchange='FootOvergrownTextChange(this)' runat="server" EnableViewState="False">
                                <asp:ListItem Value="false">No</asp:ListItem>
                                <asp:ListItem Value="true" Selected="True">Yes</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <b>Mobility Score :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="Severity" onchange='SeverityTextChange(this)' runat="server" EnableViewState="False">
                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-xs-6">
                            <b>Lesion :</b>
                            <n0:MOBILEDROPDOWNLIST class="form-control" id="Lesion" onchange='LesionTextChange(this)' runat="server" EnableViewState="False">
                            </n0:MOBILEDROPDOWNLIST>
                        </div>
                        <div class="form-group col-xs-6">
                            <strong>
                                <asp:Label ID="Label32" runat="server" Font-Bold="True">Administrator :</asp:Label></td>
                            </strong>    
                                            <n0:MOBILEDROPDOWNLIST class="form-control" id="AdminBox" runat="server"></n0:MOBILEDROPDOWNLIST>
                            <div style="margin-top: 5px"></div>
                            <asp:TextBox ID="AdminText" class="form-control input-sm" runat="server" Width="104px" MaxLength="70"></asp:TextBox>
                        </div>
                        <%--<div class="form-group col-xs-6">
      <b> Upload Image </b> 
                            <input type="file" name="fileToUpload" accept="image/*"  id="takePictureField" class="js-image-upload" runat="server" />
       <div class="js-image-container"></div>
    </div>--%>
                    </div>

                    <br />
                    <div align="center">
                        <a href="#" class="btn btn-primary waves-effect waves-light" onclick="checkInput()">Save Lameness</a>
                    </div>
                </div>
            </div>
    </div>

    <script type = "text/javascript">
        ///<reference path="/Script/jquery-ui.min.js" />
        ///<reference path="/Script/HybridApp.js" />

        var db;


        function checkInput()
        {
            var pType = 'Lameness';
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var alwaysConfirmFlag = "<%=Master.AlwaysConfirmFlag%>";

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
                // Remove the calf nationalID
                // Taking this out for now
                //document.forms[0].HidCalfNationalID.value = document.getElementById("CalfEarTag").value;
                //removeOptions(document.getElementById("CalfEarTag"));
                if((pType=="Lameness")&&("<%=Master.HandsFree%>" == ""))
                {
                    if(document.getElementById("<%=LamenessDays.ClientID%>").value=="")
                    {
                        App.alert("Error", "How many days was animal lame for may not be blank");
                        return false;
                    }
                    if(document.getElementById("<%=FieldSheep.ClientID%>").value=="")
                    {
                        App.alert("Error", "No of sheep in field may not be blank")
                        return false;
                    };

                    //var animals = document.getElementById("EIDAnimalList").options;
                    //var count = animals.length;
           
                    //if (count == 0) {
                    //    App.message("No animals scanned.");
                    //    return false;
                    //}

                    //// Write the form to the offline cache
                    //if (alwaysConfirmFlag == "1") {
                     
                    //        var txt = "Click OK to confirm you wish record a " + pType;
                    //        if (document.getElementById("InseminationChargeCheckBox")) {
                    //            txt += " Insemination is chargeable.";
                    //        }
                    //        if (document.getElementById("SemenChargeCheckBox")) {
                    //            txt += " Semen is chargeable.";
                    //        }
                    //        if(!SingleScan){
                    //        var ans = confirm(txt);
                    //        if (ans == false) {
                    //            return false;
                    //        }
                    //    }
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
                }
           
				//document.forms[0].HidTitle.value = "Recorded " + pType + " animals";			
                
                //get location for these types
                if (pType == "BatchLameness" || pType == "Lameness")
                {
                    getLocation = true;
                }
            
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
        }


        function submit()
        {
            var pType = "Lameness";
            var isEID = "<%=Master.IsEID%>";
            var herdID = sessionStorage.getItem('HerdID');
            var getLocation = false;

			//var opts = document.forms[0].AnimalList;
	   
			//if (opts) {
			//	document.forms[0].HidAnimalList.value = opts.value;
			//	document.forms[0].HidAnimalNos.value = opts.options[opts.selectedIndex].text;
			//	if (document.forms[0].HidAnimalList.value == "0") {
			//		App.alert("Please select", "Please select or type a cow number");
			//		return false;
			//	}
			//	if (processForm(pType) == false) {
			//		return false;
			//	}
			//}
		   
			var scorelist='';
			//this is commented out until the database supports it
			//if (getLocation == true)
			//    WriteFormValuesWithLocation("iQuickAdd.aspx?Type=Add" + pType  + "&HerdID=" + HerdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			//else
			WriteFormValues("Lameness.aspx?Type=Add" + pType  + "&HerdID=" + herdID + "&IsEID=" + isEID, document.forms[0], document.forms[0].HidTitle.value);
			var msg = pType + " has been recorded and will be transferred at next synchronisation";

			if("<%=Master.HandsFree%>" != "") 
			{
				if ("<%=Master.IsMulti%>" == "true")
				{
					AsyncAndroid.ConvertTextToVoicePromptResponse("Do you want to continue Please Say Yes or No ?");
					var  voiceRespM = AsyncAndroid.GetVoiceCommand();
					if(voiceRespM!="no"){
						if(pType=="Lameness"){
							singleVR=false;
							//AsyncAndroid.ConvertTextToVoice("Please scan the tag");
							setTimeout(function() { initPage(); }, 3000);
						}
					}
					else {
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
            if (document.getElementById('FullNumberList')) {
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
            SetDates("Lameness");
            HerdID = sessionStorage.getItem('HerdID');
            var herdName = sessionStorage.getItem('HerdName');
            if (herdName)
            {
                //  document.getElementById("TitleLabel").firstChild.data = document.getElementById("TitleLabel").firstChild.data + " Herd:" + herdName;
            }

            // FillDynamicList("LamenessField", "FieldList", 0, 0);
            FillDynamicList("<%=LamenessMed.ClientID%>", "MedicineList", HerdID, 0);
            FillDynamicList("<%=AdminBox.ClientID%>", "DoneBy", HerdID, 0);
            if (isEID == 1)
            {
                document.getElementById('selectedAnimalsTable').style.display = 'block';

                if (document.getElementById('ReadMotherTag'))
                {
                    document.getElementById('ReadMotherTag').style.display = 'none';
                }

            }


        }


         //function readNfcTag(nfcTagNumber){
         //     var decimal=nfcTagNumber;
         //     //if (((Master.checkForDuplicate(decimal) == 0)) && (decimal != "") && (decimal.indexOf("NaN") < 0)) {
                  
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
         //                             alertWithdrawal(row.WithdrawalDate, "Lameness");
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
                App.alert('Database','Cant open database');
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


        function handsFreeLameness(eventType) {
            var voiceRespM;
            var found = false;
            while (true) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("How many days was animal lame for?");
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
                    //App.textInput("Please enter", "Please enter animals (must be numeric):", "animalResults", pId, true)
                }
                if (!isNaN(voiceRespM)) {
                    document.getElementById("<%=LamenessDays.ClientID%>").value = voiceRespM;
                    break;
                }
                else {
                    App.alert("Please Enter Number","Must be numeric");
                }
            }

            for (var l = 1; l < 4; l++) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("What is the FieldName?");
                voiceRespM = AsyncAndroid.GetVoiceCommands();
                var arrStr = voiceRespM.replace('[', '');
                arrStr = arrStr.replace(']', '');
                var result = arrStr.split(',');
                var i = 0;
                var text;
                while (i < result.length && found == false) {
                    if (result[i] == "skip") {
                        found = true;
                        break;
                    }
                    else if (selectOption("LamenessField", result[i], 7) != "") {
                        found = true;
                        break;
                    }
                    i++;
                }
                if (found) {
                    break;
                }
            }
            if (found == false) {
                AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
    }
    else if (found) {
        found = false;
    }
    while (true) {
        AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Number of sheep in field");
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
            //App.textInput("Please enter", "Please enter animals (must be numeric):", "animalResults", pId, true)
            document.getElementById("<%=FieldSheep.ClientID%>").value = voiceRespM;
            break;
        }
        else {
            document.getElementById("<%=FieldSheep.ClientID%>").value = voiceRespM;
            break;
        }

    }
    for (var l = 1; l < 4; l++) {
        AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Treatment Category?");
        voiceRespM = AsyncAndroid.GetVoiceCommands();
        var arrStr = voiceRespM.replace('[', '');
        arrStr = arrStr.replace(']', '');
        var result = arrStr.split(',');
        var i = 0;
        var text;
        while (i < result.length && found == false) {
            if (result[i] == "skip") {
                found = true;
                break;
            }
            else if (selectOption("TreatCategory", result[i], 6) != "") {
                found = true;
                break;
            }
            i++;
        }
        if (found) {
            break;
        }
    }
    if (found == false) {
        AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
        window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
        }
        else if (found) {
            found = false;
        }
        for (var l = 1; l < 4; l++) {
            AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Medication1?");
            voiceRespM = AsyncAndroid.GetVoiceCommands();
            var arrStr = voiceRespM.replace('[', '');
            arrStr = arrStr.replace(']', '');
            var result = arrStr.split(',');
            var i = 0;
            var text;
            while (i < result.length && found == false) {
                if (result[i] == "skip") {
                    found = true;
                    break;
                }
                else if (selectOption("LamenessMed", result[i], 8) != "") {
                    found = true;
                    break;
                }
                i++;
            }
            if (found) {
                break;
            }
        }
        if (found == false) {
            AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
            window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
        }
        else if (found) {
            found = false;
        }
        for (var l = 1; l < 4; l++) {
            AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Animal Quantity in Medication 1?");
            voiceRespM = AsyncAndroid.GetVoiceCommands();
            var arrStr = voiceRespM.replace('[', '');
            arrStr = arrStr.replace(']', '');
            var result = arrStr.split(',');
            var i = 0;
            var text;
            while (i < result.length && found == false) {
                if (result[i] == "skip") {
                    found = true;
                    break;
                }
                else if (selectOption("AnimalQuantity", result[i], 3) != "") {
                    found = true;
                    break;
                }
                i++;
            }
            if (found) {
                break;
            }
        }
        if (found == false) {
            AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
            window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
            }
            else if (found) {
                found = false;
            }
            for (var l = 1; l < 4; l++) {
                AsyncAndroid.ConvertTextToVoicePromptResponse("Foot Overgrown Please Say Yes or No?");
                voiceRespM = AsyncAndroid.GetVoiceCommands();
                var arrStr = voiceRespM.replace('[', '');
                arrStr = arrStr.replace(']', '');
                var result = arrStr.split(',');
                var i = 0;
                var text;
                while (i < result.length && found == false) {
                    if (result[i] == "skip") {
                        found = true;
                        break;
                    }
                    else if (selectOption("FootOvergrown", result[i], 2) != "") {
                        found = true;
                        break;
                    }
                    i++;
                }
                if (found) {
                    break;
                }
            }
            if (found == false) {
                AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
                    }
                    else if (found) {
                        found = false;
                    }
                    for (var l = 1; l < 4; l++) {
                        AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say mobility score?");
                        voiceRespM = AsyncAndroid.GetVoiceCommands();
                        var arrStr = voiceRespM.replace('[', '');
                        arrStr = arrStr.replace(']', '');
                        var result = arrStr.split(',');
                        var i = 0;
                        var text;
                        while (i < result.length && found == false) {
                            if (result[i] == "skip") {
                                found = true;
                                break;
                            }
                            else if (selectOption("Severity", result[i], 1) != "") {
                                found = true;
                                break;
                            }
                            i++;
                        }
                        if (found) {
                            break;
                        }
                    }
                    if (found == false) {
                        AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                        window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
                    }
                    else if (found) {
                        found = false;
                    }
                    for (var l = 1; l < 4; l++) {
                        AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Lesion?");
                        voiceRespM = AsyncAndroid.GetVoiceCommands();
                        var arrStr = voiceRespM.replace('[', '');
                        arrStr = arrStr.replace(']', '');
                        var result = arrStr.split(',');
                        var i = 0;
                        var text;
                        while (i < result.length && found == false) {
                            if (result[i] == "skip") {
                                found = true;
                                break;
                            }
                            else if (selectOption("Lesion", result[i], 4) != "") {
                                found = true;
                                break;
                            }
                            i++;
                        }
                        if (found) {
                            break;
                        }
                    }
                    if (found == false) {
                        AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                        window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
                    }
                    else if (found) {
                        found = false;
                    }
                    for (var l = 1; l < 4; l++) {
                        AsyncAndroid.ConvertTextToVoicePromptResponse("Please Say Administrator?");
                        voiceRespM = AsyncAndroid.GetVoiceCommands();
                        var arrStr = voiceRespM.replace('[', '');
                        arrStr = arrStr.replace(']', '');
                        var result = arrStr.split(',');
                        var i = 0;
                        var text;
                        while (i < result.length && found == false) {
                            if (result[i] == "skip") {
                                found = true;
                                break;
                            }
                            else if (selectOption("AdminBox", result[i], 4) != "") {
                                found = true;
                                break;
                            }
                            i++;
                        }
                        if (found) {
                            break;
                        }
                        else {
                            var admin = window.prompt("Please enter Administrator", "");
                            //App.textInput("Please enter", "Please enter Administrator", "adminResults", pId, true)
                            document.getElementById("<%=AdminText.ClientID%>").value = admin;
                            found = true;
                            break;
                        }
                    }
                    if (found == false) {
                        AsyncAndroid.ConvertTextToVoice("Sorry Couldn't understand the voice, please enter Manually");
                        window.loaction.href = "Lameness.aspx?IsEID=<%=Master.IsEID%>";
                }
                checkInput();
        }

        function LamenessDaysOnTextChange() {
            document.getElementById("<%=LamenessField.ClientID%>").focus();
        }
        function LamenessFieldTextChange() {
            document.getElementById("<%=FieldSheep.ClientID%>").focus();
        }
        function FieldTextChange() {
            document.getElementById("<%=TreatCategory.ClientID%>").focus();

        }
        function TreatCategoryTextChange() {
            document.getElementById("<%=LamenessMed.ClientID%>").focus();
        }
        function LamenessMedTextChange() {
            document.getElementById("<%=AnimalQuantity.ClientID%>").focus();
        }
        function AnimalQunatityTextChange() {
            document.getElementById("<%=FootOvergrown.ClientID%>").focus();
        }
        function FootOvergrownTextChange() {
            document.getElementById("<%=Severity.ClientID%>").focus();
        }
        function SeverityTextChange() {
            document.getElementById("<%=Lesion.ClientID%>").focus();
        }

        function LesionTextChange() {
            document.getElementById('<%=AdminBox.ClientID%>').focus();
        }


        function adminResults(pId, pValue) {
            if (pValue == false) {
                return;
            }
            else {
                var value = pValue;
                if (isNaN(value)) {
                    App.textInput("Please enter", "Please enter Days Pregnant (must be numeric):", "adminResults", pId, true)
                }
                else {
                    App.alert("TEST", "test test test " + value);
                }// else
            }// else
        }// adminResults


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

