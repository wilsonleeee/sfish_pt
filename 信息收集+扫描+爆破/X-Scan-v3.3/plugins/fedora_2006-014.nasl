#
# (C) Tenable Network Security
#
# This plugin text is was extracted from the Fedora Security Advisory
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(20404);
 script_version ("$Revision: 1.4 $");
 script_cve_id("CVE-2005-3656");
 
 name["english"] = "Fedora Core 3 2006-014: mod_auth_pgsql";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory FEDORA-2006-014 (mod_auth_pgsql).

mod_auth_pgsql can be used to limit access to documents served by a web server
by checking fields in a table in a PostgresQL database.

Update Information:

Several format string flaws were found in the way
mod_auth_pgsql logs information. It may be possible for a
remote attacker to execute arbitrary code as the 'apache'
user if mod_auth_pgsql is used for user authentication. The
Common Vulnerabilities and Exposures project assigned the
name CVE-2005-3656 to this issue.

Please note that this issue only affects servers which have
mod_auth_pgsql installed and configured to perform user
authentication against a PostgreSQL database.

Red Hat would like to thank iDefense for reporting this issue." );
 script_set_attribute(attribute:"solution", value:
"Get the newest Fedora Updates" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the mod_auth_pgsql package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2006 Tenable Network Security");
 family["english"] = "Fedora Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"mod_auth_pgsql-2.0.1-6.2", release:"FC3") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_exists(rpm:"mod_auth_pgsql-", release:"FC3") )
{
 set_kb_item(name:"CVE-2005-3656", value:TRUE);
}
