#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(10591);
 script_version ("$Revision: 1.20 $");
 script_cve_id("CVE-2000-0940");
 script_bugtraq_id(1864);
 script_xref(name:"OSVDB", value:"488");

 script_name(english:"Metertek pagelog.cgi Traversal Arbitrary File Access");
 
 script_set_attribute(attribute:"synopsis", value:
"It may be possible to create arbitrary files on the remote 
system." );
 script_set_attribute(attribute:"description", value:
"The 'pagelog.cgi' cgi is installed. This CGI has a well known 
security flaw that lets an attacker create arbitrary files on 
the remote server, ending in .txt, and reading arbitrary files 
ending in .txt or .log

*** Warning : this flaw was not tested by Nessus. Check the existence
of /tmp/nessus_pagelog_cgi.txt on this host to find out if you
are vulnerable or not." );
 script_set_attribute(attribute:"solution", value:
"Remove it from /cgi-bin." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:N" );
 script_end_attributes();

 script_summary(english:"Checks for the presence of /cgi-bin/pagelog.cgi");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("http_version.nasl", "find_service1.nasl", "no404.nasl");
 script_require_ports("Services/www", 80);
 script_require_keys("Settings/ParanoidReport");
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

if ( report_paranoia < 2 ) exit(0);

port = get_http_port(default:80);

flag = 0;

foreach dir (cgi_dirs())
{
 if(is_cgi_installed3(item:string(dir, "/pagelog.cgi"), port:port))
 {
  flag = 1;
  directory = dir;
  break;
 }
}

if(flag)
{
  # We create a file but cannot check its existence
  r = http_send_recv3(method:"GET", port:port,
    item:string(directory,
  "/pagelog.cgi?name=../../../../../../tmp/nessus_pagelog_cgi") );
  security_warning(port);
}
