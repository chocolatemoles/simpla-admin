<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

<head>
    <title>
        {if $order->paid}Заказ №{$order->id} оплачен{else}Новый заказ №{$order->id}{/if}
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
        @media only screen and (min-width:600px) {
            .mj-column-per-100 {
                width: 100% !important;
            }
            .mj-column-px-350 {
                width: 350px !important;
            }
            .mj-column-px-10 {
                width: 10px !important;
            }
            .mj-column-px-240 {
                width: 240px !important;
            }
            .mj-column-px-150 {
                width: 150px !important;
            }
			.mj-column-px-150 div {
				text-align: right !important
            }
            .mj-column-px-448 {
                width: 447px !important;
				border-left:1px solid #e8e8e8;
            }
        }
    </style>
</head>

<body style="background-color:#f0f3f6;">
    <div style="display:none;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;max-width:0px;opacity:0;overflow:hidden;">
       {if $order->paid}Заказ №{$order->id} оплачен{else}Новый заказ №{$order->id}{/if}
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
                        <td style="direction:ltr;font-size:0px;padding:20px 0 0;text-align:center;vertical-align:top;">
							<!--[if mso | IE]>
							<table role="presentation" border="0" cellpadding="0" cellspacing="0">
							<tr>
							<td style="vertical-align:top;width:600px;">
							<![endif]-->

                            <div class="mj-column-per-100 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                    <tr>
                                        <td align="center" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:20px;line-height:1;text-align:center;color:#4a4a4a;">
                                                Заказ №{$order->id}
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="center" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:16px;line-height:1;text-align:center;color:#4a4a4a;">
                                                <span style="font-size: 14px">на сумму</span> 224 320 Руб
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="center" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:16px;line-height:1;text-align:center;color:#4a4a4a;">
                                                {if $order->paid == 1}<span style="color: green">оплачен</span>{else}еще не оплачен{/if}, {if $order->status == 0}ждет обработки{elseif $order->status == 1}в обработке{elseif $order->status == 2}выполнен{/if}
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
							<td style="vertical-align:top;width:350px;">
							<![endif]-->

                            <div class="mj-column-px-350 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                <table background="#fff" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#fff;border:1px solid #e8e8e8;vertical-align:top;" width="100%">
                                    <tr>
                                        <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                            <table border="0" style="border-collapse: collapse;cellspacing:0;color:#000;font-family:Roboto, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;table-layout:auto;width:100%;">
											{foreach $purchases as $purchase}
                                                <tr>
                                                    <td style="padding: 5px 0 0; width: 35px;  vertical-align: top">
														<a href="{$config->root_url}/products/{$purchase->product->url}">
															<img src="{$image->filename|resize:35:35}" style="border:0;display:block;outline:none;text-decoration:none;width:100%;" width="35" height="auto"/>
														</a>
													</td>
													
                                                    <td style="padding: 5px 10px 0; vertical-align: top"><a href="{$config->root_url}/products/{$purchase->product->url}">{$purchase->product_name}</a>{if $purchase->variant_name}<br>{$purchase->variant_name}{/if}</td>
                                                </tr>
												
                                                <tr>
                                                    <td style="{if !$purchase@last}border-bottom: 1px solid #e8e8e8;{/if} border-collapse: collapse;">&nbsp;</td>
                                                    <td style="padding: 0 0 5px 0; font-size: 16px; border-collapse: collapse; {if !$purchase@last}border-bottom: 1px solid #e8e8e8;{/if} text-align: right; white-space: nowrap; vertical-align: top">
														<span style=" color: #9d9d9d">{$purchase->price|convert:$main_currency->id}&nbsp;{$main_currency->sign}</span> &times; {$purchase->amount} {$settings->units}
													</td>
                                                </tr>
											{/foreach}
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!--[if mso | IE]>
							</td>
							<td style="vertical-align:top;width:10px;">
							<![endif]-->

                            <div class="mj-column-px-10 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                    <tr>
                                        <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                            <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                &nbsp;
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

							<!--[if mso | IE]>
							</td>
							<td style="vertical-align:top;width:240px;">
							<![endif]-->

                            <div class="mj-column-px-240 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                <table background="#fff" border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
                                    <tbody>
                                        <tr>
                                            <td style="background-color:#fff;border:1px solid #e8e8e8;vertical-align:top;padding:10px 0;">
                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation" width="100%">
													{if $order->discount > 0}
                                                    <tr>
                                                        <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:12px;line-height:1;text-align:left;color:#9E9E9E;">
                                                                Скидка
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td align="right" style="font-size:0px;padding:10px 25px;padding-top:5px;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:18px;line-height:1;text-align:right;color:#4a4a4a;">
                                                                {$order->discount}&nbsp;%
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td style="font-size:0px;padding:0px 25px 5px;word-break:break-word;">
                                                            <p style="border-top:dashed 1px lightgrey;font-size:1;margin:0px auto;width:100%;"></p>

															<!--[if mso | IE]>
															<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:dashed 1px lightgrey;font-size:1;margin:0px auto;width:190px;" role="presentation" width="190px">
															<tr>
															<td style="height:0;line-height:0;">
															&nbsp;
															</td>
															</tr>
															</table>
															<![endif]-->
                                                        </td>
                                                    </tr>
													{/if}

													{if $order->coupon_discount > 0}
                                                    <tr>
                                                        <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:12px;line-height:1;text-align:left;color:#9E9E9E;">
                                                                Купон {$order->coupon_code}
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td align="right" style="font-size:0px;padding:10px 25px;padding-top:5px;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:18px;line-height:1;text-align:right;color:#4a4a4a;">
                                                                &minus;{$order->coupon_discount}&nbsp;{$main_currency->sign}
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td style="font-size:0px;padding:0px 25px 5px;word-break:break-word;">
                                                            <p style="border-top:dashed 1px lightgrey;font-size:1;margin:0px auto;width:100%;"></p>

															<!--[if mso | IE]>
															<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:dashed 1px lightgrey;font-size:1;margin:0px auto;width:190px;" role="presentation" width="190px">
															<tr>
															<td style="height:0;line-height:0;">
															&nbsp;
															</td>
															</tr>
															</table>
															<![endif]-->
                                                        </td>
                                                    </tr>
													{/if}
													
													{if $delivery && !$order->separate_delivery}
                                                    <tr>
                                                        <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:12px;line-height:1;text-align:left;color:#9E9E9E;">
                                                               {$delivery->name}
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td align="right" style="font-size:0px;padding:10px 25px;padding-top:5px;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:18px;line-height:1;text-align:right;color:#4a4a4a;">
																{$order->delivery_price|convert:$main_currency->id}&nbsp;{$main_currency->sign}
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td style="font-size:0px;padding:0px 25px 5px;word-break:break-word;">
                                                            <p style="border-top:dashed 1px lightgrey;font-size:1;margin:0px auto;width:100%;"></p>

															<!--[if mso | IE]>
															<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:dashed 1px lightgrey;font-size:1;margin:0px auto;width:190px;" role="presentation" width="190px">
															<tr>
															<td style="height:0;line-height:0;">
															&nbsp;
															</td>
															</tr>
															</table>
															<![endif]-->
                                                        </td>
                                                    </tr>
													{/if}
													
                                                    <tr>
                                                        <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:12px;line-height:1;text-align:left;color:#9E9E9E;">
                                                                Итого
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td align="right" style="font-size:0px;padding:10px 25px;padding-top:5px;word-break:break-word;">
                                                            <div style="font-family:Roboto, Arial;font-size:18px;line-height:1;text-align:right;color:#4a4a4a;">
                                                                {$order->total_price|convert:$main_currency->id}&nbsp;{$main_currency->sign}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
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
												<td style="vertical-align:top;width:150px;">
												<![endif]-->

                                                <div class="mj-column-px-150 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Дата
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:448px;">
												<![endif]-->

                                                <div class="mj-column-px-448 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
																	{$order->date|date} {$order->date|time}
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
												<td style="vertical-align:top;width:150px;">
												<![endif]-->

                                                <div class="mj-column-px-150 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Имя, фамилия
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:448px;">
												<![endif]-->

                                                <div class="mj-column-px-448 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    {if $user}
																		<a href="{$config->root_url}/simpla/index.php?module=UserAdmin&id={$user->id}">{$order->name|escape}</a>
																	{elseif $order->name}
																		{$order->name|escape}
																	{/if}
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
												<td style="vertical-align:top;width:150px;">
												<![endif]-->

                                                <div class="mj-column-px-150 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Email
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:448px;">
												<![endif]-->

                                                <div class="mj-column-px-448 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    <a href="mailto:{$order->email|escape}">{$order->email|escape}</a>
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
												<td style="vertical-align:top;width:150px;">
												<![endif]-->

                                                <div class="mj-column-px-150 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Телефон
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:448px;">
												<![endif]-->

                                                <div class="mj-column-px-448 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    {$order->phone|escape}
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
												<td style="vertical-align:top;width:150px;">
												<![endif]-->

                                                <div class="mj-column-px-150 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Адрес доставки
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:448px;">
												<![endif]-->

                                                <div class="mj-column-px-448 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    {$order->address|escape}
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
												<td style="vertical-align:top;width:150px;">
												<![endif]-->

                                                <div class="mj-column-px-150 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;padding-bottom:0;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#9e9e9e;">
                                                                    Комментарий
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!--[if mso | IE]>
												</td>
												<td style="vertical-align:top;width:448px;">
												<![endif]-->

                                                <div class="mj-column-px-448 outlook-group-fix" style="font-size:13px;text-align:left;direction:ltr;display:inline-block;vertical-align:top;width:100%;">
                                                    <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="vertical-align:top;" width="100%">
                                                        <tr>
                                                            <td align="left" style="font-size:0px;padding:10px 25px;word-break:break-word;">
                                                                <div style="font-family:Roboto, Arial;font-size:13px;line-height:1;text-align:left;color:#4a4a4a;">
                                                                    {$order->comment|escape|nl2br}
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
                                                        <a href="{$config->root_url}/simpla/index.php?module=OrderAdmin&id={$order->id}" style="background:#2196F3;color:#ffffff;font-family:Roboto, Helvetica, Arial, sans-serif;font-size:13px;font-weight:normal;line-height:120%;Margin:0;text-decoration:none;text-transform:none;" target="_blank">
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