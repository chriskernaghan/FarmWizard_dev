<%@ Page Language="C#"  EnableViewState="False"  %>
<%@ Register TagPrefix="n0" Namespace="UIControls" %>
<%@ import Namespace="AnimalManager" %>
<%@ import Namespace="AdminManager" %>
<%@ import Namespace="FieldRecordManager" %>
<%@ import Namespace="IDManagement" %>
<%@ import Namespace="UICommon" %>
<%@ import Namespace="LifecycleManager" %>
<%@ import Namespace="MilkRecordManager" %>
<%@ import Namespace="UserManager" %>
<%@ import Namespace="DatabaseInteraction" %>
<%@ import Namespace="EnterpriseManager" %>
<%@ import Namespace="ExternalInterfaceManager" %>
<%@ import Namespace="Utilities" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Threading" %>
<%@ import Namespace="System.IO" %>
<script runat="server">

    DataTable vetTreatList;
    DataView milkTestView;
    DataView prevTestView;
    DataTable beefEventList;
    long loadedHerdID;
    bool breedingEventsLoaded; // These help performance when loading lots of reports
    DataTable loadedBreedingEvents;


    private void Page_Load(object sender, EventArgs e) {

        HttpCookie cookie;
        try
        {
            cookie = Request.Cookies["FWSession"];
            int test = Int32.Parse(cookie.Values["Package"]);
        }
        catch
        {
            Response.Write("Your security session has timed out, please relogin in at http://www.farmwizard.com/iphone/ilogin.apx and try again. Do not clear your cache, any pending events will be written after you relog on");
            return;
        }
        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        long userID = Int64.Parse(cookie.Values["UserID"]);

        User usr = new User(userID);
        if (usr.RegistrationStatus != (int)eRegistrationStatus.Accepted)
        {
            Response.Write("Your account is not live, please contact FarmWizard on 028 90 660000 ");
            return;
        }





        Response.ContentType = "text/xml";
        if ((Request.QueryString["Type"] == null) || ((package == ePackages.SheepManager) && (Request.QueryString["Type"] != "DairyBeef") &&
              (Request.QueryString["Type"] != "DynamicLists")))
        {
            Response.Write(buildSheepXMLDatabase());
        }

        else if(Request.QueryString["Type"] == "LambOnly") {
            Response.Write(buildLambXMLDatabase());
        }
        else if(Request.QueryString["Type"] == "DairyBeef") {
            // Confusingly we recognise the dairybeef Query string as coming up from the App
            if (Request.QueryString["TimeStamp"] != null)
            {
                // This is from the app so we make sure this guy is on an paid
                if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.SmartPhoneWebApp) == false)
                {
                    Response.Write("Smartphone App software has been disabled");
                    Response.End();
                }
            }
            Response.Write(buildAppXMLDatabase());
        }
        if (Request.QueryString["Type"] == "DynamicLists")
        {
            if (Request.QueryString["TimeStamp"] != null)
            {
                // This is from the app so we make sure this guy is on an paid
                if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.SmartPhoneWebApp) == false)
                {
                    Response.Write("Smartphone App software has been disabled");
                    Response.End();
                }
            }
            Response.Write(buildDynamicListXMLDatabase());
        }
    }

    private string formatInBreedingPotential(long pInternalAnimalID) {
        HttpCookie cookie = Request.Cookies["FWSession"];
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        string response = "";

        /* Disable this for now 

        if(UserPlugIn.CheckForPlugIn(enterpriseID,ePlugIns.SemenStock) == false)
        {
            return(response);
        }
        AnimalInBreedingPotential inb = new AnimalInBreedingPotential(pInternalAnimalID,false);
        response = inb.LoadICChances(); */
        return(response);

    }


    private string formatMilkRecords(long pInternalAnimalID,long pHerdID) {

        string response = "";
        HttpCookie cookie = Request.Cookies["FWSession"];
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);

        if(UserPlugIn.CheckForPlugIn(enterpriseID,ePlugIns.MilkRecords) == false)
        {
            return(response);
        }

        // Need to refresh the view when moving to the next herd

        if((milkTestView == null) || (loadedHerdID != pHerdID)) {
            MilkTestAnimalReports aniReports = new MilkTestAnimalReports();
            aniReports.InternalHerdID = pHerdID;
            milkTestView = aniReports.ViewAllForMobile();
        }
        if (((prevTestView == null) || (loadedHerdID != pHerdID)) && (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.Cogent) == false))
        {
            MilkTestAnimalReports aniReports2 = new MilkTestAnimalReports();
            aniReports2.InternalHerdID = pHerdID;
            prevTestView = aniReports2.ViewPreviousLactations();

        }

        loadedHerdID = pHerdID;

        milkTestView.RowFilter = "InternalAnimalID=" + pInternalAnimalID;
        milkTestView.Sort="RecordingDate DESC";

        int totalScc = 0;

        if(milkTestView.Count > 0) {
            response += "Date,Yield,Fat,Protein,SCC  ";
        }



        for(int z=0;z<milkTestView.Count;z++) {
            // Ignore tests from previous Lactation
            if((milkTestView[z]["ThisCalfDate"] != null) && (milkTestView[z]["ThisCalfDate"].ToString().Trim() != "")) {
                if ((DateTime)milkTestView[z]["RecordingDate"] > (DateTime)milkTestView[z]["ThisCalfDate"])
                {
                    totalScc += (int)milkTestView[z]["CellCount"];
                    response += string.Format("{0}{1},{2},{3},{4},{5}  ", UIConstants.LINE_BREAK,
                        ((DateTime)milkTestView[z]["RecordingDate"]).ToShortDateString(), milkTestView[z]["MilkYield"], milkTestView[z]["ButterFat"], milkTestView[z]["Protein"],
                            milkTestView[z]["CellCount"]);
                }
            }
        }
        if(milkTestView.Count > 0) {
            response = string.Format("Recent SCC = {1}:Lact Ave = {2}{0}{3}",UIConstants.LINE_BREAK,
                milkTestView[0]["CellCount"], (int)(totalScc / milkTestView.Count),response);
        }

        if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.Cogent) == false)
        {
            // Cogent dont want previous test information
            prevTestView.RowFilter = "InternalAnimalID=" + pInternalAnimalID;

            if (prevTestView.Count > 0)
            {
                prevTestView.Sort = "LactationNumber";
                response += UIConstants.LINE_BREAK + "Lact,Yield,Fat,Protein,SCC  ";

                for (int z = 0; z < prevTestView.Count; z++)
                {
                    response += string.Format("{0}{1},{2},{3:f2}%,{4:f2}%,{5}  ", UIConstants.LINE_BREAK,
                        prevTestView[z]["LactationNumber"], prevTestView[z]["Yield"], prevTestView[z]["FatPercent"], prevTestView[z]["ProteinPercent"],
                            prevTestView[z]["AveCellCount"]);
                }
            }
        }
        return(response);

    }


    private string formatVetTreat(long pInternalAnimalID,out string pWithdrawalDate) {
        string treatStr = "";
        pWithdrawalDate = "";
        // if(vetTreatList == null) {
        //    VetinaryList newVet = new VetinaryList();
        //    DataSet ds =  newVet.ListAllHerdVetinaryEvents(pHerdID);
        //    vetTreatList = ds.Tables[0];
        // }
        VetinaryList newVet = new VetinaryList();

        DataSet ds = newVet.ListAnimalVetinaryEvents(pInternalAnimalID);
        vetTreatList = ds.Tables[0];
        DataView dv = new DataView(vetTreatList);
        DateTime latestMilkDate = new DateTime(0);
        DateTime latestMeatDate = new DateTime(0);

        dv.Sort = "DateTreatmentFinished";
        if(dv.Count > 0) {
            for(int k=0;k<dv.Count;k++) {
                treatStr += string.Format("{0} of {1} on {2} for {3} {4} {5},",dv[k]["QuantityUnitsText"].ToString().Trim(),
                        dv[k]["Name"].ToString().Trim(),dv[k]["DoneDateText"].ToString().Trim(),
                            dv[k]["HealthCode"].ToString().Trim(), dv[k]["Notes"].ToString().Trim(), dv[k]["UdderQuarterText"].ToString().Trim());
                if (dv[k]["DateWithdrawalMilk"].ToString().Trim() != "")
                {
                    if (latestMilkDate < (DateTime)dv[k]["DateWithdrawalMilk"])
                    {
                        latestMilkDate = (DateTime)dv[k]["DateWithdrawalMilk"];
                    }
                }
                if (dv[k]["DateWithdrawalMeat"].ToString().Trim() != "")
                {
                    if (latestMeatDate < (DateTime)dv[k]["DateWithdrawalMeat"])
                    {
                        latestMeatDate = (DateTime)dv[k]["DateWithdrawalMeat"];
                    }
                }

            }
            pWithdrawalDate = latestMeatDate.ToString().Trim();
            treatStr += string.Format("(Meat/Milk Withdrawal {0} / {1})",latestMeatDate.ToShortDateString(),
                    latestMilkDate.ToShortDateString());

        }
        return (treatStr.Replace("&", "").Replace("\"",""));
    }

    private string formatExceptionString(string pNationalID, long pHerdID)
    {
        int congenitalDefect,siblingInfo;
        return(formatExceptionString( pNationalID, pHerdID, out congenitalDefect, out siblingInfo));
    }

    // Extended this call to pull back congenital defect and sibling information;

    private string formatExceptionString(string pNationalID,long pHerdID,out int pCongenitalDefect,out int pSiblingInfo) {
        string exStr = "";
        pCongenitalDefect = 0;
        pSiblingInfo = 0;

        long animalID = Animal.GetInternalIDEverInHerdWithDefects(pNationalID, pHerdID, out pCongenitalDefect, out pSiblingInfo);
        if (animalID == 0)
        {
            return (exStr);
        }

        DataTable dt = LifecycleRecord.ListNotes(animalID,eLifeCycleEventType.Note);
        DataView dv = new DataView(dt);

        if(dv.Count > 0) {
            for(int k=0;k<dv.Count;k++) {
                exStr += string.Format("{0}-{1} ",dv[k]["DoneDateText"].ToString().Trim(),
                        dv[k]["Notes"].ToString().Trim());
            }
        }
        return(exStr);
    }

    private string formatScoreString(long pInternalAnimalID)
    {
        string scoreHistory = "";
        ScoreEvent sc = new ScoreEvent();
        DataTable dt = sc.ListAnimalScoreEvents(pInternalAnimalID);
        DataView dv = new DataView(dt);
        dv.Sort = "DoneDate desc";
        if (dv.Count > 0)
        {
            scoreHistory = string.Format("{0} on {1}", dv[0]["ScoreValue"].ToString().Trim(), ((DateTime)dv[0]["DoneDate"]).ToShortDateString());
        }
        return (scoreHistory);
    }
    private int checkIfAlert(DataView pAlertGroup,string pGroup) {
        int toAlert = 0;
        if ((pGroup == "") || (pGroup == "0"))
        {
            return(toAlert);
        }
        pAlertGroup.RowFilter = string.Format("Group = {0}",pGroup);

        if(pAlertGroup.Count > 0) {
            toAlert = 1;
        }
        return(toAlert);
    }

    private string buildLambXMLDatabase()
    {
        string response = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<root>\n";

        vetTreatList = null;

        HttpCookie cookie = Request.Cookies["FWSession"];
        try
        {
            string test = Request.Cookies["FWSession"].Values["UserID"];
        }
        catch
        {
            // Not yet logged in so just return empty
            response += ("</root>");
            return (response);
        }


        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        long herdID = Int64.Parse(cookie.Values["HerdID"]);

        // Get alert groups if any
        AlertGroup ag = new AlertGroup(herdID);
        DataTable at = ag.ListGroups();
        DataView alertView = new DataView(at);

        Herd newHerd = new Herd(herdID);
        Herd hrd = new Herd();

        BeefHerd beefHerd = new BeefHerd(herdID);
        DataTable dt0 = beefHerd.ListLiveHerd(DateTime.Now.AddDays(7), 30, false);
        DataView dv = new DataView(dt0);
        dv.Sort = "ElectronicID, ShortTag";
        for (int i = 0; i < dv.Count; i++)
        {
            if((DateTime)dv[i]["DateOfBirth"] < DateTime.Now.AddMonths(-12))
            {
                continue;
            }


            string withdrawalDateStr = "";
            string exString = formatExceptionString(dv[i]["NationalID"].ToString().Trim(), herdID);

            string weightHistory = dv[i]["WeightHistoryText"].ToString().Trim();
            if (dt0.Columns.Contains("BoughtWeight"))
            {
                weightHistory = string.Format("{0}-{1:f0},", DateTime.Parse(dv[i]["BoughtDate"].ToString()).ToShortDateString(), dv[i]["BoughtWeight"].ToString().Trim()) + weightHistory;
            }

            string vetTreatString = formatVetTreat(Int64.Parse(dv[i]["InternalAnimalID"].ToString().Trim()), out withdrawalDateStr);
            response += string.Format("<Sheep EID=\"{0}\"  NationalID=\"{1}\" SexText=\"{2}\"" +
                   " LastWeight=\"{3:f1}\" DLWG=\"{4:f1}\" DateOfBirth=\"{5}\" Group=\"{6}\" LastWeightDate=\"{7}\" DisplayType=\"3\" JoinDate=\"{8}\" BreedText=\"{9}\" " +
                   " Breed=\"{10}\" Sex=\"{11}\" IsCross=\"{12}\" OldNumber=\"{13}\" ClassText=\"{14}\" TreatmentText=\"{15}\" PurchasedFrom=\"{16}\" WeightHistoryText=\"{17}\" " +
                   " WithdrawalDate=\"{18}\" Alert=\"{19}\" Exception=\"{20}\" Dam=\"{21}\" Sire=\"{22}\"/>\n",
                                dv[i]["ElectronicID"].ToString().Trim().PadLeft(15, '0'),
                                dv[i]["NationalID"].ToString().Trim(),
                                dv[i]["Sex"].ToString().Trim(),
                                dv[i]["LastWeight"],
                                dv[i]["DLWG"],
                                ((DateTime)dv[i]["DateOfBirth"]).ToShortDateString(),
                                dv[i]["Group"],
                                dv[i]["LastWeightDateText"].ToString().Trim(),
                                DateTime.Parse(dv[i]["BoughtDate"].ToString()).ToShortDateString(),
                                dv[i]["BreedText"].ToString().Trim(),
                                dv[i]["BreedValue"].ToString().Trim(),
                                dv[i]["SexValue"].ToString().Trim(),
                                dv[i]["IsCross"].ToString().Trim(),
                                dv[i]["OldNumber"].ToString().Trim(),
                                dv[i]["Class"].ToString().Trim(),
                                vetTreatString,
                                dv[i]["BoughtFrom"].ToString().Trim(),
                                weightHistory, withdrawalDateStr,
                                checkIfAlert(alertView, dv[i]["Group"].ToString().Trim()), exString, dv[i]["DamText"].ToString().Trim(), dv[i]["SireText"].ToString().Trim());

        }

        response += ("</root>");
        response = response.Replace("&", "");
        return (response);

    }


    private string buildSheepXMLDatabase() {
        string response = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<root>\n";

        vetTreatList = null;
        string debug = "";

        HttpCookie cookie = Request.Cookies["FWSession"];
        try {
            string test = Request.Cookies["FWSession"].Values["UserID"];
        }
        catch {
            // Not yet logged in so just return empty
            response += ("</root>");
            return(response);
        }

        debug += " 1 " + DateTime.Now.ToString();
        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        DataAccess da2 = new DataAccess();
        da2.LoadDatabaseTable("EnterpriseID", enterpriseID, "Herd");
        DataView herdDV = new DataView(da2.ds.Tables[0]);
        herdDV.Sort = "InternalHerdID";
        for (int z = 0; z < herdDV.Count; z++)
        {
            long herdID = (long)herdDV[z]["InternalHerdID"];

            // Get alert groups if any
            AlertGroup ag = new AlertGroup(herdID);
            DataTable at = ag.ListGroups();
            DataView alertView = new DataView(at);

            Herd newHerd = new Herd(herdID);
            Herd hrd = new Herd();


            // Get the Ewes breeding info
            DataTable dt2 = newHerd.FastListBreedingAnimalsWithDetails();
            debug += " 2 " + DateTime.Now.ToString();

            // gET THE List of RAMS
            DataTable bulls = newHerd.ListRams();
            ArrayList animals = new ArrayList();


            // Note for display types 1 = BREEDPERFORMANCE, 2 = BREED, 3 = PERFORMANCE

            // Download the Ewes stats
            BeefStatistics stats = new BeefStatistics(herdID, true);
            //DataView dv = new DataView(stats.BuildDamSirePerformanceTable(
            //                       DateTime.Now.AddYears(-5), DateTime.Now, false));
            // 24th April 2013 Taking this out for now as performance taking too much of a hit, will see if anyone misses it
            DataTable empty = new DataTable();
            DataView dv = new DataView(empty);
            debug += " 3 " + DateTime.Now.ToString();

            // Only want the live ones
            // dv.RowFilter = "State = 'Inherd'";
            for (int i = 0; i < dv.Count; i++)
            {
                DataView bv = new DataView(dt2);
                bv.RowFilter = string.Format("NationalID = '{0}'",
                                            dv[i]["DamSire"].ToString().Trim());


                string lambInfo = "";
                string scanInfo = "";
                string dueLambDate = "";
                string assocRam = "";
                string electronicID = "0";
                string fb = "";
                string grp = "";
                string dob = "";
                string join = "";
                string breed = "";
                string sex = "";
                string sClass = "";
                string breedStr = "";
                string sexStr = "";
                string sClassStr = "";
                int isCross = 0;
                string oldNumber = "";
                string purchasedFrom = "";
                string Exception = "";


                if (bv.Count > 0)
                {
                    animals.Add(dv[i]["DamSire"].ToString().Trim());

                    join = bv[0]["JoinDateText"].ToString().Trim();
                    dob = bv[0]["DateOfBirthText"].ToString().Trim();

                    breedStr = bv[0]["BreedText"].ToString().Trim();
                    sexStr = bv[0]["SexText"].ToString().Trim();
                    sClassStr = bv[0]["ClassText"].ToString().Trim();

                    breed = bv[0]["Breed"].ToString().Trim();

                    sex = bv[0]["Sex"].ToString().Trim();
                    sClass = bv[0]["SheepCategory"].ToString().Trim();

                    DataView bullDv = new DataView(bulls);
                    string aniGroup = bv[0]["Group"].ToString().Trim();
                    if ((aniGroup != "") && (aniGroup != "0"))
                    {
                        bullDv.RowFilter = string.Format("Group = {0}", aniGroup);
                        if (bullDv.Count > 0)
                        {
                            assocRam = bullDv[0]["NationalID"].ToString().Trim();
                        }
                    }
                    electronicID = z + "3000" + i; // Give the animal a dud unique EID number in case non is set as we need this to get 
                                                   // then downloaded to the reader
                    if ((bv[0]["ElectronicID"].ToString().Trim() != "") && (bv[0]["ElectronicID"].ToString().Trim() != "0"))
                    {
                        electronicID = bv[0]["ElectronicID"].ToString().Trim().PadLeft(15, '0');
                    }



                    fb = bv[0]["FreezeBrand"].ToString().Trim();
                    lambInfo = bv[0]["CalfDate"].ToString().Trim();
                    scanInfo = bv[0]["ScanDate"].ToString().Trim() + "-" +
                                            bv[0]["ScanNo"].ToString().Trim() + "Lmb";
                    dueLambDate = bv[0]["DueCalfDate"].ToString().Trim();
                    grp = bv[0]["Group"].ToString().Trim();
                    try
                    {
                        isCross = (int)bv[0]["IsCross"];
                    }
                    catch
                    {
                        // Need for backwards compatability
                    }
                    oldNumber = bv[0]["OldNationalID"].ToString().Trim();
                    purchasedFrom = bv[0]["PurchasedFrom"].ToString().Trim();

                    string withdrawalDateStr = "";
                    string vetTreatString = "";
                    vetTreatString = formatVetTreat(Int64.Parse(bv[0]["InternalAnimalID"].ToString().Trim()), out withdrawalDateStr);

                    string exString = "";

                    int congenitalDefect = 0;
                    int siblingInfo = 0;
                    exString = formatExceptionString(dv[i]["DamSire"].ToString().Trim(), herdID,out congenitalDefect,out siblingInfo);

                    response += string.Format("<Sheep EID=\"{0}\" NationalID=\"{1}\" FreezeBrand=\"{2}\" LambAve=\"{3}\"" +
                        " LambTurn=\"{4}\" LambDLWG=\"{5:f1}\" LambInfo=\"{6}\" ScanInfo=\"{7}\" " +
                          " DueLambDate = \"{8}\" AssocRam= \"{9}\"  DateOfBirth = \"{10}\" Group =\"{11}\" DisplayType=\"1\" JoinDate=\"{12}\" " +
                             "Sex=\"{13}\" Breed=\"{14}\" Class=\"{15}\" SexText=\"{16}\" BreedText=\"{17}\" ClassText=\"{18}\" " +
                             "IsCross=\"{19}\" OldNumber=\"{20}\" TreatmentText=\"{21}\"  PurchasedFrom=\"{22}\" WithdrawalDate=\"{23}\" Alert=\"{24}\" " +
                               "Exception=\"{25}\" MilkRecords=\"{26}\" CongenitalDefect=\"{27}\" SiblingInfo=\"{28}\" />\n",
                                        electronicID.PadLeft(15, '0'),
                                        dv[i]["DamSire"].ToString().Trim(),
                                        fb,
                                        dv[i]["NumberPerLactText"].ToString().Trim(),
                                        dv[i]["TotalTurnover"].ToString().Trim(),
                                        dv[i]["AveWeightGain"],
                                        lambInfo, scanInfo, dueLambDate, assocRam,
                                        dob, grp, join, sex, breed, sClass, sexStr, breedStr, sClassStr,
                                        isCross, oldNumber, vetTreatString, purchasedFrom, withdrawalDateStr,
                                        checkIfAlert(alertView, grp), exString,
                                        formatMilkRecords((long)dv[i]["InternalAnimalID"], herdID),congenitalDefect,siblingInfo);
                }
            }
            debug += " 4 " + DateTime.Now.ToString();


            // Pick up any dams with no performance data but do have fertility
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                // Temp fix to speed up Beilificer
                int ageDays = (DateTime.Now - (DateTime.Parse(dt2.Rows[i]["DateOfBirthText"].ToString().Trim()))).Days;
                // if ((herdID == 11148) && ((ageDays < 360) || (ageDays > 720)))
                // {
                //     continue;
                // }
                if (animals.Contains(dt2.Rows[i]["NationalID"].ToString().Trim()))
                {
                    continue;
                }
                animals.Add(dt2.Rows[i]["NationalID"].ToString().Trim());
                string lambInfo = "";
                string scanInfo = "";
                string dueLambDate = "";
                string assocRam = "";
                string electronicID = "0";
                string fb = "";
                string grp = "";

                string join = dt2.Rows[i]["JoinDateText"].ToString().Trim();
                string dob = dt2.Rows[i]["DateOfBirthText"].ToString().Trim();
                string breedStr = dt2.Rows[i]["BreedText"].ToString().Trim();
                string sexStr = dt2.Rows[i]["SexText"].ToString().Trim();

                string breed = dt2.Rows[i]["Breed"].ToString().Trim();
                string sex = dt2.Rows[i]["Sex"].ToString().Trim();

                string sClassStr = dt2.Rows[i]["ClassText"].ToString().Trim();
                string sClass = dt2.Rows[i]["SheepCategory"].ToString().Trim();
                int isCross = (int)dt2.Rows[i]["IsCross"];
                string oldNumber = dt2.Rows[i]["OldNationalID"].ToString().Trim();
                string purchasedFrom = dt2.Rows[i]["PurchasedFrom"].ToString().Trim();



                DataView bullDv = new DataView(bulls);
                string aniGroup = dt2.Rows[i]["Group"].ToString().Trim();
                if ((aniGroup != "") && (aniGroup != "0"))
                {
                    bullDv.RowFilter = string.Format("Group = {0}", aniGroup);
                    if (bullDv.Count > 0)
                    {
                        assocRam = bullDv[0]["NationalID"].ToString().Trim();
                    }
                }

                electronicID = z + "2000" + i; // Give the animal a dud EID number in case non is set as we need this to get 
                                               // then downloaded to the reader
                if ((dt2.Rows[i]["ElectronicID"].ToString().Trim() != "") && (dt2.Rows[i]["ElectronicID"].ToString().Trim() != "0"))
                {
                    electronicID = dt2.Rows[i]["ElectronicID"].ToString().Trim().PadLeft(15, '0');
                }


                fb = dt2.Rows[i]["FreezeBrand"].ToString().Trim();
                lambInfo = dt2.Rows[i]["CalfDate"].ToString().Trim();
                scanInfo = dt2.Rows[i]["ScanDate"].ToString().Trim() + "-" +
                                            dt2.Rows[i]["ScanNo"].ToString().Trim() + "Lmb";
                dueLambDate = dt2.Rows[i]["DueCalfDate"].ToString().Trim();
                grp = dt2.Rows[i]["Group"].ToString().Trim();

                string withdrawalDateStr = "";

                int congenitalDefect = 0;
                int siblingInfo = 0;
                string exString = formatExceptionString(dt2.Rows[i]["NationalID"].ToString().Trim(), herdID, out congenitalDefect, out siblingInfo);


                string vetTreatString = "";
                vetTreatString = formatVetTreat(Int64.Parse(dt2.Rows[i]["InternalAnimalID"].ToString().Trim()), out withdrawalDateStr);

                response += string.Format("<Sheep EID=\"{0}\" NationalID=\"{1}\" FreezeBrand=\"{2}\"" +
                    " LambInfo=\"{3}\" ScanInfo=\"{4}\" DueLambDate=\"{5}\" AssocRam=\"{6}\" " +
                             "DateOfBirth=\"{7}\" Group=\"{8}\" DisplayType = \"2\" JoinDate=\"{9}\" " +
                             "Sex=\"{10}\" Breed=\"{11}\" Class=\"{12}\" SexText=\"{13}\" BreedText=\"{14}\" ClassText=\"{15}\" " +
                             "IsCross=\"{16}\" OldNumber=\"{17}\" TreatmentText=\"{18}\" PurchasedFrom=\"{19}\" WithdrawalDate=\"{20}\" Alert=\"{21}\" Exception=\"{22}\" " +
                              " MilkRecords=\"{23}\" CongenitalDefect=\"{24}\" SiblingInfo=\"{25}\" />\n",
                                  electronicID.PadLeft(15, '0'),
                                   dt2.Rows[i]["NationalID"].ToString().Trim(), fb,
                                    lambInfo, scanInfo, dueLambDate, assocRam,
                                        dob, grp, join, sex, breed, sClass, sexStr, breedStr,
                                           sClassStr, isCross, oldNumber,
                                            vetTreatString, purchasedFrom, withdrawalDateStr, checkIfAlert(alertView, grp), exString,
                                            formatMilkRecords((long)dt2.Rows[i]["InternalAnimalID"], herdID),congenitalDefect,siblingInfo);

            }
            debug += " 5 " + DateTime.Now.ToString();

            BeefHerd beefHerd = new BeefHerd(herdID);
            DataTable dt1 = beefHerd.ListLiveHerd(DateTime.Now.AddDays(7), 30, false);
            dv = new DataView(dt1);
            debug += " 6 " + DateTime.Now.ToString();

            dv.Sort = "ElectronicID, ShortTag";
            debug += " 6a " + DateTime.Now.ToString();

            for (int i = 0; i < dv.Count; i++)
            {

                // Temp fix to speed up Beilificer
                int ageDays = (DateTime.Now - (DateTime)dv[i]["DateOfBirth"]).Days;
                // if ((herdID == 11148) && ((ageDays < 360) || (ageDays > 720)))
                // {
                //     continue;
                // }
                if (animals.Contains(dv[i]["NationalID"].ToString().Trim()))
                {
                    continue;
                }


                string withdrawalDateStr = "";
                string eid = z + "1000" + i; // Give the animal a dud EID number in case non is set as we need this to get 
                                             // then downloaded to the reader
                if((dv[i]["ElectronicID"].ToString().Trim() != "") && (dv[i]["ElectronicID"].ToString().Trim() != "0"))
                {
                    eid = dv[i]["ElectronicID"].ToString().Trim().PadLeft(15, '0');
                }

                int congenitalDefect = 0;
                int siblingInfo = 0;

                string exString = formatExceptionString(dv[i]["NationalID"].ToString().Trim(), herdID,out congenitalDefect,out siblingInfo);

                string weightHistory = dv[i]["WeightHistoryText"].ToString().Trim();
                if (dt1.Columns.Contains("BoughtWeight"))
                {
                    weightHistory = string.Format("{0}-{1:f0},", DateTime.Parse(dv[i]["BoughtDate"].ToString()).ToShortDateString(), dv[i]["BoughtWeight"].ToString().Trim()) + weightHistory;
                }

                string vetTreatString = formatVetTreat(Int64.Parse(dv[i]["InternalAnimalID"].ToString().Trim()), out withdrawalDateStr);
                response += string.Format("<Sheep EID=\"{0}\"  NationalID=\"{1}\" SexText=\"{2}\"" +
                       " LastWeight=\"{3:f1}\" DLWG=\"{4:f1}\" DateOfBirth=\"{5}\" Group=\"{6}\" LastWeightDate=\"{7}\" DisplayType=\"3\" JoinDate=\"{8}\" BreedText=\"{9}\" " +
                       " Breed=\"{10}\" Sex=\"{11}\" IsCross=\"{12}\" OldNumber=\"{13}\" ClassText=\"{14}\" TreatmentText=\"{15}\" PurchasedFrom=\"{16}\" WeightHistoryText=\"{17}\" " +
                       " WithdrawalDate=\"{18}\" Alert=\"{19}\" Exception=\"{20}\" Dam=\"{21}\" Sire=\"{22}\" CongenitalDefect=\"{23}\" SiblingInfo=\"{24}\" />\n",
                                    eid,
                                    dv[i]["NationalID"].ToString().Trim(),
                                    dv[i]["Sex"].ToString().Trim(),
                                    dv[i]["LastWeight"],
                                    dv[i]["DLWG"],
                                    ((DateTime)dv[i]["DateOfBirth"]).ToShortDateString(),
                                    dv[i]["Group"],
                                    dv[i]["LastWeightDateText"].ToString().Trim(),
                                    DateTime.Parse(dv[i]["BoughtDate"].ToString()).ToShortDateString(),
                                    dv[i]["BreedText"].ToString().Trim(),
                                    dv[i]["BreedValue"].ToString().Trim(),
                                    dv[i]["SexValue"].ToString().Trim(),
                                    dv[i]["IsCross"].ToString().Trim(),
                                    dv[i]["OldNumber"].ToString().Trim(),
                                    dv[i]["Class"].ToString().Trim(),
                                    vetTreatString,
                                    dv[i]["BoughtFrom"].ToString().Trim(),
                                    weightHistory, withdrawalDateStr,
                                    checkIfAlert(alertView, dv[i]["Group"].ToString().Trim()), exString, dv[i]["DamText"].ToString().Trim(),
                                    dv[i]["SireText"].ToString().Trim(), congenitalDefect, siblingInfo);

            }
        }
        debug += " 7 " + DateTime.Now.ToString();
        //throw new Exception("New vet lookup-" + debug); //Keep this debug in case we ever want to analyse performance again

        response += ("</root>");
        response = response.Replace("&","");
        return(response);

    }

    private DataTable runVetVisitReport(long pEnterpriseID,long pHerdID)
    {

        StoredReport sr = new StoredReport(pEnterpriseID);
        DataTable dt = sr.GetForVetReports();


        if (breedingEventsLoaded == false)
        {
            breedingEventsLoaded = true;
            BreedingEventList brd = new BreedingEventList();
            loadedBreedingEvents = brd.FastListHerdBreedingInfo(pHerdID);
        }

        DataTable combinedTable = loadedBreedingEvents.Copy();
        combinedTable.Rows.Clear();


        for (int z = 0; z < dt.Rows.Count + 1; z++)
        {
            DataView dv = new DataView(loadedBreedingEvents);
            // For the final sweep we get the ones added into the Vet group
            string name = "";
            if (z == dt.Rows.Count)
            {
                dv.RowFilter = "Group = " + SystemConstants.VET_GROUP_IN;
                name = " In Vet Group ";
            }
            else
            {
                dv.RowFilter = dt.Rows[z]["Query"].ToString().Trim();
                name = dt.Rows[z]["ReportName"].ToString().Trim();
                // Make sure no > or < in the name as it confused XML
                name = name.Replace("<", "Less");
                name = name.Replace(">", "More");

            }

            for (int i = 0; i < dv.Count; i++)
            {
                DataRow newRow = combinedTable.NewRow();
                for (int q = 0; q < dv.Table.Columns.Count; q++)
                {
                    newRow[q] = dv[i][q];
                }
                if (z == dt.Rows.Count)
                {
                    // Check if note was recorded
                    DataTable dt3 = LifecycleRecord.ListNotes((long)newRow["InternalAnimalID"], eLifeCycleEventType.Note);
                    // Create a DataView from the DataTable.
                    DataView dv2 = new DataView(dt3);
                    dv2.Sort = "DoneDate DESC";
                    if (dv2.Count > 0)
                    {
                        name += " " + ((DateTime)dv2[dv2.Count - 1]["DoneDate"]).ToShortDateString() + " " + dv2[dv2.Count - 1]["Notes"].ToString().Trim();
                    }
                }


                newRow["ReportGroups"] = name;

                // Check not already in Table and append if it is
                bool alreadyOn = false;
                for (int q = 0; q < combinedTable.Rows.Count; q++)
                {
                    if (combinedTable.Rows[q]["FreezeBrand"].ToString().Trim() == newRow["FreezeBrand"].ToString().Trim())
                    {
                        combinedTable.Rows[q]["ReportGroups"] = combinedTable.Rows[q]["ReportGroups"].ToString().Trim() + "- " + name;
                        alreadyOn = true;
                        break;
                    }
                }
                if (alreadyOn == false)
                {
                    combinedTable.Rows.Add(newRow);
                }
            }
        }
        return (combinedTable);

    }





    // Used to produce a table row of entries to be included in a Smartphone list
    private ArrayList searchAnimals(string filterString,long pEnterpriseID,long pHerdID,string pColsToDisplay,string pSortBy,string pRedirect)
    {
        ArrayList results = new ArrayList();

        DataView dv = new DataView();
        if(filterString == "CONCEPTION RATE") {
            // 
            VetAnalysisReports vet = new VetAnalysisReports(pHerdID);
            DataTable dt;
            vet.ConceptionRate(DateTime.Now.AddMonths(-12), DateTime.Now, out dt, pSortBy);
            dv = new DataView(dt);
        }
        else if (filterString == "CULL LIST")
        {
            Herd hrd = new Herd(pHerdID);
            DataTable dt = hrd.ListMarkedForCull();
            dv = new DataView(dt);
        }
        else if (filterString == "PREGNANCY RATE")
        {
            // 
            string debug = "";
            VetAnalysisReports vet = new VetAnalysisReports(pHerdID);
            DataTable dt = vet.PeriodYearRoundFertilityAnalysis(DateTime.Now.AddMonths(-12).AddDays(-42), DateTime.Now, 21,out debug);
            dv = new DataView(dt);
        }
        else if (filterString == "VET VISIT")
        {
            DataTable dt = runVetVisitReport(pEnterpriseID,pHerdID);
            dv = new DataView(dt);
            dv.Sort = pSortBy;
        }
        else if (filterString == "RECENT NOTES")
        {
            DataTable dt = LifecycleRecord.ListEvents(pHerdID, eLifeCycleEventType.Note, DateTime.Now.AddDays(-3), DateTime.Now);
            dv = new DataView(dt);
            dv.Sort = pSortBy;
        }
        else
        {

            // Pull out anything younger than 12 months
            if (filterString != "")
            {
                filterString += " AND ";
            }
            filterString += string.Format("(DateOfBirth < '{0}' and UsedForBreeding = 1)", DateTime.Now.AddYears(-1));

            if (breedingEventsLoaded == false)
            {
                breedingEventsLoaded = true;
                BreedingEventList brd = new BreedingEventList();
                loadedBreedingEvents = brd.FastListHerdBreedingInfo(pHerdID);
            }

            dv = new DataView(loadedBreedingEvents);
            dv.RowFilter = filterString;
            dv.Sort = pSortBy;
        }
        string firstLine = pColsToDisplay;
        if (pRedirect != "")
        {
            firstLine += ",Redirect=" + pRedirect; // Use this if we want there to be clickable link to an action on the stored report
            pColsToDisplay += ",InternalAnimalID"; // Need InternalAnimalID If we want clickable link
        }

        string fieldDelimStr = ",";
        char[] fieldDelimiter = fieldDelimStr.ToCharArray();
        string[] fields = pColsToDisplay.Split(fieldDelimiter);


        results.Add(firstLine); // First line is the Column names

        for (int x = 0; x < dv.Count; x++)
        {
            string line = "";
            for (int z = 0; z < fields.Length; z++)
            {
                // The column lines have () to indicate how the column name is to be displayed on the 
                // smartphone so this needs to be removed
                string colName = fields[z];
                int bracket = colName.IndexOf("(");
                if (bracket >= 0)
                {
                    colName = colName.Substring(0, bracket);
                }

                line += dv[x][colName].ToString().Trim();
                if (z < fields.Length - 1)
                {
                    line += ",";
                }
            }

            results.Add(line);
        }
        return(results);
    }

    private string buildDynamicListXMLDatabase()
    {
        string response = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<root>\n";

        // Drop down list names on the client
        const string DONE_OBSERVED_BY = "DoneObservedBy";
        const string DONE_BY = "DoneBy";
        const string TREATMENT_REASON = "TreatmentReason";
        const string CALF_EID_EAR_TAG = "CalfEidEarTag";
        const string CALF_EAR_TAG = "CalfEarTag";
        const string BREED = "Breed";
        const string BULL_BIRTH_LIST = "BullBirthEarTag";
        const string ANIMAL_LIST = "AnimalList";
        const string NAME_BULL_PRESENT = "NameBullPresent";
        const string NAME_OF_SERVICE = "NameOfService";
        const string DISPOSED_TO = "DisposedTo";
        const string SIRE_LIST = "SireList";
        const string SIRE_LIST_SEXED = "SireListSexed";
        const string MEDICINE_LIST = "MedicineList";
        const string DRY_MEDICINE_LIST = "DryMedicineList";

        const string RECENT_EVENT_LIST = "RecentEventList";
        const string NRR_VALUE = "NrrValue";

        const string FIELD_LIST = "FieldList";
        const string LIME_STOCK_LIST = "LimeStock";
        const string SPRAY_STOCK_LIST = "SprayStock";
        const string FERT_STOCK_LIST = "FertiliserStock";
        const string READY_FOR_SERVICE_LIST = "readyForServiceList";
        const string REPEAT_HEAT_LIST = "repeatHeatList";
        const string NO_HEAT_SIXTY_LIST = "noHeatSixtyList";
        const string NO_HEAT_FORTY_TWO_LIST = "noHeatFortyTwoList";
        const string MORE_SERVICES_LIST = "moreServicesList";
        const string MISSED_HEAT_LIST = "missedHeatList";
        const string SCANNABLE_LIST = "scannableList";
        const string NEGATIVE_PD_LIST = "negativePdList";
        const string DUE_DRY_LIST = "dueDryList";
        const string DUE_CALF_LIST = "dueCalfList";
        const string FERT_TREAT_LIST = "fertTreatList";
        const string GROUP_LIST = "GroupList";

        const string BREED_CODE_LIST = "BreedCodeList";
        const string HEAT_CODE_LIST = "HeatCodeList";
        const string DNB_LIST = "DNBList";
        const string STORED_REPORT_LIST = "StoredReportList";


        HttpCookie cookie = Request.Cookies["FWSession"];
        try
        {
            string test = Request.Cookies["FWSession"].Values["UserID"];
        }
        catch
        {
            // Not yet logged in so just return empty
            response += ("</root>");
            return (response);
        }
        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        string user = cookie.Values["FullName"];
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        long userID = Int64.Parse(cookie.Values["UserID"]);

        DataView herdDV = null;
        bool insemOnly = false;
        if (package == ePackages.AITechnician)
        {
            insemOnly = true;

            Consultant admin = new Consultant(enterpriseID);
            herdDV = new DataView(admin.ListInUseHerds());
        }
        else
        {
            DataAccess da2 = new DataAccess();
            da2.LoadDatabaseTable("EnterpriseID", enterpriseID, "Herd");
            herdDV = new DataView(da2.ds.Tables[0]);
        }

        long queryHerdID = 0;
        if (Request.QueryString["HerdID"] != null)
        {
            queryHerdID = Int64.Parse(Request.QueryString["HerdID"]);
        }

        // If we have set herd ID in the query we just download that single herd
        if (queryHerdID != 0)
        {
            herdDV.RowFilter = "InternalHerdID = " + queryHerdID;
        }


        herdDV.Sort = "InternalHerdID";
        for (int z = 0; z < herdDV.Count; z++)
        {

            long herdID = (long)herdDV[z]["InternalHerdID"];
            long herdEnterpriseID = (long)herdDV[z]["EnterpriseID"];


            Herd herd = new Herd(herdID);
            breedingEventsLoaded = false;

            // Build animal Lists first, need to set flag to say if animal should be included in the breeding list
            //
            //

            DataTable animalList = new DataTable();
            DataView animalListView = new DataView();
            ArrayList animalInCowList = new ArrayList();

            animalList = herd.ListCowsForPDA(); // We do the cows first
            animalListView = new DataView(animalList);
            animalListView.Sort = "FreezeBrandNo, ShortTag";

            for (int i = 0; i < animalListView.Count; i++)
            {
                animalInCowList.Add(animalListView[i]["InternalAnimalID"].ToString().Trim());
                response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"1\"/>\n",
                       herdID, ANIMAL_LIST, animalListView[i]["ListBoxText"].ToString().Trim(), animalListView[i]["InternalAnimalID"].ToString().Trim());
            }

            animalList = (herd.ListAnimalsForPDA(false)).Tables[0]; // Do the remaining animals
            animalListView = new DataView(animalList);
            animalListView.Sort = "FreezeBrandNo, ShortTag";
            for (int i = 0; i < animalListView.Count; i++)
            {
                if (animalInCowList.Contains(animalListView[i]["InternalAnimalID"].ToString().Trim()) == false)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                          herdID, ANIMAL_LIST, animalListView[i]["ListBoxText"].ToString().Trim(), animalListView[i]["InternalAnimalID"].ToString().Trim());
                }
            }
            if (UserManager.User.CheckForRole(userID, eRoles.ReadOnly) == false)
            {


                // Build the sirelist for this specific herd
                SireStock sires = new SireStock();
                herd.LoadFromDatabase();
                DataSet ds = sires.List(herd.EnterpriseID);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                             herdID, SIRE_LIST, ds.Tables[0].Rows[i]["DisplayText"].ToString().Trim(),
                                         ds.Tables[0].Rows[i]["SireStockID"].ToString().Trim());
                }

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                             herdID, SIRE_LIST_SEXED, ds.Tables[0].Rows[i]["SireNameSexed"].ToString().Trim(),
                                         ds.Tables[0].Rows[i]["SireStockID"].ToString().Trim());
                }


                // Build observed by list first
                //
                //

                string where = string.Format("AND DoneDate > '{0}'",
                    DateTime.Now.AddMonths(-SystemConstants.LEARN_LIST_CUT_OFF).
                        ToString(SystemConstants.CULTURE));

                DataAccess da = new DataAccess();

                da.LoadDoubleJoinSpecificColumnDatabaseTable("InternalAnimalID", "LifecycleEventID", "Animal.InternalHerdID", herdID,
                                "Animal", "LifeCycleRecord", "BreedingEvent", "DoneBy", "ObservedBy", "NameOfService", "NameBullPresent");

                // Fill up our drop down lists with names and suppliers previously
                // recorded by this enterprise
                ArrayList doneObservedBy = new ArrayList();
                doneObservedBy.Add(user.Trim());

                ArrayList nameOfServiceList = new ArrayList();
                ArrayList nameBullPresentList = new ArrayList();

                for (int i = 0; i < da.ds.Tables[0].Rows.Count; i++)
                {
                    string doneBy = (da.ds.Tables[0].Rows[i]["DoneBy"]).ToString().Trim();
                    string observedBy = (da.ds.Tables[0].Rows[i]["ObservedBy"]).ToString().Trim();
                    string nameOfService = (da.ds.Tables[0].Rows[i]["NameOfService"]).ToString().Trim();
                    string nameBullPresent = (da.ds.Tables[0].Rows[i]["NameBullPresent"]).ToString().Trim();

                    if ((doneBy != "") && !(doneObservedBy.Contains(doneBy)))
                    {
                        doneObservedBy.Add(doneBy);
                    }
                    if ((observedBy != "") && !(doneObservedBy.Contains(observedBy)))
                    {
                        doneObservedBy.Add(observedBy);
                    }
                    if ((nameOfService != "") && !(nameOfServiceList.Contains(nameOfService)))
                    {
                        nameOfServiceList.Add(nameOfService);
                    }
                    if ((nameBullPresent != "") && !(nameBullPresentList.Contains(nameBullPresent)))
                    {
                        nameBullPresentList.Add(nameBullPresent);
                    }
                }
                doneObservedBy.Add(UIConstants.OTHER_STRING);
                doneObservedBy.Sort();

                for (int y = 0; y < doneObservedBy.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, DONE_OBSERVED_BY, doneObservedBy[y], doneObservedBy[y]);
                }

                // Name of service
                nameOfServiceList.Add(UIConstants.OTHER_STRING);
                nameOfServiceList.Sort();

                for (int y = 0; y < nameOfServiceList.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, NAME_OF_SERVICE, nameOfServiceList[y], nameOfServiceList[y]);
                }

                // Name bull present
                nameBullPresentList.Add(UIConstants.OTHER_STRING);
                nameBullPresentList.Sort();

                for (int y = 0; y < nameBullPresentList.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, NAME_BULL_PRESENT, nameBullPresentList[y], nameBullPresentList[y]);
                }

                // Build the Calf eartag list
                TagList tags = new TagList(herdID);
                ArrayList tagList = tags.GetFreeTagList();
                for (int y = 0; y < tagList.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, CALF_EAR_TAG, tagList[y].ToString().Trim(), tagList[y].ToString().Trim());
                }

                // Build the Calf EID Code List (new object to reset the herdID)
                ds = tags.GetFreeTagEidList(herdID: herdID);
                if (ds.Tables.Count > 0)
                {
                    DataView calfEidDV = new DataView(ds.Tables[0]);
                    calfEidDV.Sort = "FreeTagNo";

                    for (int i = 0; i < calfEidDV.Count; i++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                            herdID, CALF_EID_EAR_TAG, calfEidDV[i]["FreeTagNo"].ToString().Trim(), calfEidDV[i]["ElectronicID"].ToString().Trim());
                    }
                }

                // Build the Breed Code List
                ListManager breedCodeList = new ListManager("BreedCodes");
                ds = breedCodeList.GetList();
                DataView dvBc = new DataView(ds.Tables[0]);
                dvBc.Sort = "TypeID";

                for (int i = 0; i < dvBc.Count; i++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, BREED_CODE_LIST, dvBc[i]["TypeName"].ToString().Trim(), dvBc[i]["TypeID"].ToString().Trim());
                }

                // Build the Heat Code List
                ListManager heatCodeList = new ListManager("HeatCodes");
                ds = heatCodeList.GetList();
                DataView dvHc = new DataView(ds.Tables[0]);
                dvHc.Sort = "TypeID";

                for (int i = 0; i < dvHc.Count; i++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, HEAT_CODE_LIST, dvHc[i]["TypeName"].ToString().Trim(), dvHc[i]["TypeID"].ToString().Trim());
                }

                // Build the DNB Reason List
                ListManager dnbList = new ListManager("DoNotBreedReasons");
                ds = dnbList.GetList();
                DataView dvDc = new DataView(ds.Tables[0]);
                dvDc.Sort = "TypeID";

                for (int i = 0; i < dvDc.Count; i++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, DNB_LIST, dvDc[i]["TypeName"].ToString().Trim(), dvDc[i]["TypeID"].ToString().Trim());
                }

                // Fill the disposed to list
                ArrayList soldTo = new ArrayList();
                DataAccess da2 = new DataAccess();
                da2.LoadDatabaseTable("InternalHerdID", herdID, "Animal");

                for (int i = 0; i < da2.ds.Tables[0].Rows.Count; i++)
                {
                    string sold = (da2.ds.Tables[0].Rows[i]["MarketPersonBought"]).ToString().Trim();
                    if ((sold != "") && !(soldTo.Contains((object)sold)))
                    {
                        soldTo.Add(sold);
                    }
                }
                soldTo.Add(UIConstants.OTHER_STRING);
                soldTo.Sort();
                for (int y = 0; y < soldTo.Count; y++)
                {

                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, DISPOSED_TO, soldTo[y].ToString().Replace("<", ""), soldTo[y].ToString().Replace("<", ""));
                }



                // Dont do this list if only interested in insems
                if (insemOnly == false)
                {



                    /*
                     * Build Medical related lists next
                     */

                    ArrayList doneOBy = new ArrayList();
                    ArrayList treatmentReason = new ArrayList();

                    ArrayList numbers = new ArrayList();
                    ArrayList medicalTreatmentList = new ArrayList();
                    if ((package == ePackages.NIDairyHerdManager) || (package == ePackages.GBDairyHerdManager) ||
                         (package == ePackages.DairyHerdManager))
                    {
                        treatmentReason.Add("Mastitis");
                        treatmentReason.Add("Dry Off");
                        treatmentReason.Add("Milk Fever");
                    }
                    treatmentReason.Add("Lameness");
                    if (package == ePackages.SheepManager)
                    {
                        treatmentReason.Add("Lameness-Scald");
                        treatmentReason.Add("Lameness-Shelly Hoof");
                        treatmentReason.Add("Lameness-Foot Rot");
                        treatmentReason.Add("Lameness-CODD");
                    }

                    // Go get other folk who administered treatment from this enterprise
                    da = new DataAccess();

                    //removed the "'AND Animal.State = 1' + where" as this took away from people who have used the system.
                    da.LoadDoubleJoinSpecificColumnDatabaseTableWhere("InternalAnimalID", "LifeCycleEventID", "InternalHerdID", herdID,
                     "Animal", "LifecycleRecord", "VetinaryTreatment", "DoneBy", "HealthCode", where);

                    doneOBy.Add(user.Trim());

                    // Fill up our drop down lists with names and suppliers previously
                    // recorded by this enterprise
                    for (int i = 0; i < da.ds.Tables[0].Rows.Count; i++)
                    {
                        string name = (da.ds.Tables[0].Rows[i]["DoneBy"]).ToString().Trim();
                        if ((name != "") && !(doneOBy.Contains((object)name)))
                        {
                            doneOBy.Add(name);
                        }
                        string reason = (da.ds.Tables[0].Rows[i]["HealthCode"]).ToString().Trim();
                        if ((reason != "") && !(treatmentReason.Contains((object)reason)))
                        {
                            treatmentReason.Add(reason);
                        }
                    }
                    treatmentReason.Add(UIConstants.OTHER_STRING);
                    treatmentReason.Sort();
                    for (int y = 0; y < treatmentReason.Count; y++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                            herdID, TREATMENT_REASON, treatmentReason[y], treatmentReason[y]);
                    }

                    doneOBy.Add(UIConstants.OTHER_STRING);
                    doneOBy.Sort();
                    for (int y = 0; y < doneOBy.Count; y++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                            herdID, DONE_BY, doneOBy[y], doneOBy[y]);
                    }
                    MedicalList meds = new MedicalList(herdEnterpriseID);
                    DataSet ds2 = meds.ListMedicalStock();
                    DataTable medDt = ds2.Tables[0];
                    for (int y = 0; y < medDt.Rows.Count; y++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                             herdID, MEDICINE_LIST, medDt.Rows[y]["SummaryText"].ToString().Trim(), medDt.Rows[y]["MedicalStockID"].ToString().Trim());
                    }
                    ds2 = meds.ListMedicalStock("Dry Cow Tube");

                    medDt = ds2.Tables[0];
                    for (int y = 0; y < medDt.Rows.Count; y++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                             herdID, DRY_MEDICINE_LIST, medDt.Rows[y]["SummaryText"].ToString().Trim(), medDt.Rows[y]["MedicalStockID"].ToString().Trim());
                    }

                }
                /*
                * Build up the breeds which do take into account herd and package type
                */
                ListManager breedList = new ListManager("AnimalBreeds");

                ds = breedList.GetList();
                DataView dv = new DataView(ds.Tables[0]);
                dv.Sort = "TypeName";

                ArrayList breeds = herd.GetRecentHerdBreeds(); // Load recent ones first
                for (int i = 0; i < dv.Count; i++)
                {
                    // For NI we only want to display the NI breeds
                    if (package == ePackages.NIDairyHerdManager)
                    {
                        if (dv[i]["AphisTypeName"].ToString().Trim()
                             == "")
                        {
                            continue;
                        }
                    }
                    // For GB we only want to display the GB breeds
                    else if ((package == ePackages.GBDairyHerdManager) || (package == ePackages.AITechnician))
                    {
                        if (dv[i]["BcmsTypeName"].ToString().Trim()
                         == "")
                        {
                            continue;
                        }
                    }
                    else
                    {
                        // For the others namely NZ just stick to
                        // preconfigured NZ breeds
                        if (dv[i]["AphisTypeName"].ToString().Trim()
                            == "")
                        {
                            continue;
                        }
                        if (Animal.IsNzBreed(dv[i]["TypeID"].ToString().Trim()) == false)
                        {
                            continue;
                        }
                    }
                    string breedName = dv[i]["TypeName"].ToString().Trim();
                    if (!breeds.Contains((object)breedName))
                    {
                        breeds.Add(breedName);
                    }
                }
                for (int y = 0; y < breeds.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, BREED, breeds[y], breeds[y]);
                }


                // Build the Bull tag list
                //
                //
                //ArrayList bulls = new ArrayList();
                //bulls = herd.ListBullEarTags();
                //bulls.Add("N/A");
                //for (int y = 0; y < bulls.Count; y++)
                //{
                //    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                //                        herdID, BULL_BIRTH_LIST, bulls[y], bulls[y]);
                //}

                ds = herd.ListBullEarTagsWithName();
                if (ds.Tables.Count > 0)
                {
                    DataView bullIDName = new DataView(ds.Tables[0]);

                    for (int i = 0; i < bullIDName.Count; i++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                            herdID, BULL_BIRTH_LIST, bullIDName[i]["Name"].ToString().Trim(), bullIDName[i]["Value"].ToString().Trim());
                    }
                }


                GroupUI ui = new GroupUI(herdID);
                DataView groupDv = new DataView(ui.LoadDropDownList());
                for (int i = 0; i < groupDv.Count; i++)
                {
                    string gName = groupDv[i]["Name"].ToString().Trim();
                    gName = gName.Replace("<", "Less");
                    gName = gName.Replace(">", "More");
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                     herdID, GROUP_LIST, gName, groupDv[i]["ID"]);
                }


                DataView eventList = null;
                string insemData;
                buildEventNRRList(herdID, out eventList, out insemData);
                eventList.Sort = "DoneDate";

                // Build the recent events list
                //
                //
                for (int i = 0; i < eventList.Count; i++)
                {
                    // Ignore events more than 7 days ago
                    if (DateTime.Parse(eventList[i]["DateText"].ToString().Trim()) < DateTime.Now.AddDays(-7))
                    {
                        continue;
                    }
                    string eventStr = string.Format("{2},{1},{0},{3}", eventList[i]["FreezeBrand"].ToString().Trim().PadLeft(4),
                        eventList[i]["TypeText"].ToString().Trim(), eventList[i]["DateText"].ToString().Trim(),
                            eventList[i]["SireName"].ToString().Trim());
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, RECENT_EVENT_LIST, eventStr, "");
                }

                // Put the insem NRR data
                response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                        herdID, NRR_VALUE, insemData, "");
            }
            // Set up to hold reports requested by Cogent
            if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.SmartPhoneLists))
            {
                StoredReport sr = new StoredReport(enterpriseID);
                DataTable allReports = sr.ListPublicByType(eStoredReportType.SmartPhone);

                for (int y = 0; y < allReports.Rows.Count; y++)
                {
                    if((allReports.Rows[y]["PlugInID"] != null) && (allReports.Rows[y]["PlugInID"].ToString().Trim() != "") &&
                            (allReports.Rows[y]["PlugInID"].ToString().Trim() != "0")) {
                        // Ignore plug in specific reports that you dont have
                        if (UserPlugIn.CheckForPlugIn(enterpriseID,
                                (ePlugIns)Int32.Parse(allReports.Rows[y]["PlugInID"].ToString().Trim())) == false)
                        {
                            continue;
                        }
                    }
                    ArrayList itemsToAdd = searchAnimals(allReports.Rows[y]["Query"].ToString().Trim(),herdEnterpriseID,herdID,
                                    allReports.Rows[y]["ColumnIDList"].ToString().Trim(),
                                    allReports.Rows[y]["SortString"].ToString().Trim(), allReports.Rows[y]["RedirectUrl"].ToString().Trim());
                    for (int p = 0; p < itemsToAdd.Count; p++)
                    {
                        response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{3}\" IsBreeding=\"0\"/>\n",
                                    herdID, STORED_REPORT_LIST, allReports.Rows[y]["ReportName"].ToString().Trim(), itemsToAdd[p]);
                    }
                }
            }


            if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.SmartPhoneReports))
            {
                BreedingEventList brd = new BreedingEventList();
                ArrayList readyForService,repeatHeat,noHeatSixty,noHeatFortyTwo,moreServices,missedHeat,inVWP,
                    scannable,negativePD,dueDryOff,dueCalf,fertTreatment;
                brd.BuildBreedMgmtLists(herdEnterpriseID, out readyForService,
                   out repeatHeat, out noHeatSixty, out noHeatFortyTwo, out moreServices,
                   out missedHeat, out inVWP, out scannable, out negativePD,
                   out dueDryOff, out dueCalf,out fertTreatment, 7,
                   DateTime.Now);

                for (int y = 0; y < readyForService.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,READY_FOR_SERVICE_LIST, readyForService[y].ToString().Trim(), readyForService[y].ToString().Trim());
                }
                for (int y = 0; y < repeatHeat.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,REPEAT_HEAT_LIST, repeatHeat[y].ToString().Trim(), repeatHeat[y].ToString().Trim());
                }
                for (int y = 0; y < noHeatSixty.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,NO_HEAT_SIXTY_LIST, noHeatSixty[y].ToString().Trim(), noHeatSixty[y].ToString().Trim());
                }
                for (int y = 0; y < noHeatFortyTwo.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,NO_HEAT_FORTY_TWO_LIST, noHeatFortyTwo[y].ToString().Trim(), noHeatFortyTwo[y].ToString().Trim());
                }
                for (int y = 0; y < moreServices.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,MORE_SERVICES_LIST, moreServices[y].ToString().Trim(), moreServices[y].ToString().Trim());
                }
                for (int y = 0; y < missedHeat.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,MISSED_HEAT_LIST, missedHeat[y].ToString().Trim(), missedHeat[y].ToString().Trim());
                }
                for (int y = 0; y < scannable.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,SCANNABLE_LIST, scannable[y].ToString().Trim(), scannable[y].ToString().Trim());
                }
                for (int y = 0; y < negativePD.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,NEGATIVE_PD_LIST, negativePD[y].ToString().Trim(), negativePD[y].ToString().Trim());
                }
                for (int y = 0; y < dueDryOff.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,DUE_DRY_LIST, dueDryOff[y].ToString().Trim(), dueDryOff[y].ToString().Trim());
                }
                for (int y = 0; y < dueCalf.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,DUE_CALF_LIST, dueCalf[y].ToString().Trim(), dueCalf[y].ToString().Trim());
                }
                for (int y = 0; y < fertTreatment.Count; y++)
                {
                    response += string.Format("<DynamicList HerdID=\"{0}\" ListName=\"{1}\" Name=\"{2}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                 herdID,FERT_TREAT_LIST, fertTreatment[y].ToString().Trim(), fertTreatment[y].ToString().Trim());
                }
            }


        }

        if (insemOnly == false)
        {
            // Build the list of fields
            // Note these are stored against a 0 herd ID for now, but we may need to change this to support multiple field lists
            //
            FieldCollection fields = new FieldCollection(enterpriseID);

            // Retrieve the data source from session state.
            DataTable fieldDt = fields.ListAllFields();
            for (int y = 0; y < fieldDt.Rows.Count; y++)
            {
                response += string.Format("<DynamicList HerdID=\"0\" ListName=\"{0}\" Name=\"{1}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                     FIELD_LIST, fieldDt.Rows[y]["ListBoxText"].ToString().Trim(), fieldDt.Rows[y]["InternalFieldID"].ToString().Trim());
            }

            DataTable limeDt = fields.ListLiveApplicationStock(eApplicationType.Lime);
            for (int y = 0; y < limeDt.Rows.Count; y++)
            {
                response += string.Format("<DynamicList HerdID=\"0\" ListName=\"{0}\" Name=\"{1}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                     LIME_STOCK_LIST, limeDt.Rows[y]["Name"].ToString().Trim(), limeDt.Rows[y]["ApplicationStockID"].ToString().Trim());
            }

            DataTable sprayDt = fields.ListLiveApplicationStock(eApplicationType.Spray);
            for (int y = 0; y < sprayDt.Rows.Count; y++)
            {
                response += string.Format("<DynamicList HerdID=\"0\" ListName=\"{0}\" Name=\"{1}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                     SPRAY_STOCK_LIST, sprayDt.Rows[y]["Name"].ToString().Trim(), sprayDt.Rows[y]["ApplicationStockID"].ToString().Trim());
            }

            DataTable fertDt = fields.ListLiveApplicationStock(eApplicationType.Fertiliser);
            for (int y = 0; y < fertDt.Rows.Count; y++)
            {
                response += string.Format("<DynamicList HerdID=\"0\" ListName=\"{0}\" Name=\"{1}\" Value=\"{2}\" IsBreeding=\"0\"/>\n",
                                     FERT_STOCK_LIST, fertDt.Rows[y]["Name"].ToString().Trim(), fertDt.Rows[y]["ApplicationStockID"].ToString().Trim());
            }



        }


        response = response.Replace("&","");
        response += ("</root>");
        return (response);
    }


    private void buildEventNRRList(long pInternalHerdID,out DataView pEventList,out string pInsemData)
    {
        // We add on NRR to this one
        BreedingEventList brdList = new BreedingEventList();
        pInsemData = "";

        DataTable dt = brdList.ListDoneHerdBreedingEvents(pInternalHerdID, DateTime.Now.AddMonths(-3), DateTime.Now,"");
        dt.Columns.Add("TypeText", typeof(string));
        dt.Columns.Add("DateText", typeof(string));
        dt.Columns.Add("SireName", typeof(string));


        DataTable returns = new DataTable();
        DataColumn newColumn;
        newColumn = new DataColumn("InternalAnimalID", typeof(long));
        returns.Columns.Add(newColumn);
        DataColumn[] colArray = new DataColumn[1];
        colArray[0] = newColumn;
        returns.PrimaryKey = colArray;
        newColumn = new DataColumn("LastServedDate", typeof(DateTime));
        returns.Columns.Add(newColumn);

        int insems = 0;
        int eligibleInsems = 0;

        int eligibleReturns = 0;
        int shortLongs = 0;
        ArrayList servedOnce = new ArrayList();
        ArrayList returnedOnce = new ArrayList();

        pEventList = new DataView(dt);
        pEventList.RowFilter = string.Format("EventType = {0} OR EventType = {1}",(int)eBreedingEventType.AIService,(int)eBreedingEventType.BullService);
        pEventList.Sort = "InternalAnimalID, DoneDate";

        for (int i = 0; i < pEventList.Count; i++)
        {
            pEventList[i]["TypeText"] = ((eBreedingEventType)pEventList[i]["EventType"]).ToString();
            pEventList[i]["DateText"] = ((DateTime)pEventList[i]["DoneDate"]).ToShortDateString();

            if (((eBreedingEventType)pEventList[i]["EventType"] == eBreedingEventType.AIService))
            {
                insems += 1;

                long animalID = (long)pEventList[i]["InternalAnimalID"];
                DateTime doneDate = (DateTime)pEventList[i]["DoneDate"];

                if (servedOnce.Contains(animalID) == false)
                {
                    servedOnce.Add(animalID);
                    if ((DateTime.Now - doneDate).Days >= SystemConstants.NRR_DAYS)
                    {
                        // NRR Stats
                        eligibleInsems += 1;
                    }
                }


                DataRow row = returns.Rows.Find(animalID);
                if (row == null)
                {
                    row = returns.NewRow();
                    row["InternalAnimalID"] = animalID;
                    row["LastServedDate"] = doneDate;
                    returns.Rows.Add(row);
                }
                else
                {
                    int days = (doneDate - (DateTime)row["LastServedDate"]).Days;
                    if ((days >= 18) && (days <= 24))
                    {
                        eligibleReturns += 1;
                    }
                    else
                    {
                        if ((DateTime.Now - doneDate).Days >= SystemConstants.NRR_DAYS)
                        {
                            shortLongs += 1;
                        }
                    }
                    row["LastServedDate"] = (DateTime)pEventList[i]["DoneDate"];

                }

            }
            if (((eBreedingEventType)pEventList[i]["EventType"] == eBreedingEventType.AIService) ||
                                   ((eBreedingEventType)pEventList[i]["EventType"] == eBreedingEventType.BullService))
            {

                string name = "";
                if ((pEventList[i]["SireStockID"] != null) &&
                    (pEventList[i]["SireStockID"].ToString().Trim() != "") &&
                            ((long)pEventList[i]["SireStockID"] != 0))
                {
                    SireStock sire = new SireStock();
                    DataRow sRow = sire.View((long)pEventList[i]["SireStockID"]);
                    name = sRow["Name"].ToString().Trim();
                }
                else
                {
                    name = pEventList[i]["NameOfService"].ToString().Trim() + " " +
                     pEventList[i]["NameBullPresent"].ToString().Trim() + " " +
                     pEventList[i]["EarTagBullPresent"].ToString().Trim();
                }
                pEventList[i]["SireName"] = name;

            }
        }
        if (insems > 0)
        {
            int nrrRate = 0;
            if (eligibleInsems > 0)
            {
                nrrRate = (int)((eligibleInsems - eligibleReturns) * 100 / eligibleInsems);
            }
            pInsemData = string.Format("{0} insems,Eligible={3},rtns={2},NRR={1}%,Short/Long={4}", insems, nrrRate, eligibleReturns, eligibleInsems,shortLongs);
        }

    }



    private string buildAppXMLDatabase()
    {
        string response = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<root>\n";
        vetTreatList = null;
        ArrayList animals = new ArrayList();
        ArrayList animalAllReadyOn = new ArrayList();


        string debug = DateTime.Now.ToString();

        HttpCookie cookie = Request.Cookies["FWSession"];
        try {
            string test = Request.Cookies["FWSession"].Values["UserID"];
        }
        catch {
            // Not yet logged in so just return empty
            response += ("</root>");
            return(response);
        }
        bool insemsOnly = false;
        bool isCogentTech = false;
        long queryHerdID = 0;

        if(Request.QueryString["HerdID"] != null) {
            queryHerdID = Int64.Parse(Request.QueryString["HerdID"]);
        }


        ePackages package = (ePackages)Int32.Parse(cookie.Values["Package"]);
        long enterpriseID = Int64.Parse(cookie.Values["EnterpriseID"]);
        long userID = Int64.Parse(cookie.Values["UserID"]);
        DataView herdDV = null;
        if ((package == ePackages.AITechnician) || (package == ePackages.BeefContractManager))
        {
            if ((package == ePackages.AITechnician) && (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.Cogent) == false))
            {
                insemsOnly = true;
            }
            if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.Cogent))
            {
                isCogentTech = true;
            }
            Consultant admin = new Consultant(enterpriseID);
            herdDV = new DataView(admin.ListInUseHerds());
        }
        else
        {
            DataAccess da2 = new DataAccess();
            da2.LoadDatabaseTable("EnterpriseID", enterpriseID, "Herd");
            herdDV = new DataView(da2.ds.Tables[0]);
        }

        if(userID == 24550) {
            isCogentTech = true; // Hack for wheatsheaf open day just to speed up synch
        }

        // If we have set herd ID in the query we just download that single herd
        if(queryHerdID != 0) {
            herdDV.RowFilter = "InternalHerdID = " + queryHerdID;
        }


        herdDV.Sort = "InternalHerdID";
        debug += "-" + DateTime.Now.ToString();
        for(int z=0;z<herdDV.Count;z++)
        {
            long herdID = (long)herdDV[z]["InternalHerdID"];
            AlertGroup ag = new AlertGroup(herdID);
            DataTable at = ag.ListGroups();
            DataView alertView = new DataView(at);
            Herd newHerd = new Herd(herdID);
            DataTable dt = new DataTable();
            DataRow r = newHerd.ViewHerd();
            DataTable rams = null;
            DataView ramsDv = new DataView(rams);

            debug += "-" + DateTime.Now.ToString();


            bool isSheep = false;

            if ((eAnimalType)r["HerdType"] == eAnimalType.Sheep)
            {
                isSheep = true;
                rams = newHerd.ListRams();
                ramsDv = new DataView(rams);
            }

            // For AI techs we need to query this information across all of the herds to aid performance
            if ((package == ePackages.AITechnician) && (queryHerdID == 0))  {
                dt = newHerd.CattleFastListAnimalsWithBreedingDetails(insemsOnly,enterpriseID);
                // Need to skip all the other herds
                z = herdDV.Count;
            }
            else {
                if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.MilkRecords))
                {
                    dt = newHerd.CattleFastListAnimalsWithBreedingMilkDetails(insemsOnly);
                }
                else
                {
                    dt = newHerd.CattleFastListAnimalsWithBreedingDetails(insemsOnly);
                }
            }
            debug += "-" + DateTime.Now.ToString();


            DataView dv = new DataView(dt);

            dv.Sort = "InternalHerdID,FreezeBrandNo";
            for(int i=0;i<dv.Count;i++) {
                // For beef herds we only put on the breeding animals in
                // this bit
                if(isSheep) {
                    if((DateTime.Now - DateTime.Parse(dv[i]["DateOfBirth"].ToString().Trim())).Days < 365) {
                        continue;
                    }
                }
                else if((dv[i]["UsedForBreeding"].ToString().Trim() == "0") && UserPlugIn.CheckForPlugIn(enterpriseID,ePlugIns.BeefManager)) {
                    continue;
                }
                // Also only add BCM animals to cogent account
                if ((dv[i]["UsedForBreeding"].ToString().Trim() == "0") && (package == ePackages.AITechnician) && UserPlugIn.CheckForPlugIn(enterpriseID,ePlugIns.Cogent))
                {
                    continue;
                }

                animals.Add(dv[i]["NationalID"].ToString().Trim());

                if(UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.Cogent)) {
                    // For Cogent folk we swap the history with the most recent lactation history as this is what they want
                    dv[i]["BreedHistoryString"] = dv[i]["RecentLactationBreedHistoryString"];
                }

                string exceptionString = "";
                string scoreString = "";
                string groupText = "";
                if (isSheep)
                {
                    // We add a couple of extra fields only for sheep
                    if (dv[i]["Group"].ToString().Trim() != "")
                    {
                        ramsDv.RowFilter = string.Format("Group = {0}", dv[i]["Group"].ToString().Trim());
                        DataAccess da = new DataAccess();
                        string where = string.Format("ID = {0}", dv[i]["Group"].ToString().Trim());
                        da.LoadDatabaseTable("InternalHerdID", herdID, where, "GroupName");
                        if (da.ds.Tables[0].Rows.Count != 0)
                        {
                            groupText = da.ds.Tables[0].Rows[0]["Name"].ToString();
                        }
                        if (ramsDv.Count > 0)
                        {
                            dv[i]["LastServedTo"] = ramsDv[0]["NationalID"].ToString().Trim();
                        }
                    }

                    // exceptionString = formatExceptionString(dv[i]["NationalID"].ToString().Trim(), herdID);
                    //scoreString = formatScoreString((long)dv[i]["InternalAnimalID"]);
                }

                string withdrawalDateStr = "";
                string vetTreatString = "";
                string mRecords = "";
                if (insemsOnly == false)
                {
                    // This is a test just for dourie to see what if we can improve performance
                    if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.MilkRecords))
                    {
                        mRecords = dv[i]["MobileCurrentLactView"].ToString().Trim() + dv[i]["MobilePreviousLactView"].ToString().Trim();
                    }
                    if (!isCogentTech)
                    {
                        // TEMP FIX FOR DOURIE
                        if (enterpriseID != 16679)
                        {
                            vetTreatString = formatVetTreat(Int64.Parse(dv[i]["InternalAnimalID"].ToString().Trim()), out withdrawalDateStr);
                        }
                    }

                }
                string eid = "1"; // set this to a default value so that we can get non EIDed animals to the reader
                if (dv[i]["ElectronicID"].ToString().Trim() != "")
                {
                    eid = dv[i]["ElectronicID"].ToString().Trim().PadLeft(15, '0');
                }

                string animalID = dv[i]["NationalID"].ToString().Trim();
                if (dv[i]["Name"].ToString().Trim() != "")
                {
                    animalID = string.Format("{0} ({1})", dv[i]["NationalID"].ToString().Trim(), dv[i]["Name"].ToString().Trim());
                }


                response += string.Format("<Cow ElectronicID=\"{0}\"  NationalID=\"{1}\" InternalAnimalID=\"{2}\" FreezeBrand=\"{3}\"" +
                    " FreezeBrandNo=\"{4}\"  BreedText=\"{5}\" DateOfBirth=\"{6}\" JoinDate=\"{7}\" Group=\"{8}\" BreedHistoryText=\"{9}\" " +
                    " SexText=\"{10}\" NotesString=\"{11}\" LastServedDate=\"{12}\" LastCalvedDate=\"{13}\" LastServedTo=\"{14}\" " +
                    " TreatmentText=\"{15}\" PurchasedFrom=\"{16}\" Sire=\"{17}\" Fqas=\"{18}\" MilkRecordsText=\"{19}\" " +
                     "Age=\"{20:f0}\" InBreedingPotential=\"{21}\" InternalHerdID = \"{22}\" Dam = \"{23}\" CurrentLactation = \"{24}\" " +
                      "CurrentStatus = \"{25}\" Alert =\"{26}\" Exception=\"{27}\" ScoreHistory=\"{28}\" NFCID=\"{29}\" />",
                                    eid,
                                    animalID,
                                    dv[i]["InternalAnimalID"].ToString().Trim(),
                                    dv[i]["FreezeBrand"].ToString().Trim(),
                                    dv[i]["FreezeBrandNo"].ToString().Trim(),
                                    dv[i]["BreedText"].ToString().Trim(),
                                    dv[i]["DateOfBirth"].ToString().Trim(),
                                    dv[i]["JoinDate"].ToString().Trim(),
                                   groupText,
                                    dv[i]["BreedHistoryString"].ToString().Trim().Replace("\"",""),
                                    dv[i]["SexText"].ToString().Trim(),
                                    dv[i]["NotesString"].ToString().Trim().Replace("\"",""),
                                    dv[i]["LastServedDate"].ToString().Trim(),
                                    dv[i]["LastCalvedDate"].ToString().Trim(),
                                    dv[i]["LastServedTo"].ToString().Trim().Replace("\"",""),
                                    vetTreatString,
                                    dv[i]["PurchasedFrom"].ToString().Trim(),
                                    dv[i]["Sire"].ToString().Trim().Replace("\"",""),
                                    dv[i]["Fqas"].ToString().Trim(),
                                    mRecords,
                                    (DateTime.Now-(DateTime.Parse(dv[i]["DateOfBirth"].ToString().Trim()))).Days/30.5,
                                         formatInBreedingPotential((long)dv[i]["InternalAnimalID"]),
                                         dv[i]["InternalHerdID"].ToString().Trim(), dv[i]["Dam"].ToString().Trim(),
                                         dv[i]["CurrentLactation"].ToString().Trim(), dv[i]["CurrentStatus"].ToString().Trim(),
                                         checkIfAlert(alertView, dv[i]["Group"].ToString().Trim()), exceptionString,scoreString, dv[i]["NFCID"].ToString().Trim());
            }
            debug += "-" + DateTime.Now.ToString();

            // WE hard code the devon farm enterprise ID as it is a single farm in South Africa that wont sync when we switch it on. 
            if (UserPlugIn.CheckForPlugIn(enterpriseID, ePlugIns.BeefManager) && (enterpriseID != 18443) && (insemsOnly == false) && (isCogentTech == false))
            {

                BeefHerd beefHerd = new BeefHerd(herdID);
                DataTable dt2 = beefHerd.ListLiveHerd(DateTime.Now.AddDays(7), 30, false);
                dv = new DataView(dt2);
                dv.Sort = "ElectronicID, ShortTag";
                for(int i=0;i<dv.Count;i++) {
                    if(animals.Contains(dv[i]["NationalID"].ToString().Trim())) {
                        continue;
                    }
                    string withdrawalDateStr = "";
                    string vetTreatString = "";

                    vetTreatString = formatVetTreat(Int64.Parse(dv[i]["InternalAnimalID"].ToString().Trim()), out withdrawalDateStr);
                    string exceptionString = "";
                    string scoreString = "";
                    string groupText = "";
                    if (isSheep)
                    {
                        //exceptionString = formatExceptionString(dv[i]["NationalID"].ToString().Trim(), herdID);
                        // scoreString = formatScoreString((long)dv[i]["InternalAnimalID"]);
                    }
                    if (dv[i]["Group"].ToString().Trim() != "")
                    {
                        ramsDv.RowFilter = string.Format("Group = {0}", dv[i]["Group"].ToString().Trim());
                        DataAccess da = new DataAccess();
                        string where = string.Format("ID = {0}", dv[i]["Group"].ToString().Trim());
                        da.LoadDatabaseTable("InternalHerdID", herdID, where, "GroupName");
                        if (da.ds.Tables[0].Rows.Count != 0)
                        {
                            groupText = da.ds.Tables[0].Rows[0]["Name"].ToString();
                        }
                    }


                    string weightHistory = dv[i]["WeightHistoryText"].ToString().Trim();
                    if (dt2.Columns.Contains("BoughtWeight"))
                    {
                        weightHistory = string.Format("{0}-{1:f0},", DateTime.Parse(dv[i]["BoughtDate"].ToString()).ToShortDateString(), dv[i]["BoughtWeight"].ToString().Trim()) + weightHistory;
                    }


                    string eid = "1"; // set this to a default value so that we can get non EIDed animals to the reader
                    if (dv[i]["ElectronicID"].ToString().Trim() != "")
                    {
                        eid = dv[i]["ElectronicID"].ToString().Trim().PadLeft(15, '0');
                    }
                    response += string.Format("<Cow ElectronicID=\"{0}\"  NationalID=\"{1}\" SexText=\"{2}\" InternalAnimalID=\"{3}\"" +
                        " LastWeight=\"{4:f1}\" DLWG=\"{5:f1}\" DateOfBirth=\"{6}\" Group=\"{7}\" LastWeightDate=\"{8}\" JoinDate=\"{9}\" BreedText=\"{10}\" " +
                        "  TreatmentText=\"{11}\" PurchasedFrom=\"{12}({19} {20}mvs)\" WeightHistoryText=\"{13}\" BoughtPrice=\"{14}\" Age=\"{15:f0}\" FreezeBrand=\"{16}\" " +
                        " InternalHerdID=\"{17}\" Dam=\"{18}\"  Sire=\"{19}\" Alert=\"{22}\" Exception=\"{23}\" ScoreHistory=\"{24}\" NFCID=\"{25}\" />\n",
                                        eid,
                                        dv[i]["NationalID"].ToString().Trim(),
                                        dv[i]["Sex"].ToString().Trim(),
                                        dv[i]["InternalAnimalID"].ToString().Trim(),
                                        dv[i]["LastWeight"],
                                        dv[i]["DLWG"],
                                        ((DateTime)dv[i]["DateOfBirth"]).ToShortDateString(),
                                       groupText,
                                        dv[i]["LastWeightDateText"].ToString().Trim(),
                                        DateTime.Parse(dv[i]["BoughtDate"].ToString()).ToShortDateString(),
                                        dv[i]["BreedText"].ToString().Trim(),
                                        vetTreatString,
                                        dv[i]["BoughtFrom"].ToString().Trim(),
                                        weightHistory,
                                        dv[i]["BoughtPrice"].ToString().Trim(),(DateTime.Now-(DateTime.Parse(dv[i]["DateOfBirth"].ToString().Trim()))).Days/30.5,
                                        dv[i]["FreezeBrand"].ToString().Trim(), herdID, dv[i]["DamText"].ToString().Trim(), dv[i]["SireText"].ToString().Trim(),
                                        dv[i]["Fqas"].ToString().Trim(), dv[i]["NoOfFarmMoves"].ToString().Trim(),
                                        checkIfAlert(alertView, dv[i]["Group"].ToString().Trim()), exceptionString, scoreString, dv[i]["NFCID"].ToString().Trim());

                }
            }
        }
        debug += "-" + DateTime.Now.ToString();





        // Some &s cause problems so we remove most but still need the ones for any line breaks
        response = response.Replace("&","");
        response = response.Replace("lt;","&lt;");
        response = response.Replace("gt;","&gt;");

        response += ("</root>");
        return(response);

    }

</script>