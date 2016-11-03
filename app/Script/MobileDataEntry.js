
function confirmIfToday() {
    var today = new Date();
    var doneDate = new Date();

    doneDate = document.getElementById("inputdate").value;
    if (document.getElementById("Eidinputdate"))
    {
        doneDate = document.getElementById("Eidinputdate").value;
    }
    //doneDate.setFullYear(document.forms[0].DoneYear.value,
	//		document.forms[0].DoneMonth.value - 1, document.forms[0].DoneDay.value);
    if (doneDate.toDateString() == today.toDateString()) {
        var ans = confirm("You have chosen todays date to record this event, click OK to continue, or Cancel to go back and amend date");
        return ans;
    }
    return true;
}

function confirmIfTreatmentToday() {
    var today = new Date();
    var doneDate = new Date();
    doneDate = document.getElementById("Treatmentinputdate").value;
    //doneDate.setFullYear(document.forms[0].TreatmentYear.value,
	//		document.forms[0].TreatmentMonth.value - 1, document.forms[0].TreatmentDay.value);
    if (doneDate.toDateString() == today.toDateString()) {
        var ans = confirm("You have chosen todays date to record this treatment, click OK to continue, or Cancel to go back and amend date");
        return ans;
    }
    return true;
}

function confirmIfMovementToday() {
    var today = new Date();
    var doneDate = new Date();
    doneDate.setFullYear(document.forms[0].MoveYear.value,
			document.forms[0].MoveMonth.value - 1, document.forms[0].MoveDay.value);
    if (doneDate.toDateString() == today.toDateString()) {
        var ans = confirm("You have chosen todays date to record this event, click OK to continue, or Cancel to go back and amend date");
        return ans;
    }
    return true;
}


function convertHexToDecimal(pHex) {
    var binary = "";
    var dec = "";

    for (var x = 0; x < pHex.length; x++) {
        var num = parseInt(pHex.substring(x, x + 1), 16);
        var bin = num.toString(2);
        while (bin.length < 4) {
            bin = "0" + bin;
        }
        binary += bin;
    }
    var ccode = (parseInt(binary.substring(16, 26), 2)).toString();
    var num = (parseInt(binary.substring(26), 2)).toString();


    while (ccode.length < 3) {
        ccode = "0" + ccode;
    }
    while (num.length < 12) {
        num = "0" + num;
    }

    dec = ccode.toString() + num.toString();

    return (dec);
}


//function processForm(pEventType) {
//    if((pEventType == "Note") || (pEventType == "Move")) {
//		var today = new Date();
//		var month = today.getMonth() + 1;
//		document.forms[0].NoteDateLabel.value = today.getDate()  + "/" +
//			month + "/" + today.getFullYear();
//        	if(pEventType == "Note") {
//            		document.forms[0].HidTitle.value = "Note added for " + 			document.forms[0].MoveHidLabel.value;
//		    }
//        	else {
//                var weight = "";
//                if(document.forms[0].ExitWeight != null) {
//                    weight = document.forms[0].ExitWeight.value;
//                }
//           		//document.forms[0].HidTitle.value = document.forms[0].MoveHidLabel.value + " move " + weight + " G" + document.forms[0].MoveGroup.value ;
//                document.forms[0].HidTitle.value = document.forms[0].MoveHidLabel.value + " move " + weight + " G" + document.forms[0].MoveGroup.options[MoveGroup.selectedIndex].text;      	
//            }
//        	return true;
//	}
//    else if(pEventType == "Medicine") {
//        if(document.forms[0].Units.selectedIndex == 0) {
//            alert("Please select units");
//		    return false;
//        }
//        if(document.forms[0].ApplicationMethod.options[document.forms[0].ApplicationMethod.selectedIndex].text == "Other, enter value >") {
//            if(document.forms[0].ApplicationMethodTextBox.value == "") {
//                 alert("Please enter application method");
//		         return false;
//            }
//        }
//        if(document.forms[0].Name.options[document.forms[0].Name.selectedIndex].text == "Other, enter value >") {
//            if(document.forms[0].NameTextBox.value == "") {
//                 alert("Please enter Name");
//		         return false;
//            }
//        }
//        if(document.forms[0].Supplier.options[document.forms[0].Supplier.selectedIndex].text == "Other, enter value >") {
//            if(document.forms[0].SupplierTextBox.value == "") {
//                 alert("Please enter Supplier");
//		         return false;
//            }
//        }
//        if(document.forms[0].BatchNumber.value == "") {
//            alert("Please enter a Batch number");
//		    return false;
//        }
//        if(document.forms[0].QuantityPurchased.value == "") {
//            alert("Please enter Quantity purchased");
//		    return false;
//        }
//        if(ValidateMedicineDates() == false) {
//            alert("Date in wrong format");
//		    return false;
//        }
//		document.forms[0].HidTitle.value = "Med " + document.forms[0].Name.value + "-" + document.forms[0].PurchaseDay.value + "/" +
//			document.forms[0].PurchaseMonth.value;
//        return true;
//	}

