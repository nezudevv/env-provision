DNS Zone
  - a database e.g. *.netflix.com containing records
ZoneFile
  - the 'file' storing the zone on disk
Name Server (NS)
  - a DNS server which hosts 1 or more Zones and stores 1 or more ZoneFiles
Authoritative
  - contains real/genuine records (boss)
Non-Authoritative/Cached
  - copies of records/zones stored elsewhere to speed things up

Architecture
  - DNS Root (the boss). This Zone is hosted on DNS Name Servers like any other part of DNS. So, the DNS Root Zone runs on the DNS Root Servers. The only thing special element of the root zone is that it is the point every DNS client knows about and trusts. It's where queries start.
    - There are 13 Root server IP addresses which host the root zone. distrubeted geographically and the hardware is managed by independent organizations(nasa, university of maryland
    - IANA is responsible for managing the Root Zone, which is different than the orgs that manage the root servers that host the root zone.
    - Doesn't store that much data but the data it does store is critical to how DNS functions (high level info on the TLDs, top level domains). There are 2 types of TLDs: generic tlds(.com, etc), and country code specific ones like .uk or .au. IANA delegates the management of these TLDs to other organizations known as registries. The job of the root zone really is to just point at these TLD Registries
    -   - example:  IANA delegates management of the .com TLD to verasine, meaning verasine is the .com registry and so in the root zone is an entry for .com pointing at the name servers which belong to verasine.
        - because the root zone points at these TLD zones, they're known as authoratative(source of truth for those TLDs).
        - Summary: Root Zones is pointing at Named Servers hosting the TLD Zones run by the Registries which are the organizations that manage these TLDs
     
The job of DNS is to help you lcoate and get a query response from the authoritative zone which hosts the DNS record(s) you need.



