{$meta_title = 'Выбор темы' scope=root}

{if $message_error == 'permissions'}
	{$alert_error = "Установите права на запись для папки {$themes_dir}" scope=root}
{elseif $message_error == 'name_exists'}
	{$alert_error = 'Тема с таким именем уже существует' scope=root}
{/if}

{$page_subtitle = "Текущая тема &mdash; {$theme->name}" scope=root}

<form method="post" autocomplete="off" data-form="themes">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="action">
	<input type="hidden" name="theme">

	<div class="themes-list">
		{foreach $themes as $t}
			<div class="theme-item {if $theme->name == $t->name} selected {/if} {if $t->locked} locked{/if}" data-theme="{$t->name|escape}">
				<input type="hidden" name="old_name[]" value="{$t->name|escape}" disabled>
				<input type="text" name="new_name[]" class="form-input theme-name" value="{$t->name|escape}" disabled>
				
				<div class="theme-preview {if $theme->name != $t->name} selectable{/if}"
					 style="background-image: url({$root_dir}/design/{$t->name}/preview.png)"
					 title="{if $theme->name == $t->name}Текущая тема{else}Выбрать{/if}"></div>

				<div class="theme-actions">
					{if $t->locked}
						<span class="theme-action" data-action="locked" title="Тема защищена от изменений"></span>
					{else}
						<a href="#" class="theme-action" data-action="rename" title="Переименовать"></a>
						<a href="#" class="theme-action" data-action="delete" title="Удалить"></a>
					{/if}
				</div>
			</div>
		{/foreach}
	</div>

	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
	</div>
</form>

{capture name = 'sidebar'}
	<form method="post">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">
		<input type="hidden" name="action" value="clone_theme">

		<input type="submit" class="btn btn-green" value="Создать копию текущей темы">
	</form>
{/capture}

{capture name = 'scripts'}
<script>
(function($){
	'use strict';
	
	var $form = $('[data-form=themes]'),
		$formAction = $form.find('[name=action]'),
		$formTheme = $form.find('[name=theme]');
	
	$form
		.on('click', '[data-action=rename]', function(e){
			e.preventDefault();
			$formAction.val('')
			$(this).closest('.theme-item').find('input').prop('disabled', false).focus()
		})
		.on('click', '.selectable', function(e){
			e.preventDefault();
			$formAction.val('set_main_theme');
			$formTheme.val( $(this).closest('.theme-item').data('theme') );
			$form.submit();
		})
		.on('click', '[data-action=delete]', function(e){
			e.preventDefault();
			$formAction.val('delete_theme');
			$formTheme.val( $(this).closest('.theme-item').data('theme') );
			$form.submit();
		})
		.submit(function () {
			if ($formAction.val() == 'delete_theme' && !confirm('Подтвердите удаление'))
			{
				$formAction.val('')
				return false;
			}
		});
		
})(window.jQuery);
</script>
{/capture}