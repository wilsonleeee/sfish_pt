# This script was automatically generated from the dsa-829
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(19798);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "829");
 script_cve_id("CVE-2005-2558");
 script_bugtraq_id(14509);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-829 security update');
 script_set_attribute(attribute: 'description', value:
'A stack-based buffer overflow in the init_syms function of MySQL, a
popular database, has been discovered that allows remote authenticated
users who can create user-defined functions to execute arbitrary code
via a long function_name field.  The ability to create user-defined
functions is not typically granted to untrusted users.
The following vulnerability matrix shows which version of MySQL in
which distribution has this problem fixed:
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-829');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mysql packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA829] DSA-829-1 mysql");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-829-1 mysql");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'libmysqlclient10', release: '3.0', reference: '3.23.49-8.14');
deb_check(prefix: 'libmysqlclient10-dev', release: '3.0', reference: '3.23.49-8.14');
deb_check(prefix: 'mysql-client', release: '3.0', reference: '3.23.49-8.14');
deb_check(prefix: 'mysql-common', release: '3.0', reference: '3.23.49-8.14');
deb_check(prefix: 'mysql-doc', release: '3.0', reference: '3.23.49-8.5');
deb_check(prefix: 'mysql-server', release: '3.0', reference: '3.23.49-8.14');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
