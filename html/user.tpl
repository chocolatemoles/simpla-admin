{if $user->id}
	{$meta_title = $user->name|escape scope=root}
{/if}

{$page_title = "Покупатель: {$user->name}" scope=root}

{if $message_success == 'updated'}
	{$alert_success = 'Покупатель отредактирован' scope=root}
{elseif $message_error == 'login_exists'}
	{$alert_error = 'Покупатель с таким email уже зарегистрирован' scope=root}
{elseif $message_error == 'empty_name'}
	{$alert_error = 'Введите имя покупателя' scope=root}
{elseif $message_error == 'empty_email'}
	{$alert_error = 'Введите email покупателя' scope=root}
{/if}

<form method="post" autocomplete="off" data-form="main">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$user->id|escape}">

	<div class="form-row">
		<label class="form-label">Имя</label>
		<input class="form-input" type="text" name="name" value="{$user->name|escape}" required>
	</div>
	
	<div class="form-row">
		<label class="form-label">Активен</label>
		<input class="form-checkbox" name="enabled" value="1" type="checkbox" {if $user->enabled} checked{/if}>
	</div>

	{if $groups}
	<div class="form-row">
		<label class="form-label">Группа</label>
		<select class="form-input" name="group_id">
			<option value="0">Не входит в группу</option>
			{foreach $groups as $g}
				<option value="{$g->id}" {if $user->group_id == $g->id}selected{/if}>{$g->name|escape}</option>
			{/foreach}
		</select>
	</div>
	{/if}
	
	<div class="form-row">
		<label class="form-label">Email</label>
		<div class="form-input-box">
			<input class="form-input" type="email" name="email" value="{$user->email|escape}" required>
			<a href="mailto:{$user->email|escape}" class="form-input-link" title="{$order->email|escape}"><i class="icon-mail"></i></a>
		</div>
	</div>
	
	<div class="form-row">
		<label class="form-label">Дата регистрации</label>
		<input class="form-input" type="text" value="{$user->created|date}" data-width="sm" disabled>
	</div>
	
	<div class="form-row">
		<label class="form-label">Последний IP</label>
		<input class="form-input" type="text" value="{$user->last_ip|escape}" data-width="sm" disabled>
	</div>

	<div class="action-panel">
		<input class="btn" type="submit" name="user_info" value="Сохранить">
	</div>
</form>

<hr>

<p class="block-title">Заказы</p>

{if $orders}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list list-orders">
			{foreach $orders as $order}
				<div class="list-item {if $order->paid} paid{/if}">
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$order->id}"/>

					<div class="list-name">
						<a href="{url module=OrderAdmin id=$order->id return=$smarty.server.REQUEST_URI}">Заказ №{$order->id}</a>
					</div>

					<div class="list-order-date">{$order->date|date} {$order->date|time}</div>
					<div class="list-order-total">{$order->total_price}&nbsp;{$currency->sign}</div>
					<div class="list-order-paid">{if $order->paid}Оплачен{else}Не оплачен{/if}</div>
					<div class="list-order-customer"><!-- For padding --></div>

					{if $order->note}
						<div class="list-order-note">{$order->note|escape}</div>
					{/if}
					
					<div class="list-actions">
						<a href="#" class="list-action" data-action="delete"></a>
					</div>
				</div>
			{/foreach}
		</div>

		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" name="user_orders" type="submit" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Этот покупатель еще не сделал ни одного заказа</p>
{/if}

{capture name = 'sidebar'}
<!-- For padding -->
{/capture}