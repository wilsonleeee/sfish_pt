
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-9411
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(34746);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 8 2008-9411: blender");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-9411 (blender)");
 script_set_attribute(attribute: "description", value: "Blender is the essential software solution you need for 3D, from modeling,
animation, rendering and post-production to interactive creation and playback.

Professionals and novices can easily and inexpensively publish stand-alone,
secure, multi-platform content to the web, CD-ROMs, and other media.

This version doesn't contains ffmpeg support, so that any features may be not
available.

-
Update Information:

Fix CVE-2008-4863
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2008-1003", "CVE-2008-4863");
script_summary(english: "Check for the version of the blender package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"blender-2.48a-4.fc8", release:"FC8") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
