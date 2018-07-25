{$meta_title = 'Категории' scope=root}
{$page_title = 'Категории товаров' scope=root}

{if $categories}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		{function name=categories_tree level=0}
			{if $categories}
				<div class="categories-list">
					{foreach $categories as $category}
						<div class="list-item {if !$category->visible} invisible{/if}">
							<input type="hidden" name="positions[{$category->id}]" value="{$category->position}">
							
							<div class="list-move"></div>
							
							<input type="checkbox" class="list-checkbox" name="check[]" value="{$category->id}">
							
							<div class="list-name">
								<a href="index.php?module=CategoryAdmin&id={$category->id}">{$category->name|escape}</a>
							</div>
							
							<div class="list-actions">
								<a href="../catalog/{$category->url}" class="list-action" data-action="preview" title="Предпросмотр в новом окне" target="_blank"></a>
								<a href="#" class="list-action" data-action="enable" title="Активна"></a>
								<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
							</div>

							{categories_tree categories=$category->subcategories level=$level+1}
						</div>
					{/foreach}
				</div>
			{/if}
		{/function}
		{categories_tree categories=$categories}

		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="enable">Сделать видимыми</option>
				<option value="disable">Сделать невидимыми</option>
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
	
{else}
	<p class="alert">Нет категорий</p>
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=CategoryAdmin">Добавить категорию</a>
{/capture}

{capture name = 'scripts'}
<script src="design/js/sortable/sortable.min.js"></script>
<script src="design/js/jquery.form.min.js"></script>
<script>
(function($){
	'use strict';

	var $form = $('[data-form=main]');
	
	var $lists = document.getElementsByClassName('categories-list');
	
	for (var i = 0; i < $lists.length; ++i) {
		Sortable.create($lists[i], {
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
	}
	
})(window.jQuery);
</script>
{/capture}