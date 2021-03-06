
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(19331);
 script_version ("$Revision: 1.6 $");
 script_name(english: "RHSA-2005-603: dhcpcd");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2005-603");
 script_set_attribute(attribute: "description", value: '
  An updated dhcpcd package that fixes a denial of service issue is
  now available.

  This update has been rated as having moderate security impact by the Red
  Hat Security Response Team.

  The dhcpcd package includes a DHCP client daemon.

  An out of bounds memory read bug was found in dhcpcd. A malicious user on
  the local network could send a specially crafted DHCP packet to the client
  causing it to crash. The Common Vulnerabilities and Exposures project
  assigned the name CAN-2005-1848 to this issue.

  Users of dhcpcd should update to this erratum package, which contains a
  patch that resolves this issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2005-603.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2005-1848");
script_summary(english: "Check for the version of the dhcpcd packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"dhcpcd-1.3.20pl0-2", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
