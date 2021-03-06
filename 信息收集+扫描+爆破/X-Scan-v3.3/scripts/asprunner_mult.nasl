#
# (C) Tenable Network Security
#

if (description) {
  script_id(14233);
  script_version ("$Revision: 1.8 $");

  script_cve_id(
    "CAN-2004-2057",
    "CAN-2004-2058", 
    "CAN-2004-2059",
    "CAN-2004-2060"
  );
  script_bugtraq_id(10799);
  if (defined_func("script_xref")) {
    script_xref(name:"OSVDB", value:"8251");
  }

  name["english"] = "ASPrunner multiple flaws";
  script_name(english:name["english"]);
 
  desc["english"] = "
The remote host is running ASPrunner prior to version 2.5.  
There are multiple flaws in this version of ASPrunner which
would enable a remote attacker to read and/or modify potentially
confidential data.

An attacker, exploiting this flaw, would need access to the
webserver via the network.

Solution : Upgrade to latest version of ASPrunner.
Risk factor : High";
  script_description(english:desc["english"]);
 
  summary["english"] = "Check for multiple flaws in ASPrunner";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) Tenable Network Security");
  family["english"] = "CGI abuses : XSS";
  script_family(english:family["english"]);

  script_require_ports("Services/www", 80);
  script_dependencies("no404.nasl", "cross_site_scripting.nasl");
  exit(0);
}

include("http_func.inc");
include("global_settings.inc");

port = get_http_port(default:80);

if (!get_port_state(port)) exit(0);
if (get_kb_item(strcat("www/", port, "/generic_xss"))) exit(0);

soc = http_open_socket(port);
if (! soc)
	exit(0);

# there are multiple flaws.  We'll check for XSS flaw which will be an indicator
# of other flaws
# 
# exploit string from http://www.securityfocus.com/bid/10799/exploit/
init = string("/export.asp?SQL=%22%3E%3Cscript%3Ealert%28document.cookie%29%3C%2Fscript%3Eselect+%5Bword_id%5D%2C+%5Bword_id%5D%2C+++%5Btr%5D%2C+++%5Ben%5D%2C+++%5Bdesc%5D++From+%5Bdictionary%5D++order+by+%5Ben%5D+desc&mypage=1&pagesize=20"); 

req = http_get(item:init, port:port);

#display(req);

send(socket:soc, data:req);
r = http_recv(socket:soc);

http_close_socket(soc);

if (debug_level > 0) display("---- asprunner_mult ----\n", req, "\n------------\n");

if ("<script>alert" >< r)
{
 if (! http_40x(port: port, code: r))
   security_warning(port: port, data: "
This web server is vulnerable to the same kind of 
Cross Site Scripting as ASPRunner 2.5

*** If this is ASPRunner, there are more dangerous flaws 
*** that would enable a remote attacker to read and/or 
*** modify potentially confidential data.

You should upgrade your web server or application.

Risk: Medium");
 else
	security_hole(port);
}



