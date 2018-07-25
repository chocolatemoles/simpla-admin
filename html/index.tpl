<!doctype html>
<html lang="ru">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="-1">

	<title>{$meta_title}</title>
	
	<link rel="icon" href="design/images/favicon.ico" type="image/x-icon">
	
	<!-- Fonts -->
	<link rel="stylesheet" href="design/fonts/roboto/roboto.css">
	<link rel="stylesheet" href="design/fonts/fontello/css/fontello.css">
	
	<!-- Styles -->
	{assign version "?1.0"}
	<link rel="stylesheet" href="design/css/normalize.css">
	<link rel="stylesheet" href="design/css/global.css{$version}">
	<link rel="stylesheet" href="design/css/styles.css{$version}">
	<link rel="stylesheet" href="design/css/responsive.css{$version}">

	<!-- Plugins -->
	{$smarty.capture.styles}
	
	<script src="design/js/modernizr.js"></script>

	<script>
		var backend = {
			session_id: '{$smarty.session.id}',
			module: '{$smarty.get.module}',
			object: (function(){
				switch('{$smarty.get.module}') {
					case 'ProductsAdmin': 		return 'product'; 	break;
					case 'CategoriesAdmin':		return 'category'; 	break;
					case 'BrandsAdmin': 		return 'brands'; 	break;
					case 'FeaturesAdmin': 		return 'feature';	break;
					case 'PagesAdmin': 			return 'page'; 		break;
					case 'BlogAdmin': 			return 'blog'; 		break;
					case 'DeliveriesAdmin': 	return 'delivery'; 	break;
					case 'PaymentMethodsAdmin': return 'payment'; 	break;
					case 'CurrencyAdmin': 		return 'currency'; 	break;
					case 'CommentsAdmin': 		return 'comment'; 	break;
					case 'UsersAdmin': 			return 'user'; 		break;
					default: return false;
				}
			})()
		};
	</script>
</head>
<body>
	<div class="content">
		<div class="container">
			<div class="content-left">
				<a href="{$config->root_url}" class="sidemenu-store-link">В магазин</a>

				<div class="sidemenu-account-box">
					<span class="sidemenu-account-label">Вы вошли как</span>
					<span class="sidemenu-account-login">{$manager->login}</span>
					<a href='{$config->root_url}?logout' class="sidemenu-account-logout" title="Выйти"></a>
				</div>

				<button type="button" class="mobile-menu-toggle">Меню</button>
				
				<div class="sidemenu-categories-wrapper">
					{include file = 'inc/side_menu.tpl'}
				</div>
			</div>

			<div class="content-top">
				{include file = 'inc/share.tpl'}

				{if $smarty.get.module == 'OrderAdmin'}
					<div class="siblings-orders">
						{if $prev_order}
							<a href="{url id=$prev_order->id}" class="siblings-order-left" title="Предыдущий заказ"><i class="icon-angle-left"></i></a>
						{/if}
						{if $next_order}
							<a href="{url id=$next_order->id}" class="siblings-order-right" title="Следующий заказ"><i class="icon-angle-right"></i></a>
						{/if}
					</div>
					
					{if $order->date}
						<div class="order-date">
							{assign months [
								'Jan'=>'января',
								'Feb'=>'февраля',
								'Mar'=>'марта',
								'Apr'=>'апреля',
								'May'=>'мая',
								'Jun'=>'июня',
								'Jul'=>'июля',
								'Aug'=>'августа',
								'Sep'=>'сентября',
								'Oct'=>'октября',
								'Nov'=>'ноября',
								'Dec'=>'декабря'
							]}

							{$order->date|date_format:'%e'} {$months[$order->date|date_format:'%b']} {$order->date|date:'Y'}, {$order->date|time}
						</div>
					{/if}
				{/if}

				<p class="page-title">{if $page_title}{$page_title}{else}{$meta_title}{/if}</p>
				
				{if $page_subtitle}
					<p class="block-title">{$page_subtitle}</p>
				{/if}
				
				{if $alert_success}
					<p class="alert alert-success">{$alert_success} {include file = 'inc/add_more.tpl'}</p>
				{elseif $alert_error}
					<p class="alert alert-error">{$alert_error}</p>
				{elseif $alert_info}
					<p class="alert alert-info">{$alert_info}</p>
				{elseif $alert}
					<p class="alert">{$alert}</p>
				{/if}
			</div>
			
			<div class="clearfix">
				<div class="content-center {if !$smarty.capture.sidebar} content-fullwidth{/if}">
					{$content}
				</div>
				
				{if $smarty.capture.sidebar}
				<div class="content-right">
					{$smarty.capture.sidebar}
				</div>
				{/if}
			</div>
			
			{if $smarty.capture.bottom}
			<div class="content-bottom">
				{$smarty.capture.bottom}
			</div>
			{/if}
		</div>
	</div>
	
	<div class="container">
		<div class="content-footer">
			<div class="content-footer-inner">
				&copy; {if date('Y') != '2018'}2018-{/if}{date('Y')} <a href="//simplacms.ru">Simpla {$config->version}</a>
				{if in_array('license', $manager->permissions)}
					{if $license->valid}
						Лицензия действительна {if $license->expiration != '*'}до {$license->expiration}{/if}.
					{else}
						Лицензия недействительна.
					{/if}
					<a href='index.php?module=LicenseAdmin'>Управление лицензией</a>
				{/if}
			</div>
		</div>
	</div>

	<!-- jQuery -->
	<script src="design/js/jquery/jquery.min.js"></script>

	<!-- Plugins -->
	<script src="design/js/scrollbar/smooth-scrollbar.js"></script>

	<!-- Meta & TinyMCE -->
	{if in_array($smarty.get.module, ['ProductAdmin', 'CategoryAdmin', 'BrandAdmin', 'PageAdmin', 'PostAdmin', 'DeliveryAdmin', 'PaymentMethodAdmin'])}
	<script src="design/js/meta.js{$version}"></script>
	<script src="design/js/tinymce/tinymce.min.js"></script>
	<script src="design/js/tinymce_init.js"></script>
	{/if}
	
	<!-- Custom -->
	<script src="design/js/custom.js{$version}"></script>
	
	{$smarty.capture.scripts}
	
	<!-- Prostie Zvonki -->
	{if !$settings->pz_server && !$settings->pz_phones[$manager->login]}
	<div class="pz-popup"></div>
	<script src="design/js/prostiezvonki/prostiezvonki.min.js"></script>
	<script>
		var pzConfig = {
			type: 'simpla',
			server: '{$settings->pz_server}',
			password: '{$settings->pz_password}',
			phone: '{$settings->pz_phones[$manager->login]}'
		};
	</script>
	<script src="design/js/prostiezvonki/prostiezvonki_init.js"></script>
	{/if}
</body>
</html>