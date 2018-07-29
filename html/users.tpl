{$meta_title = 'Покупатели' scope=root}

{if $keyword}
	{if $users_count > 0}
		{$page_subtitle = "По запросу &laquo;{$keyword}&raquo; найден{$users_count|plural:'':'о':'о'} {$users_count} покупател{$users_count|plural:'ь':'ей':'я'}" scope=root}
	{else}
		{$page_subtitle = "По запросу &laquo;{$keyword}&raquo; покупателей не найдено" scope=root}
	{/if}
{elseif $users_count > 0}
	{$page_subtitle = "{$users_count} покупател{$users_count|plural:'ь':'ей':'я'}" scope=root}
{else}
	{$page_subtitle = "Нет покупателей" scope=root}
{/if}

{if $group}
	{$page_subtitle = $page_subtitle|cat:" в группе &laquo;{$group->name}&raquo;" scope=root}
{/if}

{if $users}
	<div class="action-panel-top">
		{if $sort == 'name'}
		<a href="{url sort=date}" class="action-link">Упорядочить по дате</a>
		{else}
		<a href="{url sort=name}" class="action-link">Упорядочить по имени</a>
		{/if}
	</div>

	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		{include file='pagination.tpl'}
		
		<div class="list">
			{foreach $users as $user}
				<div class="list-item {if !$user->enabled}invisible{/if}">
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$user->id}"/>

					<div class="list-name">
						<a href="index.php?module=UserAdmin&id={$user->id}">{$user->name|escape}</a>
					</div>

					<div class="list-actions">
						<a href="mailto:{$user->email|escape}" class="list-action" data-action="email" title="{$user->email|escape}"></a>
						<a href="#" class="list-action" data-action="enable" title="Активен"></a>
						<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
					</div>
				</div>
			{/foreach}
		</div>

		{include file='pagination.tpl'}
		
		<div class="action-panel">
			<label id="check_all" class="dash_link"></label>

			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="disable">Заблокировать</option>
				<option value="enable">Разблокировать</option>
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет покупателей</p>
{/if}

{capture name = 'sidebar'}
	{if $users_count > 0}
		<form method="post" action="{url module=ExportUsersAdmin}">
			<input type="hidden" name="session_id" value="{$smarty.session.id}">
			<input type="submit" class="btn btn-green" name="export" value="Экспортировать этих покупателей" style="font-size: 12px">
		</form>
	{/if}
	
	{include file = 'inc/search.tpl'}
	
	{if $groups}
		<ul class="sidebar-list">
			<li {if !$group->id} class="selected"{/if}>
				<a href='index.php?module=UsersAdmin'>Все группы</a>
			</li>
			
			{foreach $groups as $g}
				<li {if $group->id == $g->id} class="selected"{/if}>
					<a href="index.php?module=UsersAdmin&group_id={$g->id}">{$g->name}</a>
				</li>
			{/foreach}
		</ul>
	{/if}
{/capture}