{if $post->id}
	{$meta_title = $post->name scope=root}
	{$page_title = 'Редактирование записи' scope=root}
{else}
	{$meta_title = 'Новая запись в блоге' scope=root}
	{$page_title = 'Новая запись в блоге' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Запись добавлена' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Запись обновлена' scope=root}
{elseif $message_error == 'url_exists'}
	{$alert_error = 'Запись с таким адресом уже существует' scope=root}
{/if}

<form method="post" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$post->id|escape}">
	
	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$post->name|escape}">
	</div>

	<div class="form-row">
		<label for="active_checkbox" class="form-label">Активна</label>
		<input type="checkbox" class="form-checkbox" name="visible" id="active_checkbox" value="1" {if $post->visible}checked{/if}>
	</div>

	<div class="form-row">
		<label for="" class="form-label">Дата</label>
		<input type="text" class="form-input js-datepicker" name="date" value="{$post->date|date}" data-width="sm">
	</div>
	
	<hr>
	
	<div class="form-row">
		<label for="" class="form-label">Адрес</label>
		<span class="form-input-box" data-prefix="/blog/">
			<input type="text" class="form-input" name="url" value="{$post->url|escape}">
		</span>
		
		{if $post->url}
		<em class="form-tip"><a target="_blank" href="../blog/{$post->url}">Открыть запись на сайте</a></em>
		{/if}
	</div>

	<div class="form-row">
		<label for="" class="form-label">Заголовок</label>
		<input type="text" class="form-input" name="meta_title" value="{$post->meta_title|escape}">
		<em class="form-tip">title</em>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Ключевые слова</label>
		<input type="text" class="form-input" name="meta_keywords" value="{$post->meta_keywords|escape}">
		<em class="form-tip">meta_keywords</em>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Описание</label>
		<textarea name="meta_description" cols="30" rows="4" class="form-input">{$post->meta_description|escape}</textarea>
		<em class="form-tip">meta_description</em>
	</div>

	<hr>
	
	<p class="block-title">Краткое описание</p>
	<textarea name="annotation" class="js-editor" rows="10">{$post->annotation|escape}</textarea>
	
	<p class="block-title">Полное описание</p>
	<textarea name="body" class="js-editor" rows="30">{$post->text|escape}</textarea>

	<div class="action-panel">
		<input class="btn" type="submit" value="Сохранить">
	</div>
</form>

{capture name = 'scripts'}
<script src="design/js/datepicker/datepicker.min.js"></script>
<link rel="stylesheet" href="design/js/datepicker/datepicker.min.css">
<script>
(function($){
	'use strict';

	// Datepicker
	$('.js-datepicker').datepicker();
	
}(window.jQuery));
</script>
{/capture}