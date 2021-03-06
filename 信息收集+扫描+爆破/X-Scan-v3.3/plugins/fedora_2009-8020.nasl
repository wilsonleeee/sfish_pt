
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-8020
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(40411);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 10 2009-8020: kdelibs3");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-8020 (kdelibs3)");
 script_set_attribute(attribute: "description", value: "Libraries for the K Desktop Environment 3:
KDE Libraries included: kdecore (KDE core library), kdeui (user interface),
kfm (file manager), khtmlw (HTML widget), kio (Input/Output, networking),
kspell (spelling checker), jscript (javascript), kab (addressbook),
kimgio (image manipulation).

-
Update Information:

This update fixes several security issues in the KDE 3 compatibility version of
KHTML (CVE-2009-1725, CVE-2009-1690, CVE-2009-1687, CVE-2009-1698,
CVE-2009-2537) which may lead to a denial of service or potentially even
arbitrary code execution.    In addition, the package was fixed to build with
the latest version of automake, and the following fixes and improvements were
merged from the Fedora 11 package:  * slight speedup to /etc/profile.d/kde.sh,

Update information :

* fixed unowned directories,  * fixed harmless (as the file contents match) fil
e
conflicts with KDE 4.2.x,  * fixed build with GCC 4.4 (but this package is buil
t
with Fedora 10's GCC 4.3.2),  * moved Qt Designer plugins to the runtime packag
e
as they can be needed at runtime (e.g. by PyKDE programs),  * kdelibs3-apidocs
is now a noarch subpackage.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2009-1687", "CVE-2009-1690", "CVE-2009-1698", "CVE-2009-1725", "CVE-2009-2537");
script_summary(english: "Check for the version of the kdelibs3 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"kdelibs3-3.5.10-13.fc10", release:"FC10") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
