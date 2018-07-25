{$subject="Новый комментарий {if $comment->type == 'product'}к товару{elseif $comment->type == 'blog'}к записи{/if}{if !$comment->approved} ожидает одобрения{/if}" scope=root}
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

<head>
    <title>
        Новый комментарий {if $comment->type == 'product'}к товару{elseif $comment->type == 'blog'}к записи{/if}{if !$comment->approved} ожидает одобрения{/if}
    </title>
    <!--[if !mso]><!-- -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!--<![endif]-->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
        #outlook a {
            padding: 0;
        }

        .ReadMsgBody {
            width: 100%;
        }

        .ExternalClass {
            width: 100%;
        }

        .ExternalClass * {
            line-height: 100%;
        }

        body {
            margin: 0;
            padding: 0;
            -webkit-text-size-adjust: 100%;
            -ms-text-size-adjust: 100%;
        }

        table,
        td {
            border-collapse: collapse;
            mso-table-lspace: 0pt;
            mso-table-rspace: 0pt;
        }

        img {
            border: 0;
            height: auto;
            line-height: 100%;
            outline: none;
            text-decoration: none;
            -ms-interpolation-mode: bicubic;
        }

        p {
            display: block;
            margin: 13px 0;
        }
    </style>
    <!--[if !mso]><!-->
    <style type="text/css">
        @media only screen and (max-width:480px) {
            @-ms-viewport {
                width: 320px;
            }
            @viewport {
                width: 320px;
            }
        }
    </style>
    <!--<![endif]-->
    <!--[if mso]>
	<xml>
	<o:OfficeDocumentSettings>
	  <o:AllowPNG/>
	  <o:PixelsPerInch>96</o:PixelsPerInch>
	</o:OfficeDocumentSettings>
	</xml>
	<![endif]-->
    <!--[if lte mso 11]>
	<style type="text/css">
	  .outlook-group-fix { width:100% !important; }
	</style>
	<![endif]-->

    <!--[if !mso]><!-->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&amp;subset=cyrillic" rel="stylesheet" type="text/css">
    <style type="text/css">
        @import url(https://fonts.googleapis.com/css?family=Roboto:400,700&amp;subset=cyrillic);
    </style>
    <!--<![endif]-->

    <style type="text/css">
        @media only screen and (min-width:580px) {
            .mj-column-per-100 {
                width: 100% !important;
            }
            .mj-column-px-120 {
                width: 125px !important;
			}
			.mj-column-px-120 div {
				text-align: right !important
            }
            .mj-column-px-478 {
                width: 472px !important;
				border-left:1px solid #e8e8e8;
            }
        }
    </style>
</head>

<body style="background-color:#f0f3f6;">
    <div style="display:none;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;">
		{$comment->text|escape|nl2br}
    </div>

    <div style="background-color:#f0f3f6;">
		<!--[if mso | IE]>
		<table align="center" border="0" cellpadding="0" cellspacing="0" style="width:600px;" width="600">
		<tr>
		<td style="line-height:0px;font-size:0px;mso-line-height-rule:exactly;">
		<![endif]-->

        <div style="Margin:0px auto;max-width:600px;">
            <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;">
                <tbody>
                    <tr>
                        <td style="direction:ltr;font-size:0px;padding:20px 0;text-align:center;vertical-align:top;">
							<!--[if mso | IE]>
							<table role="presentation" border="0" cellpadding="0" cellspacing="0">
							<tr>
							<td style="vertical-align:top;width:600px;">
							<![endif]-->
							
                            <div class="mj-column-per-100 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                    <tr>
                                        <td align="center" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:16px;line-height:1;text-align:center;color:#4a4a4a;">
                                                Новый комментарий {if $comment->type == 'product'}к товару{elseif $comment->type == 'blog'}к записи{/if}
                                            </div>
                                        </td>
                                    </tr>
									<tr>
                                        <td align="center" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:16px;line-height:1;text-align:center;color:#4a4a4a;">
												{if $comment->type == 'product'}
                                                &laquo;<a href="{$config->root_url}/products/{$comment->product->url}#comment_{$comment->id}" target="_blank">{$comment->product->name}</a>&raquo;
												{elseif $comment->type == 'blog'}
                                                &laquo;<a href="{$config->root_url}/blog/{$comment->post->url}#comment_{$comment->id}" target="_blank">{$comment->post->name}</a>&raquo;
												{/if}
                                            </div>
                                        </td>
                                    </tr>
									{if !$comment->approved}
                                    <tr>
                                        <td align="center" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:center;color:#4a4a4a;">
                                                ожидает одобрения
                                            </div>
                                        </td>
                                    </tr>
									{/if}
                                </table>
                            </div>
							
							<!--[if mso | IE]>
							</td>
							</tr>
							</table>
							<![endif]-->
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

		<!--[if mso | IE]>
		</td>
		</tr>
		</table>
		<table align="center" border="0" cellpadding="0" cellspacing="0" style="width:600px;" width="600">
		<tr>
		<td style="line-height:0px;font-size:0px;mso-line-height-rule:exactly;">
		<![endif]-->

        <div style="background:#fff;background-color:#fff;Margin:0px auto;max-width:600px;">
            <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background:#fff;background-color:#fff;width:100%;">
                <tbody>
                    <tr>
                        <td style="border:1px solid #e8e8e8;direction:ltr;font-size:0px;padding:20px 0;text-align:center;vertical-align:top;">
							<!--[if mso | IE]>
							<table role="presentation" border="0" cellpadding="0" cellspacing="0">
							<tr>
							<td width="600px">
							<table align="center" border="0" cellpadding="0" cellspacing="0" style="width:600px;" width="600">
							<tr>
							<td style="line-height:0px;font-size:0px;mso-line-height-rule:exactly;">
							<![endif]-->

                            <div style="Margin:0px auto;max-width:600px;">
                                <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;">
                                    <tbody>
                                        <tr>
                                            <td style="direction:ltr;font-size:0px;padding:0;text-align:center;vertical-align:top;">
												<!--[if mso | IE]>
												<table role="presentation" border="0" cellpadding="0" cellspacing="0">
												<tr>
												<td style="vertical-align:top;width:120px;">
												<![endif]-->

                                                <div class="mj-column-px-120 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Имя
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

												<!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:478px;">
												<![endif]-->

                                                <div class="mj-column-px-478 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    {$comment->name|escape}
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

												<!--[if mso | IE]>
												</td>
												</tr>
												</table>
												<![endif]-->
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

							<!--[if mso | IE]>
							</td>
							</tr>
							</table>
							</td>
							</tr>
							<tr>
							<td width="600px">
							<table align="center" border="0" cellpadding="0" cellspacing="0" style="width:600px;" width="600">
							<tr>
							<td style="line-height:0px;font-size:0px;mso-line-height-rule:exactly;">
							<![endif]-->

                            <div style="Margin:0px auto;max-width:600px;">
                                <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;">
                                    <tbody>
                                        <tr>
                                            <td style="direction:ltr;font-size:0px;padding:0;text-align:center;vertical-align:top;">
												<!--[if mso | IE]>
												<table role="presentation" border="0" cellpadding="0" cellspacing="0">
												<tr>
												<td style="vertical-align:top;width:120px;">
												<![endif]-->

                                                <div class="mj-column-px-120 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Сообщение
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

												<!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:478px;">
												<![endif]-->

                                                <div class="mj-column-px-478 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    {$comment->text|escape|nl2br}
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

												<!--[if mso | IE]>
												</td>
												</tr>
												</table>
												<![endif]-->
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

							<!--[if mso | IE]>
							</td>
							</tr>
							</table>
							</td>
							</tr>
							</table>
							<![endif]-->
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

		<!--[if mso | IE]>
		</td>
		</tr>
		</table>
		<table align="center" border="0" cellpadding="0" cellspacing="0" style="width:600px;" width="600">
		<tr>
		<td style="line-height:0px;font-size:0px;mso-line-height-rule:exactly;">
		<![endif]-->

        <div style="Margin:0px auto;max-width:600px;">
            <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="width:100%;">
                <tbody>
                    <tr>
                        <td style="direction:ltr;font-size:0px;padding:20px 0;text-align:center;vertical-align:top;">
							<!--[if mso | IE]>
							<table role="presentation" border="0" cellpadding="0" cellspacing="0">
							<tr>
							<td style="vertical-align:top;width:600px;">
							<![endif]-->

                            <div class="mj-column-per-100 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                    <tr>
                                        <td align="center" vertical-align="middle" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse:separate;line-height:100%;">
                                                <tr>
                                                    <td align="center" bgcolor="#2196F3" role="presentation" style="border:none;border-radius:3px;color:#ffffff;cursor:auto;padding:10px 25px;" valign="middle">
                                                        <a href="{$config->root_url}/simpla/index.php?module=CommentsAdmin" style="background:#2196F3;color:#ffffff;font-family:Roboto, Helvetica, Arial, sans-serif;font-size:13px;font-weight:normal;line-height:120%;Margin:0;text-decoration:none;text-transform:none;" target="_blank">
															Перейти в панель управления
														</a>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>

							<!--[if mso | IE]>
							</td>
							</tr>
							</table>
							<![endif]-->
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
		
		<!--[if mso | IE]>
		</td>
		</tr>
		</table>
		<![endif]-->
    </div>
</body>
</html>