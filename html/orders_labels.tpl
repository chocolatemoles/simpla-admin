{$meta_title = 'Метки заказов' scope=root}

{if $labels}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">
		
		<div class="list with-move">
			{foreach $labels as $label}
				<div class="list-item">
					<div class="list-label" style="background-color: #{$label->color}" title="{$label->name|escape}"></div>
				
					<input type="hidden" name="positions[{$label->id}]" value="{$label->position}">

					<div class="list-move"></div>
					
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$label->id}">
					
					<div class="list-name">
						
						<a href="index.php?module=OrdersLabelAdmin&id={$label->id}">{$label->name|escape}</a>
					</div>
					
					<div class="list-actions">
						<a href="#" class="list-action" title="Удалить" data-action="delete"></a>
					</div>
				</div>
			{/foreach}
		</div>

		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
{else}
	{$alert = 'Нет меток' scope=root}
{/if}

{capture name = 'sidebar'}
	<a href="index.php?module=OrdersLabelAdmin" class="btn btn-green">Новая метка</a>
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