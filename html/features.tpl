{$meta_title = 'Свойства' scope=root}

{if $features}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list with-move">
			{foreach $features as $feature}
				<div class="list-item {if $feature->in_filter} in_filter{/if}">
					<input type="hidden" name="positions[{$feature->id}]" value="{$feature->position}">
					
					<div class="list-move"></div>

					<input type="checkbox" class="list-checkbox" name="check[]" value="{$feature->id}">
					
					<div class="list-name">
						<a href="index.php?module=FeatureAdmin&id={$feature->id}">{$feature->name|escape}</a>
					</div>
					
					<div class="list-actions">
						<a href="#" class="list-action" title="Использовать в фильтре"  data-action="in_filter"></a>
						<a href="#" class="list-action" title="Удалить" data-action="delete"></a>
					</div>
				</div>
			{/foreach}
		</div>

		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="set_in_filter">Использовать в фильтре</option>
				<option value="unset_in_filter">Не использовать в фильтре</option>
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет свойств</p>
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=FeatureAdmin">Добавить свойство</a>
	
	{function name=categories_tree}
		{if $categories}
			<ul>
				{foreach $categories as $c}
					<li {if $category->id == $c->id}class="selected"{/if}><a
							href="index.php?module=FeaturesAdmin&category_id={$c->id}">{$c->name}</a></li>
					{categories_tree categories=$c->subcategories}
				{/foreach}
			</ul>
		{/if}
	{/function}
	
	<ul class="sidebar-list">
		<li {if !$category->id}class="selected"{/if}><a href="{url category_id=null}">Все категории</a></li>
		{foreach $categories as $c}
			<li {if $category->id == $c->id}class="selected"{/if}>
				<a href="index.php?module=FeaturesAdmin&category_id={$c->id}">{$c->name}</a>
			</li>
			{categories_tree categories=$c->subcategories}
		{/foreach}
	</ul>
{/capture}

{capture name = 'scripts'}
<script src="design/js/sortable/sortable.min.js"></script>
<script src="design/js/jquery.form.min.js"></script>
<script>
(function($){
	'use strict';
	
	var $form = $('[data-form=main]');
	
	Sortable.create(document.querySelector('.list'), {
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
	
	$('[data-action=in_filter]').on('click', function (e) {
		e.preventDefault();

		var $link = $(this),
			action = $link.data('action'),
			$listItem = $link.closest('.list-item'),
			id = $listItem.find('input[type=checkbox]').val(),
			state = $listItem.hasClass('in_filter') ? 0 : 1;
			
		$link.addClass('loading');
		
		$.ajax({
			type: 'POST',
			url: 'ajax/update_object.php',
			data: {
				'object': 'feature',
				'id': id,
				'values': {
					'in_filter': state
				},
				'session_id': backend.session_id
			},
			success: function (data) {
				$link.removeClass('loading');
				$listItem.toggleClass('in_filter', state);
			},
			dataType: 'json'
		});
	});
	
})(window.jQuery);
</script>
{/capture}