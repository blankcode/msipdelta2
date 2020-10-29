# Mail Services IP Delta<br>Change Log and Import Lists

We can dig/nslookup DNS records fairly easily but, have you ever wished you knew what the IPs for a sender were before now? Or just want to automate adding the service IPs to a system easily? This project keeps a current list of the IPv4 and IPv6 addresses and keeps a running history of the IPs listed in the SPF text records for the services noted below. I've made the code public for review and even private deployment.

## Lists are in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format

- 10.0.0.0/8 (10.0.0.0 ... 10.255.255.255)

## Currently Monitored Networks

- **Primary Business Mail Providers**<br>(Mailbox Providers)
  - [x] Google Email Services (GApps) [[\_spf.google.com](_spf.google.com)]
  - [x] Microsoft Office 365 and Azure [[spf.protection.outlook.com](spf.protection.outlook.com)]
  - [x] ProtonMail [[\_spf.protonmail.ch](_spf.protonmail.ch)]
- **Secondary Business Mail Providers**<br>(Filtering and Security)
  - [x] MimeCast Global [[\_netblocks.mimecast.com](_netblocks.mimecast.com)]
  - By Region
    - [x] MimeCast US [[us.\_netblocks.mimecast.com](us._netblocks.mimecast.com)]
    - [x] MimeCast EU [[eu.\_netblocks.mimecast.com](eu._netblocks.mimecast.com)]
    - [x] MimeCast DE [[de.\_netblocks.mimecast.com](de._netblocks.mimecast.com)]
    - [x] MimeCast CA [[ca.\_netblocks.mimecast.com](ca._netblocks.mimecast.com)]
    - [x] MimeCast ZA [[za.\_netblocks.mimecast.com](za._netblocks.mimecast.com)]
    - [x] MimeCast AU [[au.\_netblocks.mimecast.com](au._netblocks.mimecast.com)]
  - [x] MessageLabs [[spf.messagelabs.com](spf.messagelabs.com)]
- **Non-Mail Service Providers**<br>(Vastly Automated and uses Email as a Primary Method to Communicate)
  - [x] JIRA [[\_spf.atlassian.net](_spf.atlassian.net)]
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
   - Mail Transfer Agent (MTA)
   - Non-Mail Service Providers ("JIRA")
   - Bulk Mail Sender ("Sendgrid")
