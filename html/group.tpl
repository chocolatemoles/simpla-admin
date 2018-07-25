{if $group->id}
	{$meta_title = $group->name scope=root}
	{$page_title = 'Редактирование группы' scope=root}
{else}
	{$meta_title = 'Новая группа' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Группа добавлена' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Группа изменена' scope=root}
{elseif $message_error == 'empty_name'}
	{$alert_error = 'Название группы не может быть пустым' scope=root}
{/if}

<form method="post" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$group->id|escape}">
	
	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$group->name|escape}" required>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Скидка</label>
		<span class="form-input-box" data-width="xs" data-suffix="%">
			<input type="text" class="form-input" name="discount" value="{$group->discount|escape}">
		</span>
	</div>

	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
	</div>
</form>