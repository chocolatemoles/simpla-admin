{if $delivery->id}
    {$meta_title = $delivery->name scope=root}
	{$page_title = 'Редактирование способа доставки' scope=root}
{else}
    {$meta_title = 'Новый способ доставки' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Способ доставки добавлен' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Способ доставки изменен' scope=root}
{elseif $message_error == 'empty_name'}
	{$alert_error = 'Не указано название доставки' scope=root}
{/if}

<form method="post" autocomplete="off">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$delivery->id}">
	
	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$delivery->name|escape}" required>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Активен</label>
		<input type="checkbox" class="form-checkbox" name="enabled" value="1" {if $delivery->enabled} checked{/if}>
	</div>

	<hr>
	
	<p class="block-title">Стоимость доставки</p>
	
	<div class="form-row">
		<label for="" class="form-label">Стоимость</label>
		<div class="form-input-box" data-width="sm" data-suffix="{$currency->sign}">
			<input type="text" class="form-input" name="price" value="{$delivery->price}">
		</div>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Бесплатна от</label>
		<div class="form-input-box" data-width="sm" data-suffix="{$currency->sign}">
			<input type="text" class="form-input" name="free_from" value="{$delivery->free_from}">
		</div>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Оплачивается отдельно</label>
		<input type="checkbox" class="form-checkbox" name="separate_payment" value="1" {if $delivery->separate_payment} checked{/if}>
	</div>
	
	<hr>
	
	<p class="block-title">Возможные способы оплаты</p>

	{foreach $payment_methods as $payment_method}
		<div>
			<input type="checkbox" 
				id="payment_{$payment_method->id}" 
				class="form-checkbox" 
				name="delivery_payments[]" 
				value="{$payment_method->id}" 
				{if in_array($payment_method->id, $delivery_payments)} checked{/if}
			>
			<label for="payment_{$payment_method->id}" class="form-label" data-width="auto">{$payment_method->name}</label>
		</div>
	{/foreach}

	<hr>
	
	<p class="block-title">Описание</p>
	<textarea name="description" class="js-editor" rows="10">{$delivery->description|escape}</textarea>

	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
	</div>
</form>