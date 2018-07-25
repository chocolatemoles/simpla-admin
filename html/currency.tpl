{$meta_title='Валюты' scope=root}

<form method="post" autocomplete="off" data-form="currencies">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="recalculate" value="0">
	<input type="hidden" name="action" value="">
	<input type="hidden" name="action_id" value="">

	<div class="list-currencies-titles">
		<span class="list-currencies-title-name">Название валюты</span>
		<span class="list-currencies-title-sign">Знак</span>
		<span class="list-currencies-title-iso">Код ISO</span>
	</div>
		
	<div class="list list-currencies">
		{foreach $currencies as $c}
			<div class="list-item {if !$c->enabled} invisible{/if} {if $c->cents == 2} cents{/if}" data-id="{$c->id}">
				<input name="currency[id][{$c->id}]" type="hidden" value="{$c->id|escape}">
				
				<div class="list-move"></div>

				<input type="text" class="form-input" name="currency[name][{$c->id}]" value="{$c->name|escape}" data-width="sm">
				<input type="text" class="form-input" name="currency[sign][{$c->id}]" value="{$c->sign|escape}" data-width="xs">
				<input type="text" class="form-input" name="currency[code][{$c->id}]" value="{$c->code|escape}" data-width="xs">

				{if !$c@first}
					<span class="form-input-box" data-suffix="{$c->sign}" data-width="sm">
						<input type="text" class="form-input" name="currency[rate_from][{$c->id}]" value="{$c->rate_from|escape}">
					</span>
					
					<label for="" class="form-label" data-width="auto">=</label>
					
					<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
						<input type="text" class="form-input" name="currency[rate_to][{$c->id}]" value="{$c->rate_to|escape}">
					</span>
				{else}
					{$main_currency = $currencies|reset}
					<input type="hidden" name="currency[rate_from][{$c->id}]" value="{$c->rate_from|escape}">
					<input type="hidden" name="currency[rate_to][{$c->id}]" value="{$c->rate_to|escape}">
				{/if}

				<div class="list-actions">
					<a href="#" class="list-action" data-action="cents" title="Выводить копейки"></a>
					<a href="#" class="list-action" data-action="enable" title="Показывать на сайте"></a>
					<a href="#" class="list-action {if $c@first} unseen{/if}" data-action="delete" title="Удалить"></a>
				</div>
			</div>
		{/foreach}
	</div>

	<a href="#" class="action-link" data-action="add-currency" style="margin-left: 36px">Добавить</a>

    <div class="action-panel">
        <input class="btn" type="submit" value="Применить">
    </div>
</form>

<div class="hidden">
	<div class="list-item invisible js-currency-dummy">
		<input type="hidden" name="currency[id][]" value="">

		<input type="text" class="form-input" name="currency[name][]" value="" data-width="sm">
		<input type="text" class="form-input" name="currency[sign][]" value="" data-width="xs">
		<input type="text" class="form-input" name="currency[code][]" value="" data-width="xs">

		<input type="text" class="form-input" name="currency[rate_from][]" value="1" data-width="sm">

		<label for="" class="form-label" data-width="auto">=</label>
		
		<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
			<input type="text" class="form-input" name="currency[rate_to][]" value="1">
		</span>
	</div>
</div>

{capture name = 'scripts'}
<script src="design/js/sortable/sortable.min.js"></script>
<script>
(function($){
	'use strict';
	
	var $form = $('[data-form=currencies]'),
		base_currency_id = {$main_currency->id};
	
	var $currencyDummy = $('.js-currency-dummy');
	
	$('[data-action=add-currency]').on('click', function(e){
		e.preventDefault();

		$('.list').append($currencyDummy.clone()).find('[name^="currency[name]"]').focus();
	});

	// Sort
	Sortable.create(document.getElementsByClassName('list')[0], {
		sort: true,
		handle: '.list-move',
		draggable: '.list-item:not(.js-currency-dummy)',
		forceFallback: true,
		animation: 50
	});
		
	$form
		.on('submit', function(){
			if ($form.find('[name=action]').val() == 'delete' && !confirm('Подтвердите удаление'))
			{
				$form.find('[name=action]').val('');
				$form.find('[name=action_id]').val('');
				$('.loading').removeClass('loading');
				return false;
			}
			
			if (base_currency_id != $('[name^="currency[id]"]:first').val() && confirm('Пересчитать все цены в "' + $('[name^="currency[name]"]:first').val() + '" по текущему курсу?'))
                $('[name=recalculate]').val(1);
		})
		.on('click', '.list-action', function(e){
			e.preventDefault();

			var $link = $(this),
				action = $link.data('action'),
				$listItem = $link.closest('.list-item'),
				id = $listItem.data('id');

			switch(action) {
				// Cents
				case 'cents':
					var state = $listItem.hasClass('cents') ? 0 : 2;
						
					$link.addClass('loading');

					$.ajax({
						type: 'POST',
						dataType: 'json',
						url: 'ajax/update_object.php',
						data: {
							'object': 'currency',
							'id': id,
							'values': {
								'cents': state
							},
							'session_id': '{$smarty.session.id}'
						},
						success: function (data) {
							$link.removeClass('loading');
							$listItem.toggleClass('cents', state);
						}
					});
				break;
				// Enable
				case 'enable':
					var state = $listItem.hasClass('invisible') ? 1 : 0;
						
					$link.addClass('loading');

					$.ajax({
						type: 'POST',
						dataType: 'json',
						url: 'ajax/update_object.php',
						data: {
							'object': 'currency',
							'id': id,
							'values': {
								'enabled': state
							},
							'session_id': '{$smarty.session.id}'
						},
						success: function (data) {
							$link.removeClass('loading');
							$listItem.toggleClass('invisible', state);
						}
					});
				break;
				// Delete
				case 'delete':
					$link.addClass('loading');

					$form.find('[name=action]').val('delete');
					$form.find('[name=action_id]').val(id);

					$form.submit();
				break;
				default:
					return false;
			}
		})
		
})(window.jQuery);
</script>
{/capture}