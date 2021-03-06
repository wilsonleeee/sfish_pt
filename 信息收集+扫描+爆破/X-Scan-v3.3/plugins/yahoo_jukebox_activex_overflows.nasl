#
#  (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(30205);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2008-0623", "CVE-2008-0624", "CVE-2008-0625");
  script_bugtraq_id(27578, 27579, 27590);
  script_xref(name:"OSVDB", value:"41051");

  script_name(english:"Yahoo! Music Jukebox ActiveX Controls Buffer Overflow Vulnerabilities");
  script_summary(english:"Checks version of affected ActiveX controls"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has a least one ActiveX control that is
affected by buffer overflow vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host contains the 'DataGrid' and/or 'MediaGrid' ActiveX
controls included with Yahoo! Music Jukebox. 

These controls are reportedly affected by multiple buffer overflows
involving, for example, the 'AddButton' and 'AddImage' methods of the
'DataGrid' control and 'AddBitmap' method of the 'MediaGrid' control. 
If an attacker can trick a user on the affected host into visiting a
specially-crafted web page, he may be able to leverage these issues to
execute arbitrary code on the host subject to the user's privileges." );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/5043" );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/5046" );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/5048" );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/5051" );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/5052" );
 script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/101676" );
 script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/340860" );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?71b832d7" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 2.2.2.058 of the control as described in the vendor
advisory." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}


include("global_settings.inc");
include("smb_func.inc");
include("smb_activex_func.inc");


if (!get_kb_item("SMB/Registry/Enumerated")) exit(0);


# Locate files used by the controls.
if (activex_init() != ACX_OK) exit(0);

info = "";
clsids = make_list(
  "{22FD7C0A-850C-4A53-9821-0B0915C96139}",
  "{5F810AFC-BB5F-4416-BE63-E01DD117BD6C}"
);
foreach clsid (clsids)
{
  file = activex_get_filename(clsid:clsid);
  if (file)
  {
    ver = activex_get_fileversion(clsid:clsid);
    if (ver && activex_check_fileversion(clsid:clsid, fix:"2.2.2.058") == TRUE)
    {
      info += '  ' + file + ' (' + ver + ')\n';
      if (!thorough_tests) break;
    }
  }
}
activex_end();


if (info)
{
  if (report_verbosity)
  {
   report = string(
     "\n",
     "Nessus found the following affected control(s) installed :\n",
     "\n",
     info
   );
   security_hole(port:kb_smb_transport(), extra:report);
  }
  else security_hole(kb_smb_transport());
}
