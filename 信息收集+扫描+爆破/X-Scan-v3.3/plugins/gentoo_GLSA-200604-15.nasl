# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200604-15.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(21297);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200604-15");
 script_cve_id("CVE-2006-1905");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200604-15 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200604-15
(xine-ui: Format string vulnerabilities)


    Ludwig Nussel discovered that xine-ui incorrectly implements
    formatted printing.
  
Impact

    By constructing a malicious playlist file, a remote attacker could
    exploit these vulnerabilities to execute arbitrary code with the rights
    of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All xine-ui users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-video/xine-ui-0.99.4-r5"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-1905');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200604-15.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200604-15] xine-ui: Format string vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'xine-ui: Format string vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-video/xine-ui", unaffected: make_list("ge 0.99.4-r5"), vulnerable: make_list("lt 0.99.4-r5")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
