{if $payment_method->id}
    {$meta_title = $payment_method->name scope=root}
    {$page_title = 'Редактирование способа оплаты' scope=root}
{else}
    {$meta_title = 'Новый способ оплаты' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Способ оплаты добавлен' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Способ оплаты изменен' scope=root}
{elseif $message_error == 'empty_name'}
	{$alert_error = 'Укажите название способа оплаты' scope=root}
{/if}

<form method="post" autocomplete="off">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$payment_method->id}">
	
	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$payment_method->name|escape}" required>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Активен</label>
		<input type="checkbox" class="form-checkbox" name="enabled" value="1" {if $payment_method->enabled} checked{/if}>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Модуль</label>
		<select name="module" class="form-input">
            <option value="null">Ручная обработка</option>
            {foreach $payment_modules as $payment_module}
                <option value="{$payment_module@key|escape}"{if $payment_method->module == $payment_module@key} selected{/if}>{$payment_module->name|escape}</option>
            {/foreach}
        </select>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Валюта</label>
		<select name="currency_id" class="form-input">
			{foreach $currencies as $currency}
				<option value="{$currency->id}"{if $currency->id==$payment_method->currency_id} selected{/if}>{$currency->name|escape}</option>
			{/foreach}
		</select>
	</div>

	{foreach $payment_modules as $payment_module}
		<div class="js-module-item {if $payment_module@key != $payment_method->module} hidden{/if}" data-module="{$payment_module@key}">
			<hr>
		
			<p class="block-title">{$payment_module->name}</p>

			{if $payment_module@key == $payment_method->module}
				{$disabled = ''}
			{else}
				{$disabled = 'disabled'}
			{/if}
			
			{foreach $payment_module->settings as $setting}
			<div class="form-row">
				{if $setting->options|@count>1}
					<label for="ps_{$setting->variable}" class="form-label">{$setting->name}</label>
					<select id="ps_{$setting->variable}" name="payment_settings[{$setting->variable}]" class="form-input" {$disabled}>
						{foreach $setting->options as $option}
							<option value="{$option->value}" {if $option->value==$payment_settings[$setting->variable]} selected{/if}>{$option->name|escape}</option>
						{/foreach}
					</select>
				{elseif $setting->options|@count==1}
					{$option = $setting->options|@first}
					<label for="ps_{$setting->variable}" class="form-label" >{$setting->name|escape}</label>
					<input type="checkbox"
						name="payment_settings[{$setting->variable}]" 
						class="form-checkbox" 
						value="{$option->value|escape}"
						id="ps_{$setting->variable}"
						{if $option->value == $payment_settings[$setting->variable]} checked{/if}
						{$disabled}>
					<label for="ps_{$setting->variable}" class="form-label">{$option->name}</label>
				{else}
					<label for="ps_{$setting->variable}" class="form-label">{$setting->name|escape}</label>
					<input type="text"
						class="form-input"
						name="payment_settings[{$setting->variable}]"
						id="ps_{$setting->variable}"
						value="{$payment_settings[$setting->variable]|escape}"
						{$disabled}>
				{/if}
			</div>
			{/foreach}
		</div>
	{/foreach}

	<hr>
	
	<p class="block-title">Возможные способы доставки</p>

	{foreach $deliveries as $delivery}
		<div>
			<input type="checkbox" class="form-checkbox" name="payment_deliveries[]" id="delivery_{$delivery->id}" value="{$delivery->id}" {if in_array($delivery->id, $payment_deliveries)} checked{/if}>
			<label for="delivery_{$delivery->id}" class="form-label" data-width="auto">{$delivery->name}</label>
		</div>
	{/foreach}
    
	<hr>
	
	<p class="block-title">Описание</p>
	<textarea name="description" class="js-editor" rows="6">{$payment_method->description|escape}</textarea>

	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
	</div>
</form>

{capture name = 'scripts'}
<script>
(function($){
	'use strict';
	
	var $moduleItems = $('.js-module-item');

	$('select[name=module]').change(function () {
		$moduleItems.addClass('hidden').find('input, select, textarea').prop('disabled', true);
		$('[data-module=' + $(this).val() + ']').removeClass('hidden').find('input, select, textarea').prop('disabled', false);
	});
	
})(window.jQuery);
</script>
{/capture}