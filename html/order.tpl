{if $order->id}
	{$meta_title = "Заказ №{$order->id}" scope=root}
{else}
	{$meta_title = 'Новый заказ' scope=root}
{/if}

{if $message_error=='error_closing'}
	{$alert_error = 'Нехватка товара на складе' scope=root}
{elseif $message_error}
	{$alert_error = "$message_error" scope=root}
{elseif $message_success=='updated'}
	{$alert_success = 'Заказ обновлен' scope=root}
{elseif $message_success=='added'}
	{$alert_success = 'Заказ добавлен' scope=root}
{/if}

<form method="post" enctype="multipart/form-data" class="{if !$purchases} edit-purchases{/if} {if !$order->id} edit-user{/if}" data-form="order" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$order->id|escape}">

	<div class="order-section clearfix">
		<div class="order-section-main">
			<!-- Purchases -->
			<p class="alert js-alert-no-purchases {if $purchases} hidden{/if}">В заказе нет товаров</p>
			
			<div class="list list-order-purchases">
				{foreach $purchases as $purchase}
					<div class="list-item">
						<input type="hidden" name="purchases[id][{$purchase->id}]" value="{$purchase->id}">
						<input type="hidden" name="purchases[price][{$purchase->id}]" value="{$purchase->price}">
						<input type="hidden" name="purchases[amount][{$purchase->id}]" value="{$purchase->amount}">
						<input type="hidden" name="purchases[variant_id][{$purchase->id}]" value="{$purchase->variant_id}">
						
						<div class="list-image">
							{$image = $purchase->product->images|first}
							{if $image}
							<img src="{$image->filename|resize:35:35}" alt="">
							{/if}
						</div>
						
						<div class="list-name">
							{if $purchase->product}
								<a href="index.php?module=ProductAdmin&id={$purchase->product->id}" target="_blank">{$purchase->product_name}</a>
							{else}
								{$purchase->product_name}
							{/if}
						</div>
						
						<div class="list-variants">
							<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
								<input type="text" class="form-input text-right colored" name="purchases[price][{$purchase->id}]" value="{$purchase->price}" disabled>
							</span>

							{if $purchase->variant}
							{math equation="min(max(x,y),z)" x=$purchase->variant->stock+$purchase->amount*($order->closed) y=$purchase->amount z=$settings->max_order_amount assign="loop"}
							{else}
							{math equation="x" x=$purchase->amount assign="loop"}
							{/if}
							
							<span class="form-input-box" data-suffix="{$settings->units}" data-width="xs">
								<select name="purchases[amount][{$purchase->id}]" class="form-input colored" disabled>
									{section name=amounts start=1 loop=$loop+1 step=1}
										<option value="{$smarty.section.amounts.index}" {if $purchase->amount==$smarty.section.amounts.index} selected{/if}>{$smarty.section.amounts.index}</option>
									{/section}
								</select>
							</span>

							<select name="purchases[variant_id][{$purchase->id}]" 
									class="form-input colored {if $purchase->product->variants|count < 2 && $purchase->variant_name == '' && $purchase->variant->sku == ''} hidden{/if}"
									data-width="auto"
									disabled
							>
								{if !$purchase->variant}
									<option value="" data-price="{$purchase->price}" data-amount="{$purchase->amount}">
										{if $purchase->sku}(арт. {$purchase->sku}) {/if}{$purchase->variant_name|escape} 
									</option>
								{/if}
								
								{foreach $purchase->product->variants as $v}
									{if $v->stock>0 || $v->id == $purchase->variant->id}
									<option value="{$v->id}" data-price="{$v->price}" data-amount="{$v->stock}" {if $v->id == $purchase->variant_id} selected{/if}>
										{if $v->sku}(арт. {$v->sku}) {/if}{$v->name}
									</option>
									{/if}
								{/foreach}
							</select>
						</div>

						<div class="list-order-purchases-error">
							{if !$order->closed}
								{if !$purchase->product}
								Товар был удалён
								{elseif !$purchase->variant}
								Вариант товара был удалён
								{elseif $purchase->variant->stock < $purchase->amount}
								На складе остал{$purchase->variant->stock|plural:'ся':'ось'} {$purchase->variant->stock} товар{$purchase->variant->stock|plural:'':'ов':'а'}
								{/if}
							{/if}
						</div>
						
						<div class="list-actions">
							<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
						</div>
					</div>
				{/foreach}
			</div>

			<div class="list-order-purchases-bottom">
				{if $purchases}
					<a href="#" class="action-link" data-action="edit-purchases">Редактировать покупки</a>
				{/if}
			
				<div class="form-row {if $purchases} hidden{/if}">
					<label for="" class="form-label">Добавить товар</label>
					<input type="text" class="form-input js-autocomplete-purchases " placeholder="Введите название товара и выберите его из списка">
				</div>
			</div>

			<hr>
			
			<!-- Discount -->
			<div class="form-row">
				<label for="" class="form-label">Скидка</label>
				<span class="form-input-box" data-suffix="%" data-width="sm">
					<input type="text" class="form-input" name="discount" value="{$order->discount}">
				</span>
			</div>

			<div class="form-row">
				<label for="" class="form-label">Купон{if $order->coupon_code} ({$order->coupon_code}){/if}</label>
				<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
					<input type="text" class="form-input" name="coupon_discount" value="{$order->coupon_discount}">
				</span>
			</div>

			<hr>
			
			<!-- Customer -->
			<div class="order-user-section">
				<p class="block-title">Покупатель</p>
				
				<input type="hidden" name="user_id" value="{$user->id}">
				<input type="hidden" name="name"	value="{$order->name|escape}">
				<input type="hidden" name="email"	value="{$order->email|escape}">
				<input type="hidden" name="phone"	value="{$order->phone|escape}">
				<input type="hidden" name="address" value="{$order->address|escape}">
				<input type="hidden" name="comment"	value="{$order->comment|escape}">

				<div class="form-row">
					<label class="form-label">Аккаунт</label>
					<span class="order-user-account-box {if !$user} not-registred{/if}">
						<a href="index.php?module=UserAdmin&id={$user->id}" class="action-link" target="_blank" title="{$user->name|escape}, {$user->email|escape}">Зарегистрирован</a>
						<a href="#" class="action-link gray" data-action="remove-user">Удалить</a>

						<span class="form-label">Не зарегистрирован</span>

						<input type="text" class="form-input js-user-account" placeholder="Выберите аккаунт покупателя">
					</span>
				</div>

				<div class="form-row">
					<label class="form-label">Имя</label>
					<input type="text" name="name" class="form-input" value="{$order->name|escape}" {if $order->id} disabled{/if}>
				</div>
				
				<div class="form-row">
					<label class="form-label">Email</label>
					
					<span class="form-input-box">
						<input type="email" name="email" class="form-input" value="{$order->email|escape}" {if $order->id} disabled{/if}>
						<a href="mailto:{$order->email|escape}?subject=Заказ%20№{$order->id}" class="form-input-link {if !$order->email} hidden{/if}" title="{$order->email|escape}"><i class="icon-mail"></i></a>
					</span>
				</div>

				<div class="form-row">
					<label class="form-label">Телефон</label>
					
					<span class="form-input-box" data-width="md">
						<input type="text" name="phone" class="form-input" value="{$order->phone|escape}" {if $order->id} disabled{/if}>
						<a href="tel:{$order->phone|escape}" class="form-input-link {if $order->phone}js-ip-call{else}hidden{/if}" title="{$order->phone|escape}" data-phone="{$order->phone|escape}"><i class="icon-phone"></i></a>
					</span>
				</div>
				
				<div class="form-row">
					<label class="form-label">
						{if $order->address}
							<a href="http://maps.yandex.ru/?text={$order->address|escape}" class="dashed-link" title="Карта в новом окне" target="_blank">Адрес</a>
						{else}
							Адрес
						{/if}
					</label>
					<textarea name="address" class="form-input" rows="3" {if $order->id} disabled{/if}>{$order->address|escape}</textarea>
					
				</div>

				<div class="form-row">
					<label class="form-label">Комментарий к заказу</label>
					<textarea name="comment" class="form-input" rows="3" {if $order->id} disabled{/if}>{$order->comment|escape}</textarea>
				</div>
				
				{if $order->id}
				<div class="form-row">
					<label class="form-label">&nbsp;</label>
					<a href="#" class="action-link" data-action="edit-user">Редактировать</a>
				</div>
				{/if}
			</div>
			
			<hr>

			<!-- Delivery -->
			<p class="block-title">Доставка</p>
			
			<div class="form-row">
				<label for="" class="form-label">Способ доставки</label>

				<select name="delivery_id" class="form-input">
					<option value="0">Не выбран</option>
					{foreach $deliveries as $d}
					<option value="{$d->id}" {if $d->id==$delivery->id}selected{/if}>{$d->name}</option>
					{/foreach}
				</select>
			</div>

			<div class="form-row">
				<label for="" class="form-label">Стоимость доставки</label>
				<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
					<input type="text" class="form-input" name="delivery_price" value="{$order->delivery_price}">
				</span>
			</div>
			
			<div class="form-row">
				<label for="order-separate-delivery" class="form-label">Оплачивается отдельно</label>
				<input type="checkbox" class="form-checkbox" name="separate_delivery" id="order-separate-delivery" value="1" {if $order->separate_delivery} checked{/if}>
			</div>

			<hr>

			<!-- Payment -->
			<p class="block-title">Оплата</p>
			
			<div class="form-row">
				<label for="" class="form-label">Способ оплаты</label>
				<select name="payment_method_id" class="form-input">
					<option value="0">Не выбран</option>
					{foreach $payment_methods as $pm}
					<option value="{$pm->id}" {if $pm->id == $payment_method->id} selected{/if}>{$pm->name}</option>
					{/foreach}
				</select>
			</div>
			
			<hr>

			<div class="form-row">
				<input type="checkbox" value="1" id="notify_user" name="notify_user">
				<label for="notify_user">Уведомить покупателя о состоянии заказа</label>
			</div>

			<div class="action-panel">
				<input class="btn" type="submit" value="Сохранить">
			</div>
		</div>
		
		<!-- Sidebar -->
		<div class="order-section-sidebar">
			<label class="form-checkbox-area">
				<input type="checkbox" name="paid" value="1" {if $order->paid} checked{/if}>
				<span>Оплачен</span>
			</label>
			
			<div class="form-row">
				<select name="status" class="form-input" data-width="sm">
					<option value="0" {if $order->status == 0}selected{/if}>Новый</option>
					<option value="1" {if $order->status == 1}selected{/if}>Принят</option>
					<option value="2" {if $order->status == 2}selected{/if}>Выполнен</option>
					<option value="3" {if $order->status == 3}selected{/if}>Удален</option>
				</select>
			</div>

			<!-- Total -->
			{if $order->id}
				<hr>
			
				<div class="order-sidebar-total">
					{if $purchases}
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							Товары
						</div>
						
						<div class="order-sidebar-total-price">
							{$subtotal|convert} {$currency->sign}
						</div>
					</div>
					{/if}
					
					{if $order->discount > 0}
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							С учетом скидки
						</div>
						
						<div class="order-sidebar-total-price">
							{($subtotal-$subtotal*$order->discount/100)|convert} {$currency->sign}
						</div>
					</div>
					{/if}
					
					{if $order->coupon_discount > 0}
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							С учетом купона
						</div>
						
						<div class="order-sidebar-total-price">
							{($subtotal-$subtotal*$order->discount/100-$order->coupon_discount)|convert} {$currency->sign}
						</div>
					</div>
					{/if}
					
					{if !$order->separate_delivery && $order->delivery_price > 0}
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							Доставка
						</div>
						
						<div class="order-sidebar-total-price">
							{$order->delivery_price|convert} {$currency->sign}
						</div>
					</div>
					{/if}
					
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							Итого
						</div>
						
						<div class="order-sidebar-total-price">
							{$order->total_price|convert} {$currency->sign}
						</div>
					</div>

					{if $payment_method}
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							К оплате
						</div>
						
						<div class="order-sidebar-total-price">
							{$order->total_price|convert:$payment_currency->id} {$payment_currency->sign}
						</div>
					</div>
					{/if}
				</div>
			
				{if $order->separate_delivery}
				<div class="order-sidebar-total">
					<div class="order-sidebar-total-row">
						<div class="order-sidebar-total-label">
							Доставка
						</div>
						
						<div class="order-sidebar-total-price">
							{$order->delivery_price|convert} {$currency->sign}
						</div>
					</div>
				</div>
				{/if}
			
				<a href="{url view=print id=$order->id}" class="btn" target="_blank"><i class="icon-print"></i> Печать заказа</a>
			{/if}
			
			<hr>
			
			<!-- Labels -->
			{if $labels}
			<div class="sidebar-order-labels">
				<div class="sidebar-order-labels-marks">
					{foreach $labels as $label}
						<div class="sidebar-order-labels-mark js-mark-{$label->id} {if !in_array($label->id, $order_labels)} hidden{/if}" style="background-color: #{$label->color}" title="{$label->name|escape}"></div>
					{/foreach}
				</div>
				
				{foreach $labels as $label}
					<div class="sidebar-order-label">
						<label>
							<input type="checkbox" name="order_labels[]" value="{$label->id}" {if in_array($label->id, $order_labels)} checked{/if}>
							{$label->name}
						</label>
					</div>
				{/foreach}
			</div>
			{/if}

			<div class="form-row">
				{if !$order->note}
					<a href="#" class="action-link" data-action="add-note">Добавить примечание</a>
				{/if}

				<textarea name="note" class="form-input order-note {if !$order->note} hidden{/if}" rows="3">{$order->note|escape}</textarea>
			</div>
		</div>
	</div>
