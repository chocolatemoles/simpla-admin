{$meta_title = 'Блог' scope=root}

{if $keyword && $posts_count}
	{$page_subtitle = "{$posts_count|plural:'Нашлась':'Нашлись':'Нашлись'} {$posts_count} {$posts_count|plural:'запись':'записей':'записи'}" scope=root}
{elseif $posts_count}
	{$page_subtitle = "{$posts_count} {$posts_count|plural:'запись':'записей':'записи'}" scope=root}
{else}
	{$page_subtitle = 'Нет записей' scope=root}
{/if}

{if $posts}
	{include file='pagination.tpl'}

	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list">
			{foreach $posts as $post}
				<div class="list-item {if !$post->visible} invisible{/if}">
					<input type="hidden" name="positions[{$post->id}]" value="{$post->position}">
					
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$post->id}">
					
					<div class="list-name">
						<a href="index.php?module=PostAdmin&id={$post->id}">{$post->name|escape}</a>
						<br>
						
					</div>
					
					<div class="list-info">
						<p class="list-date">{$post->date|date}</p>
					</div>
					
					<div class="list-actions">
						<a href="../blog/{$post->url}"  class="list-action" data-action="preview" title="Предпросмотр в новом окне" target="_blank"></a>
						<a href="#" class="list-action" data-action="visible" title="Активна"></a>
						<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
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

	{include file='pagination.tpl'}
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green btn-fullwidth" href="index.php?module=PostAdmin">Добавить запись</a>
	
	{include file = 'inc/search.tpl'}
{/capture}