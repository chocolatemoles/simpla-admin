{if $status === 0}
{$meta_title = 'Новые заказы' scope=root}
{elseif $status == 1}
{$meta_title = 'Принятые заказы' scope=root}
{elseif $status == 2}
{$meta_title = 'Выполненные заказы' scope=root}
{elseif $status == 3}
{$meta_title = 'Удаленные заказы' scope=root}
{elseif $keyword}
{$meta_title = 'Поиск заказов' scope=root}
{/if}

{$page_subtitle = "{if $orders_count}{$orders_count}{else}Нет{/if} заказ{$orders_count|plural:'':'ов':'а'}" scope=root}

{if $message_error == 'error_closing'}
	{$alert_error = 'Нехватка некоторых товаров на складе' scope=root}
{/if}

{if $orders}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		{include file='pagination.tpl'}
			
		<div class="list list-orders">
			{foreach $orders as $order}
				<div class="list-item {if $order->paid} paid{/if}" data-order="{$order->id}">
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$order->id}">
						
					<div class="list-name">
						<a href="index.php?module=OrderAdmin&id={$order->id}">Заказ №{$order->id}</a>
					</div>
					
					<div class="list-order-date">{$order->date|date} в {$order->date|time}</div>
					<div class="list-order-total">{$order->total_price|convert}&nbsp;{$currency->sign}</div>
					<div class="list-order-customer">{$order->name|escape}</div>

					{if $order->note}
						<div class="list-order-note">{$order->note|escape}</div>
					{/if}
					
					<div class="list-order-labels">
						{foreach $order->labels as $l}
							<span class="list-order-label" style="background-color:#{$l->color};" title="{$l->name}"></span>
						{/foreach}
					</div>
					
					<div class="list-order-paid">{if $order->paid}Оплачен{else}Не оплачен{/if}</div>

					<div class="list-actions">
						<a href="{url module=OrderAdmin id=$order->id view=print}" 
							class="list-action" 
							data-action="print"
							target="_blank" 
							title="Печать заказа"></a>
							
						<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
					</div>

					{if $keyword}
						<div class="list-order-status list-order-status-{$order->status}">
							{if $order->status == 0}
								Новый
							{elseif $order->status == 1}
								Принят
							{elseif $order->status == 2}
								Выполнен
							{elseif $order->status == 3}
								Удален
							{/if}
						</div>
					{/if}
				</div>
			{/foreach}
		</div>

		{include file='pagination.tpl'}
		
		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				{if $status!==0}
					<option value="set_status_0">В новые</option>
				{/if}
				{if $status!==1}
					<option value="set_status_1">В принятые</option>
				{/if}
				{if $status!==2}
					<option value="set_status_2">В выполненные</option>
				{/if}
				{foreach $labels as $l}
					<option value="set_label_{$l->id}">Отметить &laquo;{$l->name}&raquo;</option>
				{/foreach}
				{foreach $labels as $l}
					<option value="unset_label_{$l->id}">Снять &laquo;{$l->name}&raquo;</option>
				{/foreach}
				<option value="delete">Удалить выбранные заказы</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
	
	<form method="post" data-form="set-label">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">
		<input type="hidden" name="check[]" value="">
		{foreach $labels as $l}
			<input type="hidden" name="action" value="">
		{/foreach}
	</form>
{/if}

{capture name = 'sidebar'}	
	<a class="btn btn-green" href="index.php?module=OrderAdmin">Добавить заказ</a>
	
	{include file = 'inc/search.tpl'}
	
	{if $labels}
		<ul class="sidebar-list">
			<li {if !$label}class="selected"{/if}>
				<a href="{url label=null}">Все заказы</a>
			</li>
			
			{foreach $labels as $l}
			<li {if $label->id == $l->id}class="selected"{/if} data-label-id="{$l->id}">
				<span style="background-color:#{$l->color}" class="sidebar-label"></span>
				<a href="{url label=$l->id page=null}">{$l->name}</a>
			</li>
			{/foreach}
		</ul>
	{/if}
{/capture}

{capture name = 'scripts'}
<script src="design/js/jquery.form.min.js"></script>
<script>
(function($){
	'use strict';
	
	var $formMain = $('[data-form=main]');
	var $formSetLabel = $('[data-form=set-label]');
	
	$('.list-order-labels-list a').click(function(e){
		e.preventDefault();
		
		var $link = $(this),
			order_id = $link.data('order-id'),
			label_id = $link.data('label-id'),
			label_color = $link.data('label-color'),
			label_name = $link.data('label-name');

		
		$formSetLabel.find('[name^=check]').val(order_id);
		$formSetLabel.find('[name=action]').val('set_label_' + label_id);

		$formSetLabel.ajaxSubmit({
			success: function(){
				$link.remove()
				$formMain
					.find('[data-order=' + order_id + ']')
					.find('.list-order-labels')
					.append('<span class="list-order-label" style="background-color:#' + label_color + '" title="' + label_name +'"></span>')
			}
		});
	})
	
})(window.jQuery);
</script>
{/capture}