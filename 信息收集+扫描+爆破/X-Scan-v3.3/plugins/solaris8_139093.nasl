#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(34068);
 script_version("$Revision: 1.2 $");

 script_name(english: "Solaris 5.8 (sparc) : 139093-01");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 139093-01");
 script_set_attribute(attribute: "description", value:
'GNOME 2.0.0: SUNWTiff libtiff library patch.
Date this patch was last updated by Sun : Aug/29/08');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-139093-01-1");
 script_set_attribute(attribute: "risk_factor", value: "Medium");
 script_end_attributes();

 script_summary(english: "Check for patch 139093-01");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"139093-01", obsoleted_by:"", package:"SUNWTiff", version:"6.4.1.40,REV=0.2002.12.09");
e +=  solaris_check_patch(release:"5.8", arch:"sparc", patch:"139093-01", obsoleted_by:"", package:"SUNWTiffx", version:"1.0.0,REV=2003.01.14.12.39");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_warning(0);
	else  
	   security_warning(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