//	setHidTitle(pEventType);
//  	var cowList = document.forms[0].AnimalList;
//    if(cowList && cowList.selectedIndex == 0)  {
//         if(document.forms[0].HidAnimalsToAdd.value == "") {
//		      alert("No cow selected");
//		      return false;
//         }
//    }

//	if(pEventType == "Treatment") {
//       // if(cowList.selectedIndex == 0)  {
//      //      if(document.forms[0].GroupList.options[document.forms[0].GroupList.selectedIndex].text == "N/A") {
//       //         alert("No cow or group selected");
//		//        return false;
//       //     }
//      //  }

//	    if(ValidateTreatmentDates() == false) {
//		    return false;
//        }
//	    // Check start date < end date
//	    var startDate = new Date();
//	    var endDate = new Date();
//	    endDate = document.getElementById("TreatmentDateFinishedinput").value;
//	    //endDate.setFullYear(document.forms[0].FinishedYear.value,
//		//	document.forms[0].FinishedMonth.value -1, document.forms[0].FinishedDay.value);
//	    startDate = document.getElementById("Treatmentinputdate").value;
//	    //startDate.setFullYear(document.forms[0].TreatmentYear.value,
//		//	document.forms[0].TreatmentMonth.value - 1,document.forms[0].TreatmentDay.value);
//        if(endDate < startDate) {
//		    alert("Treatment finish date is less than treatment start date, please check");
//		    return false;
//		}
//		// Check activity or medicine selected
//		if ((document.forms[0].MedTreatment.value == "0") && (document.forms[0].Activity.value == "0")) {
//		    alert("You must select either a medicine OR an activity");
//		    return false;
//		}


//	}
//	else if (pEventType != "Foster") 
//    {
//	   if(ValidateDate() == false) 
//		return false;
           
//	}
//    if(pEventType == "AIService") {
//        if (document.forms[0].SireList2) {
//            if (document.forms[0].SireList2[document.forms[0].SireList2.selectedIndex].text.search("IB RISK") != -1) {
//                //var answer = confirm("Potential inbreeding risk click YES to confirm service");
//                var answer = App.confirm("Record", "Potential inbreeding risk click YES to confirm service", confirmRecord, pType);              
//                if (answer) {
//                }
//                else {
//                    return false;
//                }
//            }
//        }
//    }

//	if(pEventType == "Birth") {
//	    // Check within 26 days
//	    var today = new Date();
//	    var birthDate = new Date();
//	    if (document.getElementById("Eidinputdate")) {
//	        birthDate = document.getElementById("Eidinputdate").value;
//	    }
//	    birthDate = document.getElementById("inputdate").value;
	    
//	    //birthDate.setFullYear(document.forms[0].DoneYear.value,
//	    //	document.forms[0].DoneMonth.value - 1,document.forms[0].DoneDay.value);
//	    // var date = this.birthDate;

//	    // birthDate.setDate(birthDate.getDate()+26);
//	    var datevalue = birthDate.split('-'),nrDays=26,
//        date = new Date(parseInt(datevalue[0]), parseInt(datevalue[1]) - 1, parseInt(datevalue[2]));
//	    date.setDate(date.getDate() + nrDays);
//	    birthDate = date;
	 
//        if((birthDate < today) && (true == document.forms[0].AphisBirthCheckBox.checked)) {
//		    alert("Birth date is less than 26 days before today, please choose another date");
//		    return false;
//	    }
//	    // Check no birth conflict

//	    var cow = new String(cowList.options[cowList.selectedIndex].text);

//	    // Pull out last date
//        var openB = "\\(";
//        var closeB = "\\)";
//        var startIndex = cow.search(openB);
//	    var endIndex = cow.search(closeB);
//            //alert('hhhtd');


