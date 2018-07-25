{if $coupon->code}
	{$meta_title = $coupon->code scope=root}
	{$page_title = 'Редактирование купона' scope=root}
{else}
	{$meta_title = 'Новый купон' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Купон добавлен' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Купон изменен' scope=root}
{elseif $message_error == 'code_exists'}
	{$alert_error = 'Купон с таким кодом уже существует' scope=root}
{elseif $message_error == 'code_empty'}
	{$alert_error = 'Заполните название купона' scope=root}
{/if}

<form method="post" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$coupon->id|escape}">
	
	<div class="form-row">
		<label class="form-label">Код купона</label>
		<input class="form-input" type="text" name="code" value="{$coupon->code|escape}" required>
	</div>
	
	<div class="form-row">
		<label class="form-label">Скидка</label>
		<input class="form-input" type="text" name="value" value="{$coupon->value|escape}" data-width="sm">
		
		<select class="form-input" name="type" data-width="xs">
			<option value="percentage" {if $coupon->type=='percentage'}selected{/if}>%</option>
			<option value="absolute" {if $coupon->type=='absolute'}selected{/if}>{$currency->sign}</option>
		</select>
	</div>	
	
	<div class="form-row">
		<label class="form-label">Для заказов от</label>
		<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
			<input class="form-input" type="text" name="min_order_price" value="{$coupon->min_order_price|escape}" >
		</span>
	</div>

	<div class="form-row">
		<label class="form-label">Одноразовый</label>
		<input class="form-checkbox" type="checkbox" name="single" value="1" {if $coupon->single==1}checked{/if}>
	</div>
	
	<div class="form-row">
		<label class="form-label">Истекает</label>
		<input class="form-checkbox" type="checkbox" name="expires" value="1" {if $coupon->expire}checked{/if}>
		<input class="form-input js-datepicker" type="text" name="expire" value="{$coupon->expire|date}" data-width="sm">
	</div>

	<hr>
	
	<input class="btn" type="submit" value="Сохранить">
</form>

{capture name = 'scripts'}
<script src="design/js/datepicker/datepicker.min.js"></script>
<link rel="stylesheet" href="design/js/datepicker/datepicker.min.css">
<script>
(function($){
	'use strict';

	$('input[name="expire"]').focus(function () {
		$('input[name="expires"]').attr('checked', true);
	});
	
	// Datepicker
	$('.js-datepicker').datepicker();
	
}(window.jQuery));
</script>
{/capture}