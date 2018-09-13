{$meta_title='Доставка' scope=root}

<form method="post" data-form="main">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">

	<div class="list with-move">
		{foreach $deliveries as $delivery}
			<div class="list-item {if !$delivery->enabled} invisible{/if}">
				<input type="hidden" name="positions[{$delivery->id}]" value="{$delivery->position}">
				
				<div class="list-move"></div>
				
				<input type="checkbox" class="list-checkbox" name="check[]" value="{$delivery->id}">
				
				<div class="list-name">
					<a href="index.php?module=DeliveryAdmin&id={$delivery->id}">{$delivery->name|escape}</a>
				</div>
				
				<div class="list-actions">
					<a href="#" class="list-action" title="Активен" data-action="enable"></a>
					<a href="#" class="list-action" title="Удалить" data-action="delete"></a>
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
	<a class="btn btn-green" href="{url module=DeliveryAdmin}">Добавить способ доставки</a>
{/capture}

{capture name = 'scripts'}
<script src="design/js/sortable/sortable.min.js"></script>
<script src="design/js/jquery.form.min.js"></script>
<script>
(function($){
	'use strict';

	var $form = $('[data-form=main]');
	
	Sortable.create(document.getElementsByClassName('list')[0], {
		handle: '.list-move',
		draggable: '.list-item',
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