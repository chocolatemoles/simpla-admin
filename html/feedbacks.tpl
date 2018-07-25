{$meta_title = 'Обратная связь' scope=root}

{if $feedbacks_count}
	{$page_subtitle = "{$feedbacks_count} {$feedbacks_count|plural:'сообщение':'сообщений':'сообщения'}" scope=root}
{/if}	

{if $feedbacks}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		{include file='pagination.tpl'}
		
		<div class="list">
			{foreach $feedbacks as $feedback}
				<div class="list-item">
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$feedback->id}"/>
					
					<div class="list-name">{$feedback->name|escape}</div>
					
					<div class="list-comment-text">{$feedback->message|escape|nl2br}</div>
					
					<div class="list-cometnt-source">
						<a href="mailto:{$feedback->name|escape}<{$feedback->email|escape}>?subject=Вопрос от пользователя {$feedback->name|escape}">{$feedback->email|escape}</a>
					</div>
						
					<div class="list-comment-date">{$feedback->date|date} в {$feedback->date|time}</div>

					<div class="list-actions">
						<a href="#" class="list-action" title="Удалить" data-action="delete"></a>
					</div>
				</div>
			{/foreach}
		</div>

		{include file='pagination.tpl'}
		
		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="delete">Удалить</option>
			</select>

			<input type="submit" class="btn" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет сообщений</p>
{/if}

{capture name = 'sidebar'}
	{include file = 'inc/search.tpl'}
{/capture}