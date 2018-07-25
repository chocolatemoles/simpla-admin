{assign modules_permissions [
	'ProductsAdmin'       => 'products',
	'ProductAdmin'        => 'products',
	'CategoriesAdmin'     => 'categories',
	'CategoryAdmin'       => 'categories',
	'BrandsAdmin'         => 'brands',
	'BrandAdmin'          => 'brands',
	'FeaturesAdmin'       => 'features',
	'FeatureAdmin'        => 'features',
	'OrdersAdmin'         => 'orders',
	'OrderAdmin'          => 'orders',
	'OrdersLabelsAdmin'   => 'labels',
	'OrdersLabelAdmin'    => 'labels',
	'UsersAdmin'          => 'users',
	'UserAdmin'           => 'users',
	'ExportUsersAdmin'    => 'users',
	'GroupsAdmin'         => 'groups',
	'GroupAdmin'          => 'groups',
	'CouponsAdmin'        => 'coupons',
	'CouponAdmin'         => 'coupons',
	'PagesAdmin'          => 'pages',
	'PageAdmin'           => 'pages',
	'BlogAdmin'           => 'blog',
	'PostAdmin'           => 'blog',
	'CommentsAdmin'       => 'comments',
	'FeedbacksAdmin'      => 'feedbacks',
	'ImportAdmin'         => 'import',
	'ExportAdmin'         => 'export',
	'BackupAdmin'         => 'backup',
	'StatsAdmin'          => 'stats',
	'ThemeAdmin'          => 'design',
	'StylesAdmin'         => 'design',
	'TemplatesAdmin'      => 'design',
	'ImagesAdmin'         => 'design',
	'SettingsAdmin'       => 'settings',
	'CurrencyAdmin'       => 'currency',
	'DeliveriesAdmin'     => 'delivery',
	'DeliveryAdmin'       => 'delivery',
	'PaymentMethodAdmin'  => 'payment',
	'PaymentMethodsAdmin' => 'payment',
	'ManagersAdmin'       => 'managers',
	'ManagerAdmin'        => 'managers',
	'LicenseAdmin'        => 'license'
]}
	
{function name='menu_link'}
	{if in_array($permissions, $manager->permissions)}
		<li>
			<a href="index.php?module={$module}" class="{if $smarty.get.module == $module || ($submodule && $smarty.get.module == $submodule)}active{/if}">{$title}</a>
		</li>
	{/if}
{/function}

{function name='menu_link_order'}
	{if in_array($permissions, $manager->permissions)}
		<li>
			<a href="index.php?module={$module}{if $status}&status={$status}{/if}" 
				{if $smarty.get.module == 'OrdersAdmin' && !$keyword}
					class="{if $smarty.get.status == $status}active{/if}"
				{elseif $smarty.get.module == 'OrderAdmin' && !$keyword}	
					class="{if gettype($order->status) != 'NULL'}{if $order->status == $status}active{/if}{elseif $status === 0}active{/if}"
				{/if}
			>
				{$title}
			</a>
		</li>
	{/if}
{/function}

