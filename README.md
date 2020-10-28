# Mail Services IP Delta<br>Change Log and Import Lists

IP Delta checks, resolves and parses the output for SPF DNS record. It then is committed to github.

## Lists are in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format

- 10.0.0.0/8 (10.0.0.0 ... 10.255.255.255)

## Currently Monitored Networks

- **Primary Business Mail Providers**<br>(Mailbox Providers)
  - [x] Google Email Services (GApps) [[\_spf.google.com](_spf.google.com)]
  - [x] Microsoft Office 365 and Azure [[spf.protection.outlook.com](spf.protection.outlook.com)]
  - [x] ProtonMail [[\_spf.protonmail.ch](_spf.protonmail.ch)]
- **Secondary Business Mail Providers**<br>(Filtering and Security)<br>These may not be valid as I have very little knowledge of them.
  - [ ] MimeCast
  - [x] MessageLabs [[spf.messagelabs.com](spf.messagelabs.com)]
  - [x] Symantec [[symantec.net](symantec.net)]
- **Non-Mail Service Providers**<br>(Vastly Automated and uses Email as a Primary Method to Communicate)
  - [x] JIRA [[jira.com](jira.com)]
  - [x] Salesforce [[\_spf.salesforce.com](_spf.salesforce.com)]
  - [x] ServiceNow [[\_spfinc1.servicenow.com](_spfinc1.servicenow.com)]
  - [x] ZenDesk [[mail.zendesk.com](mail.zendesk.com)]
- **Bluk Mail Services**<br>(Rarely Legitimate Mail)
  - [x] MailChimp [[servers.mcsv.net](servers.mcsv.net)]
  - [x] MailGun [[spf1.mailgun.org](spf1.mailgun.org)], [[spf2.mailgun.org](spf2.mailgun.org)]
  - [x] MailJet [[spf.mailjet.com](spf.mailjet.com)]
    - MailJet has been purchased by MailGun
  - [x] MarkeTo [[mktomail.com](mktomail.com)]
  - [x] SendGrid [[sendgrid.net](sendgrid.net)]

## To Have a Service Added

Contact me on GitHub about doing this for other services, it's not hard to set up at all.

1. Open a New Issue.
2. Provide the Name of the Service ("JIRA")
3. Provide the Main SPF Record ("\_spf.atlassian.net")
4. Provide What Type of Service this is.
   - Mailbox Provider (MBX)
   - Mail Tranfer Agent (MTA)
   - Non-Mail Service Providers ("JIRA")
   - Bulk Mail Sender ("Sendgrid")
