#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(15773);
 script_version ("$Revision: 1.7 $");
 script_name(english:"CCProxy Application Proxy Detection");
 script_summary(english:"Detects CCProxy");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote host is acting as an open proxy."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The remote host is running CCProxy, an application proxy supporting\n",
     "many protocols (Telnet, FTP, WWW, and more...).\n\n",
     "An open proxy may allow users to impersonate the remote host when\n",
     "connecting to the outside. It might also allow a spammer to use the\n",
     "remote host as a relay.\n\n",
     "Make sure the use of this program matches your corporate policy."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://www.youngzsoft.net/ccproxy/"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Disable this software if it violates your corporate policy."
 );
 script_set_attribute(
   attribute:"risk_factor", 
   value:"None"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Firewalls");
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_dependencie("find_service2.nasl");
 if ( NASL_LEVEL >= 3000 ) script_require_ports("Services/ccproxy-telnet", "Services/ccproxy-ftp", "Services/ccproxy-smtp");
 exit(0);
}

#
# The script code starts here
#

port = get_kb_item("Services/ccproxy-telnet");
if ( port )
{
 soc = open_sock_tcp(port);
 if ( soc )
 {
  r = recv_line(socket:soc, length:4096);
  if ( "CCProxy" >< r ) {
	security_note ( port );
	exit(0);
	}
  close(soc);
 }
}
port = get_kb_item("Services/ccproxy-ftp");
if ( port )
{
 soc = open_sock_tcp(port);
 if ( soc )
 {
  r = recv_line(socket:soc, length:4096);
  if ( "CCProxy" >< r ) {
	security_note ( port );
	exit(0);
	}
  close(soc);
 }
}
port = get_kb_item("Services/ccproxy-smtp");
if ( port )
{
 soc = open_sock_tcp(port);
 if ( soc )
 {
  r = recv_line(socket:soc, length:4096);
  if ( "CCProxy" >< r ) {
	security_note ( port );
	exit(0);
	}
  close(soc);
 }
}
