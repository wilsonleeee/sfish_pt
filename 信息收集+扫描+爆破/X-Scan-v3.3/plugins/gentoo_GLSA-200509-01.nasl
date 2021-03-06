# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200509-01.xml
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
 script_id(19576);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200509-01");
 script_cve_id("CVE-2005-2718");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200509-01 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200509-01
(MPlayer: Heap overflow in ad_pcm.c)


    Sven Tantau discovered a heap overflow in the code handling the
    strf chunk of PCM audio streams.
  
Impact

    An attacker could craft a malicious video or audio file which,
    when opened using MPlayer, would end up executing arbitrary code on the
    victim\'s computer with the permissions of the user running MPlayer.
  
Workaround

    You can mitigate the issue by adding "ac=-pcm," to your MPlayer
    configuration file (note that this will prevent you from playing
    uncompressed audio).
  
');
script_set_attribute(attribute:'solution', value: '
    All MPlayer users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-video/mplayer-1.0_pre7-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-2718');
script_set_attribute(attribute: 'see_also', value: 'http://www.sven-tantau.de/public_files/mplayer/mplayer_20050824.txt');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200509-01.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200509-01] MPlayer: Heap overflow in ad_pcm.c');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'MPlayer: Heap overflow in ad_pcm.c');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-video/mplayer", unaffected: make_list("ge 1.0_pre7-r1"), vulnerable: make_list("lt 1.0_pre7-r1")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
