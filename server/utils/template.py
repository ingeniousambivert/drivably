def email_template(message: str):
    template: str = """
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-GB">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Drivably</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <style type="text/css">
    a[x-apple-data-detectors] {color: inherit !important;}
  </style>

</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; ">
  <table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td style="padding: 20px 0 30px 0;">

<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse: collapse; border: 1px solid #cccccc;">
  <tr>
    <td align="center" bgcolor="#222" style="padding: 40px 0 30px 0; font-size:1.75rem; font-weight:bold; color:#eee">
    Drivably - Your Car Safety Assistant
    </td>
  </tr>
  <tr>
    <td bgcolor="#ffffff" style="padding: 40px 30px 40px 30px;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">
        <tr>
          <td style="color: #153643">
            <h1 style="font-size: 28px; margin: 0;">Drivably Notifier</h1>
          </td>
        </tr>
        <tr>
          <td style="color: #153643; font-size: 16px; line-height: 24px; padding: 20px 0 30px 0;">
            <p style="margin: 0;">""" + message + """</p>
          </td>
        </tr>
        <tr>
    <td bgcolor="#808ef6" style="padding: 15px 15px; text-align: center">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse;">
        <tr>
          <td style="color: #ffffff; font-size: 14px;">
            <p style="margin: 0;">&copy; Drivably - Car Safety Assistant<br/>
          </td>
        </tr>
      </table>
    </td>
  </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

      </td>
    </tr>
  </table>
</body>
</html>
"""

    return template
