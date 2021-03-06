#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(39532);
 script_version("$Revision: 1.3 $");

 script_name(english: "Solaris 10 (sparc) : 141778-02");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 141778-02");
 script_set_attribute(attribute: "description", value:
'SunOS 5.10: vntsd patch.
Date this patch was last updated by Sun : Jun/25/09');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-141778-02-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 141778-02");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.10", arch:"sparc.sun4v", patch:"141778-02", obsoleted_by:"141514-02 ", package:"SUNWcakr", version:"11.10.0,REV=2005.08.25.02.12");
e +=  solaris_check_patch(release:"5.10", arch:"sparc.sun4v", patch:"141778-02", obsoleted_by:"141514-02 ", package:"SUNWkvm", version:"11.10.0,REV=2005.08.04.12.25");
e +=  solaris_check_patch(release:"5.10", arch:"sparc.sun4v", patch:"141778-02", obsoleted_by:"141514-02 ", package:"SUNWldomr", version:"11.10.0,REV=2006.10.04.00.26");
e +=  solaris_check_patch(release:"5.10", arch:"sparc.sun4v", patch:"141778-02", obsoleted_by:"141514-02 ", package:"SUNWldomu", version:"11.10.0,REV=2006.08.08.12.13");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