//	    startIndex = startIndex + 1;
//            if(startIndex != endIndex) {
//	        // Must have previous calf
//		var date = new Array();
//		var dateStr = cow.substring(startIndex, endIndex);
//		date = dateStr.split('/');
//            	var lastBirthDate = new Date();
//		lastBirthDate.setFullYear(date[2],date[1],date[0]);
//		lastBirthDate.setDate(lastBirthDate.getDate()+280);
//	        if(lastBirthDate > birthDate) {
//	    		alert("Our records show this cow last calved "
//			+ dateStr + " this wont be accepted by APHIS or BCMS" );
//		    return false;
//	    	}
//            }
//	}
//	document.forms[0].IsSubmitted.value = true;
//	return true;

//}

function setHidTitle(pEventType) {
	var title = "";
    if(pEventType == "Treatment") {
        title += document.getElementById("TreatmentDateFinishedinput").value;
            //document.forms[0].FinishedDay.value + "/" +
			//document.forms[0].FinishedMonth.value + "-" ;
	}

    else {
        if (document.getElementById("Eidinputdate")) {
            title += document.getElementById("Eidinputdate").value;
        }
        else {
            title += document.getElementById("inputdate").value;
        }
            //document.forms[0].DoneDay.value + "/" +document.forms[0].DoneMonth.value  + "-";
    }
    var opts = document.forms[0].AnimalList;
	var cow = opts.options[opts.selectedIndex].text;
    if(document.forms[0].HidAnimalNos.value != '') {
        cow = document.forms[0].HidAnimalNos.value;
    }
    if (document.forms[0].HidAnimalsToAdd.value != '') {
        cow = document.forms[0].HidAnimalsToAdd.value;
    }
    // just copy first 15 chars if its too long
    if (cow.length > 15) {
        cow = cow.substring(0, 15);
    }

	if(pEventType == "Treatment") {
		title += pEventType.substring(0,4) + "-" + cow ;
	}
	else {
	    title += pEventType.substring(0,5) + "-" + cow;
    }
    if (pEventType == "Birth") {
        var breedOpts = document.forms[0].Breed;
        var sexOpts = document.forms[0].Sex;

        title += "-" + document.forms[0].HidCalfNationalID.value + "-" +
			breedOpts.options[breedOpts.selectedIndex].text + "-" +
			sexOpts.options[sexOpts.selectedIndex].text;
    }
    else if (pEventType == "AIService") {
        var sireOpts = document.forms[0].SireList2;
        if (!sireOpts) {
            // this must be from non sire stock herd
            sireOpts = document.forms[0].NameOfServiceList;
        }
        title += "-" + sireOpts.options[sireOpts.selectedIndex].text
    }    
	document.forms[0].HidTitle.value = title;
}

function SetDates(pEventType)
{
    // if checking an already submitted form dont reset dates
    if (pEventType == "Foster") {
        return ; // not relevant for this screen
    }
    //if(document.forms[0].IsSubmitted.value == 'true') {
	//      return;
	//}
    
    // Set default values
    var t = new Date;
    var day = t.getDate();
    var month = t.getMonth() + 1;
    var year = t.getFullYear();

    if (month < 10) month = "0" + month;
    if (day < 10) day = "0" + day;

    var today = year + "-" + month + "-" + day;
    if (pEventType == "Treatment") {
    	//document.forms[0].FinishedDay.selectedIndex = t.getDate() - 1;
    	//document.forms[0].FinishedMonth.selectedIndex = t.getMonth();
    	//setSelectedIndex(document.forms[0].FinishedYear,t.getFullYear());

    	//document.forms[0].TreatmentDay.selectedIndex = t.getDate() - 1;
    	//document.forms[0].TreatmentMonth.selectedIndex = t.getMonth();
        //setSelectedIndex(document.forms[0].TreatmentYear,t.getFullYear());
     
    $("#Treatmentinputdate").attr("value", today);
    var today = year + "-" + month + "-" + day;
    $("#TreatmentDateFinishedinput").attr("value", today);
    $("#Eidinputdate").attr("value", today);
    }
    else if(pEventType == "New") {
    	//document.forms[0].DobDay.selectedIndex = t.getDate() - 1;
    	//document.forms[0].DobMonth.selectedIndex = t.getMonth();
    	//setSelectedIndex(document.forms[0].DobYear,t.getFullYear());

    	var today = year + "-" + month + "-" + day;
    	$("#joininputdate").attr("value", today);
    	$("#Eidinputdate").attr("value", today);
    	$("#dobinputdate").attr("value", today);
    	//document.forms[0].JoinDay.selectedIndex = t.getDate() - 1;
    	//document.forms[0].JoinMonth.selectedIndex = t.getMonth();
    	//setSelectedIndex(document.forms[0].JoinYear,t.getFullYear());
    }
    else if (pEventType != "Match") {
        var day = t.getDate();
    var month = t.getMonth() +1;
    var year = t.getFullYear();

    if (month < 10) month = "0" +month;
    if (day < 10) day = "0" +day;

    var today = year + "-" + month + "-" + day;

    $("#inputdate").attr("value", today);
    $("#Eidinputdate").attr("value", today);
       // var date = document.getElementById("inputdate");
       
       // document.forms[0].DoneDateText.value = t.getUTCDate();
        //document.forms[0].DoneDay.selectedIndex = t.getDate() - 1;
        //document.forms[0].DoneMonth.selectedIndex = t.getMonth();
        //setSelectedIndex(document.forms[0].DoneYear,t.getFullYear());
    }

    if((pEventType == "FarmOrganicManure") || (pEventType == "Fertiliser")
      || (pEventType == "Spray") || (pEventType == "Lime")) {
        var today = year + "-" + month + "-" + day;
        $('#TreatmentDate').attr("value", today);
        //document.forms[0].DayFinished.selectedIndex = t.getDate() - 1;
        //document.forms[0].MonthFinished.selectedIndex = t.getMonth();
        //setSelectedIndex(document.forms[0].YearFinished,t.getFullYear());
    }

}

