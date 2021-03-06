#
# (C) Tenable Network Security
#
#

if ( ! defined_func("bn_random") ) exit(0);
include("compat.inc");

if(description)
{
 script_id(30165);
 script_version("$Revision: 1.9 $");

 script_name(english: "Solaris 10 (sparc) : 120414-24");
 script_set_attribute(attribute: "synopsis", value:
"The remote host is missing Sun Security Patch number 120414-24");
 script_set_attribute(attribute: "description", value:
'SunOS 5.10: Asian CCK locales patch.
Date this patch was last updated by Sun : Jul/22/09');
 script_set_attribute(attribute: "solution", value:
"You should install this patch for your system to be up-to-date.");
 script_set_attribute(attribute: "see_also", value:
"http://sunsolve.sun.com/search/document.do?assetkey=1-21-120414-24-1");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Check for patch 120414-24");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 family["english"] = "Solaris Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Solaris/showrev");
 exit(0);
}



include("solaris.inc");

e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWcxplt", version:"10.0,REV=2004.11.09.12.03");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWhkleu", version:"10.0,REV=2004.11.09.12.00");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWhkplt", version:"10.0,REV=2004.11.09.12.00");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWhleu2", version:"10.0,REV=2004.11.09.12.00");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWhleu", version:"10.0,REV=2004.11.09.12.00");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWhxplt", version:"10.0,REV=2004.11.09.12.00");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWinleu", version:"10.0,REV=2004.11.09.12.06");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWinplt", version:"10.0,REV=2004.05.26.11.11");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWkleu", version:"10.0,REV=2004.11.27.13.32");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWkxplt", version:"10.0,REV=2004.11.09.12.00");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWsunpinyin", version:"1.0.127,REV=10.0.3.2004.12.15.22.57");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWtleu", version:"10.0,REV=2004.11.09.12.05");
e +=  solaris_check_patch(release:"5.10", arch:"sparc", patch:"120414-24", obsoleted_by:"", package:"SUNWtxplt", version:"10.0,REV=2004.11.27.13.53");
if ( e < 0 ) { 
	if ( NASL_LEVEL < 3000 ) 
	   security_hole(0);
	else  
	   security_hole(port:0, extra:solaris_get_report());
	exit(0); 
} 
exit(0, "Host is not affected");
