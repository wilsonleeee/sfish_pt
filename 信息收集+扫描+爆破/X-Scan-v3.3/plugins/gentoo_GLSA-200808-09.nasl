# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200808-09.xml
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
 script_id(33855);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200808-09");
 script_cve_id("CVE-2008-2952");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200808-09 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200808-09
(OpenLDAP: Denial of Service vulnerability)


    Cameron Hotchkies discovered an error within the parsing of ASN.1 BER
    encoded packets in the "ber_get_next()" function in
    libraries/liblber/io.c.
  
Impact

    A remote unauthenticated attacker can send a specially crafted ASN.1
    BER encoded packet which will trigger the error and cause an
    "assert()", terminating the "slapd" daemon.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All OpenLDAP users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-nds/openldap-2.3.43"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-2952');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200808-09.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200808-09] OpenLDAP: Denial of Service vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'OpenLDAP: Denial of Service vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-nds/openldap", unaffected: make_list("ge 2.3.43"), vulnerable: make_list("lt 2.3.43")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
