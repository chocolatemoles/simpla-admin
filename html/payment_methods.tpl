{$meta_title = 'Способы оплаты' scope=root}

<form method="post" data-form="main">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">

	<div class="list with-move">
		{foreach $payment_methods as $payment_method}
			<div class="list-item {if !$payment_method->enabled} invisible{/if}">
				<input type="hidden" name="positions[{$payment_method->id}]" value="{$payment_method->position}">

				<div class="list-move"></div>
				
				<input type="checkbox" class="list-checkbox" name="check[]" value="{$payment_method->id}">
				
				<div class="list-name">
					<a href="index.php?module=PaymentMethodAdmin&id={$payment_method->id}">{$payment_method->name}</a>
				</div>
				
				<div class="list-actions">
					<a href="#" class="list-action" data-action="enable" title="Активен"></a>
					<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
				</div>
			</div>
		{/foreach}
	</div>

	<div class="action-panel">
		<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

		<select name="action" class="form-input" data-width="auto">
			<option value="enable">Включить</option>
			<option value="disable">Выключить</option>
			<option value="delete">Удалить</option>
		</select>

		<input class="btn" type="submit" value="Применить">
	</div>
</form>

{capture name = 'sidebar'}
    <a class="btn btn-green" href="index.php?module=PaymentMethodAdmin">Добавить способ оплаты</a>
{/capture}

{capture name = 'scripts'}
<script src="design/js/sortable/sortable.min.js"></script>
<script src="design/js/jquery.form.min.js"></script>
<script>
(function($){
	'use strict';
	
	var $form = $('[data-form=main]');
	
	Sortable.create(document.getElementsByClassName('list')[0], {
		sort: true,
		handle: '.list-move',
		draggable: '.list-item',
		forceFallback: true,
		animation: 50,
		onChoose: function(){
			$form.find('input[type=checkbox]').prop('checked', false);
		},
		onEnd: function () {
			$form.ajaxSubmit();	
		}
	});
	
})(window.jQuery);
</script>
{/capture}