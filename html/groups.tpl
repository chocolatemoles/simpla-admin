{$meta_title = 'Группы пользователей' scope=root}

<form method="post" data-form="main">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	
	<div class="list">
		{foreach $groups as $group}
			<div class="list-item">
				<input type="checkbox" class="list-checkbox" name="check[]" value="{$group->id}"/>
				
				<div class="list-name">
					<a href="index.php?module=GroupAdmin&id={$group->id}">{$group->name}</a>
				</div>
				
				<div class="list-discount">{$group->discount} %</div>
				
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

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=GroupAdmin">Добавить группу</a>
{/capture}