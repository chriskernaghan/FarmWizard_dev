<%@ Application language="C#" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="Utilities" %>
<%@ import Namespace="System.Web.Mail" %>
<%@ import Namespace="System.Data" %>

<script runat="server">



    public void Application_Error(Object sender, EventArgs e) {
        // Code that runs when an unhandled error occurs
        string user = "Unknown";
        string enterpriseID = "";
        string herdID = "";
        string userID = "";

        try
        {
            HttpCookie cook = Request.Cookies["FWSession"];
            user = cook.Values["FullName"].ToString().Trim();
            enterpriseID = cook.Values["EnterpriseID"].ToString().Trim();
            userID = cook.Values["UserID"].ToString().Trim();
            herdID = cook.Values["HerdID"].ToString().Trim();
        }
        catch
        {
            //ignore
        }

        Exception ex = Server.GetLastError();
        MailMessage Message = new MailMessage();
        Message.To = "info@farmwizard.com;soniya@farmwizard.com";
        Message.From = "exception@farmwizard.com";
        Message.Subject = "Unhandled Exception";
        Message.Body = "User is: " + user +
                    "\nException: " + ex.ToString() +
               "\nEx Message: " + ex.Message + "\nStack Trace: " + ex.StackTrace +
                    "\nSource: " + ex.Source + "\nTargetSite: " + ex.TargetSite +
        "\n\n\nForm is: \n" + Request.Form.ToString() +
        "\nRequest is: \n" + Request.QueryString;

        // If we exception we free up our form submission semaphore
        Session["formSubmissionInProcess"] = false;

        // Need to ensure another exception does not throw us into infinite
        // loop
        try
        {
            SmtpMail.SmtpServer = SystemConstants.SMTP_SERVER;
            SmtpMail.Send(Message);
        }
        catch
        {
            //ignore
        }

        try
        {
            //send message directly to slack

            SlackIntegration.SlackClient client = new SlackIntegration.SlackClient();

            NameValueCollection nvc = new NameValueCollection();
            if (!string.IsNullOrEmpty(enterpriseID))
                nvc.Add("EnterpriseID", enterpriseID);
            if (!string.IsNullOrEmpty(userID))
                nvc.Add("UserID", userID);
            if (!string.IsNullOrEmpty(herdID))
                nvc.Add("HerdID", herdID);

            string sForm = Request.Form.ToString();
            string sQuery = Request.Url.Query.ToString();
            if (!string.IsNullOrEmpty(sForm))
	        {
		    if (!sForm.Contains("VIEWSTATE"))
                nvc.Add("Form", sForm);
	        }
            if (!string.IsNullOrEmpty(sQuery))
                nvc.Add("Params", sQuery);


            client.PostException(ex, UserName: user, ExtraData: nvc);

        }
        catch
        {
            //ignore
        }

        Response.Redirect("error.aspx");
        return;
    }

    protected void Session_Start(Object sender, EventArgs e)
    {

        // Session to hold list of done / observerBy
        // this is to stop constant reloading of page
        Session["formsDoneObservedBy"] = new ArrayList();
        Session["animalList"] = new DataTable(); // Back compatibility
        Session["cowList"] = new DataTable(); // Back compatibility

        // These variables are used for calculation off inbreeding coefficients to hold the siretree of
        // sires on the stock list
        Session["SireCache"] = new ArrayList();
        Session["SireCacheIndex"] = new ArrayList();

        Session["DamCache"] = new ArrayList();
        Session["DamCacheIndex"] = new ArrayList();

        // Caching parameters
        for(int i=0;i<SystemConstants.MAX_HERDS;i++) {
            Session["animalList" +  i] = new DataTable();
            Session["cowList" +  i] = new DataTable();
            Session["changeList" + i] = new ArrayList();
        }
    }

    void Application_Start(Object src, EventArgs e)
    {
        // Semaphore used to serialise access to form submissions
        // from AgantGo
        Application["pdaSubmissionInProcess"] = new Boolean();
        Application["pdaSubmissionInProcess"] = false;

    }


</script>
