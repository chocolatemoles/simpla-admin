{if $m->login}
    {$meta_title = $m->login scope=root}
	{$page_title = 'Редактирование менеджера' scope=root}
{else}
    {$meta_title = 'Новый менеджер' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Менеджер добавлен' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Менеджер обновлен' scope=root}
{elseif $message_error=='login_exists'}
	{$alert_error = 'Менеджер с таким логином уже существует' scope=root}
{elseif $message_error=='empty_login'}
	{$alert_error = 'Введите логин' scope=root}
{elseif $message_error=='not_writable'}
	{$alert_error = 'Установите права на запись для файла /simpla/.passwd' scope=root}
{/if}

<form method="post" autocomplete="off" data-form="main">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="old_login" value="{$m->login|escape}">
	
	<div class="form-row">
		<label for="" class="form-label">Логин</label>
		<input type="text" class="form-input" name="login" value="{$m->login|escape}" maxlength="32" data-width="md" required>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Пароль</label>
		<input type="password" class="form-input" name="password" value="" data-width="md" required {if $m->login} disabled{/if}>
		{if $m->login}<a href="#" class="action-link" data-action="change-password">изменить</a>{/if}
	</div>
	
	<hr>

	<p class="block-title">Права доступа</p>
	
	{if $m->login != $manager->login}
	<div class="form-row">
		<a href="#" class="action-link" data-action="check-all">Выбрать все</a>
	</div>
	{/if}
	
	{$perms = [
		'products'   =>'Товары',
		'categories' =>'Категории',
		'brands'     =>'Бренды',
		'features'   =>'Свойства товаров',
		'orders'     =>'Заказы',
		'labels'     =>'Метки заказов',
		'users'      =>'Покупатели',
		'groups'     =>'Группы покупателей',
		'coupons'    =>'Купоны',
		'pages'      =>'Страницы',
		'blog'       =>'Блог',
		'comments'   =>'Комментарии',
		'feedbacks'  =>'Обратная связь',
		'import'     =>'Импорт',
		'export'     =>'Экспорт',
		'backup'     =>'Бекап',
		'stats'      =>'Статистика',
		'design'     =>'Дизайн',
		'settings'   =>'Настройки',
		'currency'   =>'Валюты',
		'delivery'   =>'Способы доставки',
		'payment'    =>'Способы оплаты',
		'managers'   =>'Менеджеры',
		'license'    =>'Управление лицензией'
	]}
	
	{foreach $perms as $p=>$name}
		<div>
			<input type="checkbox" class="form-checkbox" name="permissions[]" value="{$p}" id="{$p}" {if $m->permissions && in_array($p, $m->permissions)} checked{/if} {if $m->login == $manager->login} disabled{/if}>
			<label for="{$p}" class="form-label" data-width="auto">{$name}</label>
		</div>
	{/foreach}

	<div class="action-panel">
		<input class="btn" type="submit" value="Сохранить">
	</div>
</form>

{capture name = 'scripts'}
<script>
(function($){
	'use strict';
	
	$('[data-action=change-password]').on('click', function(e){
		e.preventDefault();
		
		$('[type=password]').prop('disabled', false).focus();
		this.parentNode.removeChild(this);
	});
	
})(window.jQuery)
</script>
{/capture}