<ul class="sidemenu-categories">
	<!-- Catalog -->
	{assign menu_modules ['ProductsAdmin', 'ProductAdmin', 'CategoriesAdmin', 'CategoryAdmin', 'BrandsAdmin', 'BrandAdmin', 'FeaturesAdmin', 'FeatureAdmin']}
	{foreach $menu_modules as $m}
		{if in_array($modules_permissions[$m], $manager->permissions)}
			<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
				<a href="index.php?module={$m}">Каталог</a>
				
				<em class="sidemenu-toggle"></em>
				
				<ul>
					{menu_link title='Товары' 	 module='ProductsAdmin'   permissions='products'   submodule='ProductAdmin'}
					{menu_link title='Категории' module='CategoriesAdmin' permissions='categories' submodule='CategoryAdmin'}
					{menu_link title='Бренды' 	 module='BrandsAdmin' 	  permissions='brands' 	   submodule='BrandAdmin'}
					{menu_link title='Свойства'  module='FeaturesAdmin'   permissions='features'   submodule='FeatureAdmin'}
				</ul>
			</li>
			{break}
		{/if}
	{/foreach}

	<!-- Orders -->
	{assign menu_modules ['OrdersAdmin', 'OrderAdmin', 'OrdersLabelsAdmin', 'OrdersLabelAdmin']}
	{foreach $menu_modules as $m}
		{if in_array($modules_permissions[$m], $manager->permissions)}
			<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
				<a href="index.php?module={$m}">Заказы
					<span class="counters">
						{if $new_orders_counter}
							<span class="counter">{$new_orders_counter}</span>
						{/if}
					</span>
				</a>

				<em class="sidemenu-toggle"></em>
				
				<ul>
					{menu_link_order title='Новые'		module='OrdersAdmin' permissions='orders' submodule='OrderAdmin' status=0}
					{menu_link_order title='Приняты'	module='OrdersAdmin' permissions='orders' submodule='OrderAdmin' status=1}
					{menu_link_order title='Выполнены'	module='OrdersAdmin' permissions='orders' submodule='OrderAdmin' status=2}
					{menu_link_order title='Удалены'	module='OrdersAdmin' permissions='orders' submodule='OrderAdmin' status=3}
					{menu_link title='Метки' module='OrdersLabelsAdmin' permissions='labels' submodule='OrdersLabelAdmin'}
					
					{if $keyword && in_array($smarty.get.module, ['OrdersAdmin'])}
						<li>
							<a href="{url}" class="active">Поиск</a>
						</li>
					{/if}
				</ul>
			</li>
			{break}
		{/if}
	{/foreach}
	
	<!-- Customers -->
	{assign menu_modules ['UsersAdmin', 'UserAdmin', 'ExportUsersAdmin', 'GroupsAdmin', 'GroupAdmin', 'CouponsAdmin', 'CouponAdmin']}
	{foreach $menu_modules as $m}
		{if in_array($modules_permissions[$m], $manager->permissions)}
			<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
				<a href="index.php?module={$m}">Покупатели</a>
				
				<em class="sidemenu-toggle"></em>
				
				<ul>
					{menu_link title='Покупатели' module='UsersAdmin'   permissions='users'   submodule='UserAdmin'}
					{menu_link title='Группы' 	  module='GroupsAdmin'	permissions='groups'  submodule='GroupAdmin'}
					{menu_link title='Купоны'	  module='CouponsAdmin'	permissions='coupons' submodule='CouponAdmin'}
					
					{if $smarty.get.module == 'ExportUsersAdmin'}
						{menu_link title='Экспорт покупателей' module='ExportUsersAdmin' permissions='users'}
					{/if}
				</ul>
			</li>
			{break}
		{/if}
	{/foreach}
	
	<!-- Pages -->
	{if in_array('pages', $manager->permissions)}
		<li class="sidemenu-list {if in_array($smarty.get.module, ['PagesAdmin', 'PageAdmin'])}opened{/if}">
			<a href="index.php?module=PagesAdmin&menu_id=1">Страницы</a>
			
			<em class="sidemenu-toggle"></em>
			
			<ul>
				<li><a href="index.php?module=PagesAdmin&menu_id=1" class="{if $smarty.get.menu_id == 1}active{/if}">Основное меню</a></li>
				<li><a href="index.php?module=PagesAdmin&menu_id=2" class="{if $smarty.get.menu_id == 2}active{/if}">Другие страницы</a></li>
			</ul>
		</li>
	{/if}
	
	<!-- Blog -->
	{if in_array('blog', $manager->permissions)}
		<li class="sidemenu-list {if in_array($smarty.get.module, ['BlogAdmin', 'PostAdmin'])}active{/if}">
			<a href="index.php?module=BlogAdmin">Блог</a>
		</li>
	{/if}
	
	<!-- Comments -->
	{assign menu_modules ['CommentsAdmin', 'FeedbacksAdmin']}
	{foreach $menu_modules as $m}
		{if in_array($modules_permissions[$m], $manager->permissions)}
			<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
				<a href="index.php?module={$m}">Комментарии
					<span class="counters">
						{if $new_comments_counter}
							<span class="counter">{$new_comments_counter}</span>
						{/if}
					</span>
				</a>
				
				<em class="sidemenu-toggle"></em>
				
				<ul>
					{menu_link title='Комментарии'	  module='CommentsAdmin'  permissions='comments'}
					{menu_link title='Обратная связь' module='FeedbacksAdmin' permissions='feedbacks'}
				</ul>
			</li>
			{break}
		{/if}
	{/foreach}
	
	<!-- Stuff -->
	{assign menu_modules ['ImportAdmin', 'ExportAdmin', 'BackupAdmin']}
	{foreach $menu_modules as $m}
		{if in_array($modules_permissions[$m], $manager->permissions)}
			<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
				<a href="index.php?module={$m}">Автоматизация</a>
				
				<em class="sidemenu-toggle"></em>
				
				<ul>
					{menu_link title='Импорт'  module='ImportAdmin' permissions='import'}
					{menu_link title='Экспорт' module='ExportAdmin' permissions='export'}
					{menu_link title='Бекап'   module='BackupAdmin' permissions='backup'}
				</ul>
			</li>
			{break}
		{/if}
	{/foreach}
	
	<!-- Stats -->
	{if in_array('stats', $manager->permissions)}
		<li class="sidemenu-list {if $smarty.get.module == 'StatsAdmin'}active{/if}">
			<a href="index.php?module=StatsAdmin">Статистика</a>
		</li>
	{/if}
	
	<!-- Design -->
	{assign menu_modules ['ThemeAdmin', 'TemplatesAdmin', 'StylesAdmin', 'ImagesAdmin']}
	{if in_array('design', $manager->permissions)}
		<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
			<a href="index.php?module=ThemeAdmin">Дизайн</a>
			
			<em class="sidemenu-toggle"></em>
			
			<ul>
				{menu_link title='Тема'			module='ThemeAdmin'		permissions='design'}
				{menu_link title='Шаблоны'		module='TemplatesAdmin'	permissions='design'}
				{menu_link title='Стили'		module='StylesAdmin'	permissions='design'}
				{menu_link title='Изображения'	module='ImagesAdmin'	permissions='design'}
			</ul>
		</li>
	{/if}
	
	<!-- Settings -->
	{assign menu_modules ['SettingsAdmin', 'CurrencyAdmin', 'DeliveriesAdmin', 'DeliveryAdmin', 'PaymentMethodsAdmin', 'PaymentMethodAdmin', 'ManagersAdmin', 'ManagerAdmin']}
	{foreach $menu_modules as $m}
		{if in_array($modules_permissions[$m], $manager->permissions)}
			<li class="sidemenu-list {if in_array($smarty.get.module, $menu_modules)}opened{/if}">
				<a href="index.php?module={$m}">Настройки</a>
				
				<em class="sidemenu-toggle"></em>
				
				<ul>
					{menu_link title='Настройки' module='SettingsAdmin' permissions='settings'}
					{menu_link title='Валюты' module='CurrencyAdmin' permissions='currency'}
					{menu_link title='Доставка' module='DeliveriesAdmin' permissions='delivery' submodule='DeliveryAdmin'}
					{menu_link title='Оплата' module='PaymentMethodsAdmin' permissions='payment' submodule='PaymentMethodAdmin'}
					{menu_link title='Менеджеры' module='ManagersAdmin' permissions='managers' submodule='ManagerAdmin'}
				</ul>
			</li>
			{break}
		{/if}
	{/foreach}
	
	{if $smarty.get.return}
		<li class="sidemenu-return"><a href="{$smarty.get.return}">Вернуться</a></li>
	{/if}
</li>