function setSelectedIndex(s, v) {
    for ( var i = 0; i < s.options.length; i++ ) {
        if ( s.options[i].value == v ) {
            s.options[i].selected = true;
            return;
        }
    }
}

// Function takes a hex EID tag and converts it to decimal for database look up
function convertHexToDec(pHex) {
    var binary = "";
    var dec = "";

    for (var x = 0; x < pHex.length; x++) {
        var num = parseInt(pHex.substring(x, x + 1), 16);
        var bin = num.toString(2);
        while (bin.length < 4) {
            bin = "0" + bin;
        }
        binary += bin;
    }
    var ccode = parseInt(binary.substring(16, 26), 2);
    var num = parseInt(binary.substring(26), 2);

    while (ccode.length < 3) {
        ccode = "0" + ccode;
    }
    while (num.length < 12) {
        num = "0" + num;
    }

    dec = ccode.toString() + num.toString();

    return (dec);
}

function ValidateDate()
{
    //if(isDate(document.getElementById("inputdate").value) == false)
    //{
	//return false;
    //}
    //return true;
    if (document.getElementById("inputdate")) {
        if (isDate(document.getElementById("inputdate").value) == false) {
            return false;
        }
        return true;
    }
    else if (document.getElementById("Eidinputdate")) {
        if (isDate(document.getElementById("Eidinputdate").value) == false) {
            return false;
        }
        return true;
    }
}

function ValidateTreatmentDates()
{

    if(isDate(document.getElementById("Treatmentinputdate").value)==false)
    //document.forms[0].TreatmentMonth.value + '/' +document.forms[0].TreatmentDay.value
       // + '/' + document.forms[0].TreatmentYear.value) == false)
    {
        return false;
    }
    if(isDate(document.getElementById("TreatmentDateFinishedinput").value)==false)
        //document.forms[0].FinishedMonth.value + '/' +document.forms[0].FinishedDay.value
        //+ '/' + document.forms[0].FinishedYear.value) == false)
    {
        return false;
    }
    return true;
}

function ValidateMedicineDates()
{

    if(isDate(document.forms[0].PurchaseMonth.value + '/' + document.forms[0].PurchaseDay.value
        + '/' + document.forms[0].PurchaseYear.value) == false)
    {
        return false;
    }
    if(isDate(document.forms[0].Month.value + '/' + document.forms[0].Day.value
        + '/' + document.forms[0].Year.value) == false)
    {
        return false;
    }
    return true;
}



//////////////////

function removeAllOptions(selectbox)
{
	var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
		//selectbox.options.remove(i);
		selectbox.remove(i);
	}
}


function addOption(selectbox, value, text )
{
	var optn = document.createElement("OPTION");
	optn.text = text;
	optn.value = value;

	selectbox.options.add(optn);
}

var dtCh= "-";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   }
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear

	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	//if (pos1==-1 || pos2==-1){
	//	alert("The date format should be : mm/dd/yyyy")
	//	return false
	//}
	//if (strMonth.length<1 || month<1 || month>12){
	//	alert("Please enter a valid month")
	//	return false
	//}
	//if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
	//	alert("Please enter a valid day")
	//	return false
	//}
	//if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
	//	alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
	//	return false
	//}
	//if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
	//	alert("Please enter a valid date")
	//	return false
	//}
return true
}