</form>


<div class="hidden">
	<!-- Dummies / Purchase -->
	<div class="list-item js-dummy-purchase">
		<input type="hidden" name="purchases[id][]" value="">
		
		<div class="list-image"></div>
		
		<div class="list-name"></div>
		
		<div class="list-variants">
			<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
				<input type="text" class="form-input text-right colored" name="purchases[price][]" value="">
			</span>

			<span class="form-input-box" data-suffix="{$settings->units}" data-width="xs">
				<select name="purchases[amount][]" class="form-input colored"></select>
			</span>
			
			<select name="purchases[variant_id][]" class="form-input colored" data-width="auto"></select>
		</div>

		<div class="list-actions">
			<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
		</div>
	</div>
</div>

{capture name = 'scripts'}
<link href="design/js/autocomplete/autocomplete.css" rel="stylesheet">
<script src="design/js/autocomplete/jquery.autocomplete.min.js"></script>
<script>
(function($){
	'use strict';

	var $form = $('[data-form=order]');
	var $formLabels = $('.sidebar-order-labels');
	var $listPurchases = $('.list-order-purchases');
	var $orderUser = $('.order-user-section');
	var $dummyPurchase = $('.js-dummy-purchase').removeClass('js-dummy-purchase');
	var $autocompleteInputPurchases = $('.js-autocomplete-purchases');
	
	$form
		// Edit purchases
		.on('click', '[data-action=edit-purchases]', function(e){
			e.preventDefault();
			
			$form.addClass('edit-purchases');
			$listPurchases.find(':disabled').prop('disabled', false)
			
			$autocompleteInputPurchases.parent().removeClass('hidden');
			this.remove();
		})
		// Edit user
		.on('click', '[data-action=edit-user]', function(e){
			e.preventDefault();
			
			$form.addClass('edit-user');

			$orderUser.find(':disabled').prop('disabled', false)
			this.remove();
		})
		// Add note
		.on('click', '[data-action=add-note]', function(e){
			e.preventDefault();
			
			$('[name=note]').removeClass('hidden').focus();
			
			this.remove();
		})
		// Autocomplete | User account
		.on('focus', '.js-user-account', function(e){
			var $this = $(this);
			
			$this.autocomplete({
				serviceUrl: 'ajax/search_users.php',
				minChars: 0,
				params: {
					feature_id: $this.data('id')
				},
				noCache: false,
				beforeRender: function (container) {
					container.addClass('simple');
				},
				onSelect: function(suggestion){
					$('[name=user_id]').val(suggestion.data.id);
					$('.js-user-account').val('');
					$('.order-user-account-box').removeClass('not-registred')
						.find('[target=_blank]').attr({ 
							'href': 'index.php?module=UserAdmin&id=' + suggestion.data.id,
							'title': suggestion.data.name + ', ' + suggestion.data.email
						})
				},
				formatResult: function(suggestions, currentValue){
					var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
					var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
					return suggestions.value.replace(new RegExp(pattern, 'gi'), '<span>$1<\/span>');
				}
			});
		})
		.on('click', '[data-action=remove-user]', function(e){
			e.preventDefault();
			
			$('[name=user_id]').val('');
			
			$('.order-user-account-box').addClass('not-registred')
		});
		
	// Labels
	$formLabels.on('change', 'input', function(){
		$formLabels.find('.js-mark-' + this.value).toggleClass('hidden', !this.checked)
	})

	// Autocomplete | Purchases
	$autocompleteInputPurchases.on('keypress', function(e){
		if (e.keyCode == 13)
			return false;	
	});

	$autocompleteInputPurchases.autocomplete({
		serviceUrl: 'ajax/add_order_product.php',
		showNoSuggestionNotice: true,
		noSuggestionNotice: 'Нет товаров',
		onSelect: function (suggestion) {
			var $newItem = $dummyPurchase.clone();

			$newItem.find('[name^="purchases[price]"]').val(suggestion.data.variants[0].price);

			var $newItemAmound = $newItem.find('[name^="purchases[amount]"]');
			for(var i = 1; i <= suggestion.data.variants[0].stock; i++)
			$newItemAmound.append( $('<option>', {
				'value': i,
				'text': i
			}) )
			
			$newItem.find('.list-name').html( $('<a>', {
				href: 'index.php?module=ProductAdmin&id=' + suggestion.data.id,
				text: suggestion.data.name,
				target: '_blank'
			}) );
			
			if (suggestion.data.image)
			{
				$newItem.find('.list-image').html( 
					$('<a>', {
						href: 'index.php?module=ProductAdmin&id=' + suggestion.data.id,
						text: suggestion.data.name,
						target: '_blank',
						html: $('<img>', {
							src: suggestion.data.image,
							alt: suggestion.data.name
						})
					}) 
				);
			}
			
			$newItem.find('.list-image')
			
			var $newItemVariants = $newItem.find('[name^="purchases[variant_id]"]');
			
			$.each(suggestion.data.variants, function(i, el){
				var sku = suggestion.data.variants[i].sku == '' ? '' : '(арт. ' + suggestion.data.variants[i].sku + ') ';
				
  				$newItemVariants.append( $('<option>', {
					'value': suggestion.data.variants[i].id,
					'text': sku + suggestion.data.variants[i].name,
					'data-price': suggestion.data.variants[i].price,
					'data-amount': suggestion.data.variants[i].stock
				}) )
			})
			
			if(suggestion.data.variants.length < 2 && suggestion.data.variants[0].name == '')
  				$newItemVariants.addClass('hidden');
			
			$('.js-alert-no-purchases').addClass('hidden')
			
			$listPurchases.append($newItem);
			
			$autocompleteInputPurchases.val('').focus();
		},
		formatResult: function(suggestions, currentValue){
			var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
			var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
			return (suggestions.data.image ? '<div class="autocomplete-image"><img src="' + suggestions.data.image + '"></div>' : '') + suggestions.value.replace(new RegExp(pattern, 'gi'), '<span>$1<\/span>');
		}
	});
	
	// Variant change
	$listPurchases
		.on('change', '[name^="purchases[variant_id]"]', function(){
			var $variants = $(this),
				$variant = $variants.find('option:selected'),
				$price = $variants.parent().find('[name^="purchases[price]"]'),
				$amount = $variants.parent().find('[name^="purchases[amount]"]'),
				price = $variant.data('price'),
				amount = $variant.data('amount'),
				current_amount = $amount.val();
				
			$price.val(price);
			
			$amount.empty();
			
			for(var i = 1; i <= amount; i++)
				$amount.append( $('<option>', {
					'value': i,
					'text': i
				}) )

			$amount.val(Math.min(current_amount, amount));
		})
		.on('click', '[data-action=delete]', function(e){
			e.preventDefault();
			
			
			$(this).closest('.list-item').remove();
			
			console.log($listPurchases.find('.list-item').length)
			if(!$listPurchases.find('.list-item').length)
				$('.js-alert-no-purchases').removeClass('hidden')
		});
		
})(window.jQuery);
</script>
{/capture}