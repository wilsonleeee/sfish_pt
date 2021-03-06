
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-10639
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(42271);
 script_version("$Revision: 1.1 $");
script_name(english: "Fedora 11 2009-10639: kernel");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-10639 (kernel)");
 script_set_attribute(attribute: "description", value: "The kernel package contains the Linux kernel (vmlinuz), the core of any
Linux operating system.  The kernel handles the basic functions
of the operating system: memory allocation, process allocation, device
input and output, etc.

-
Update Information:

Update to kernel 2.6.30.9. Upstream change logs:
[9]http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.30.9    Also fixes
:
- Kernel stack randomization bug   - NULL dereference in r128 driver   - ftrace
memory corruption on module unload   - boot hanging on some systems   - some
latency problems caused by scheduler bugs
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2009-2847", "CVE-2009-2903", "CVE-2009-2908", "CVE-2009-2909", "CVE-2009-2910", "CVE-2009-3290", "CVE-2009-3612");
script_summary(english: "Check for the version of the kernel package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"kernel-2.6.30.9-90.fc11", prefix:"kernel-", release:"FC11") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
