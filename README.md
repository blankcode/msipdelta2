# Mail Services IP Delta<br>Change Log and Import Lists

IP Delta checks, resolves and parses the output for SPF DNS record. It then is committed to github.

## Lists are in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format

- 10.0.0.0/8 (10.0.0.0 ... 10.255.255.255)

## Currently Monitored Networks

- **Primary Business Mail Providers (Mailbox Providers)**
  - Google Email Services (GApps) [[\_spf.google.com](_spf.google.com)]

## Sevices to come

- **Primary Business Mail Providers**<br>(Mailbox Providers)
  - Microsoft Office 365 and Azure [[spf.protection.outlook.com](spf.protection.outlook.com)]
  - ProtonMail [[\_spf.protonmail.ch](_spf.protonmail.ch)]
- **Secondary Business Mail Providers**<br>(Filtering and Security)
  - MimeCast [[spf.messagelabs.com](spf.messagelabs.com)]
  - Symantec [[symantec.net](symantec.net)]
- **Non-Mail Service Providers**<br>(Vastly automated and uses Email as a primary method to communicate)
  - Salesforce [[\_spf.salesforce.com](_spf.salesforce.com)]
  - JIRA [[\_spf.atlassian.net](_spf.atlassian.net), [mail-us.atlassian.net](mail-us.atlassian.net), [mail-eu.atlassian.net](mail-eu.atlassian.net)]
- **Bluk Mail Services**<br>(Rarely Legitimate Mail)
  - SendGrid [[sendgrid.net](sendgrid.net)]
  - MailChimp [[servers.mcsv.net](servers.mcsv.net)]
  - MarkeTo [[mktomail.com](mktomail.com)]

Contact me on GitHub about doing this for other services, it's not hard to set up at all.
