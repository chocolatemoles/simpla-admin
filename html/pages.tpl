{$meta_title = {$menu->name} scope=root}
{$page_title = 'Страницы' scope=root}

{if $pages}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">
		
		<div class="list with-move">
			{foreach $pages as $page}
				<div class="list-item {if !$page->visible} invisible{/if}">
					<input type="hidden" name="positions[{$page->id}]" value="{$page->position}">
					
					<div class="list-move"></div>
						
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$page->id}">

					<div class="list-name">
						<a href="index.php?module=PageAdmin&id={$page->id}&menu_id={$smarty.get.menu_id}">{$page->header|escape}</a>
					</div>
						
					<div class="list-actions">
						<a href="../{$page->url}" class="list-action" title="Предпросмотр в новом окне" target="_blank" data-action="preview"></a>
						<a href="#" class="list-action" title="Активна" data-action="visible"></a>
						<a href="#" class="list-action" title="Удалить" data-action="delete"></a>
					</div>
				</div>
			{/foreach}
		</div>

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
	<p class="alert">Нет страниц</p>
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=PageAdmin&menu_id={$smarty.get.menu_id}">Добавить страницу</a>
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
		
})(window.jQuery);
</script>
{/capture}