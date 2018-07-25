{$meta_title = 'Менеджеры' scope=root}

{if $message_error=='not_writable'}
	{$alert_error = 'Установите права на запись для файла /simpla/.passwd' scope=root}
{/if}

{$page_subtitle = "{$managers_count} {$managers_count|plural:'менеджер':'менеджеров':'менеджера'}" scope=root}

{if $managers}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list">
			{foreach $managers as $m}
				<div class="list-item">
					<input type="checkbox" name="check[]" class="list-checkbox" value="{$m->login|escape}" {if $manager->login == $m->login} disabled{/if}>

					<div class="list-name">
						<a href="index.php?module=ManagerAdmin&login={$m->login|urlencode}">{$m->login|escape}</a>
					</div>

					<div class="list-actions">
						{if $manager->login != $m->login}
							<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
						{/if}
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
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=ManagerAdmin">Добавить менеджера</a>
{/capture}