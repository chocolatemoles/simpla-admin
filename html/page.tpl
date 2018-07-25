{if $page->id}
	{$meta_title = 'Редактирование страницы' scope=root}
{else}
	{$meta_title = 'Новая страница' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Страница добавлена' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Страница обновлена' scope=root}
{elseif $message_error == 'url_exists'}
	{$alert_error = 'Страница с таким адресом уже существует' scope=root}
{/if}

<form method="post" enctype="multipart/form-data" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$page->id|escape}">
	
	<div class="form-row">
		<label class="form-label">Название</label>
		<input class="form-input" type="text" name="header" value="{$page->header|escape}">
	</div>
	
	<div class="form-row">
		<label class="form-label" for="active-checkbox">Активна</label>
		<input class="form-checkbox" type="checkbox" name="visible" value="1" id="active-checkbox" {if $page->visible}checked{/if}/> 
	</div>

	<hr>
	
	<div class="form-row">
		<label class="form-label">Адрес</label>
		
		<span class="form-input-box" data-prefix="/">
			<input class="form-input" type="text" name="url" value="{$page->url|escape}">
		</span>
		
		{if $page->url}
		<em class="form-tip"><a class="alert-link" target="_blank" href="../{$page->url}">Открыть страницу на сайте</a></em>
		{/if}
	</div>

	<div class="form-row">
		<label class="form-label">Заголовок</label>
		<input class="form-input" type="text" name="meta_title" value="{$page->meta_title|escape}">
		<em class="form-tip">title</em>
	</div>

	<div class="form-row">
		<label class="form-label">Ключевые слова</label>
		<input class="form-input" type="text" name="meta_keywords" value="{$page->meta_keywords|escape}">
		<em class="form-tip">meta_keywords</em>
	</div>

	<div class="form-row">
		<label class="form-label">Описание</label>
		<textarea class="form-input" name="meta_description" cols="30" rows="4" >{$page->meta_description|escape}</textarea>
		<em class="form-tip">meta_description</em>
	</div>	

	<hr>
	
	<div class="form-row">
		<label class="form-label">Название пункта в меню</label>
		<input class="form-input" type="text" name="name" value="{$page->name|escape}">
	</div>
	
	<div class="form-row">
		<label class="form-label">Меню</label>
		<select class="form-input" name="menu_id" data-width="md">
			{foreach $menus as $m}
				<option value="{$m->id}" {if $page->menu_id == $m->id}selected{/if}>{$m->name|escape}</option>
			{/foreach}
		</select>
	</div>

	<hr>

	<p class="block-title">Текст страницы</p>
	<textarea name="body" class="js-editor" rows="40">{$page->body|escape}</textarea>

	<div class="action-panel">
		<input class="btn" type="submit" value="Сохранить">
	</div>
</form>