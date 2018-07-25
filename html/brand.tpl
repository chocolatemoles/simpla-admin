{if $brand->id}
	{$meta_title = $brand->name scope=root}
	{$page_title = 'Редактирование бренда' scope=root}
{else}
	{$meta_title = 'Новый бренд' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Бренд добавлен' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Бренд обновлен' scope=root}
{elseif $message_error == 'url_exists'}
	{$alert_error = 'Бренд с таким адресом уже существует' scope=root}
{elseif $message_error == 'name_empty'}
	{$alert_error = 'У бренда должно быть название' scope=root}
{elseif $message_error == 'url_empty'}
	{$alert_error = 'URl адрес не может быть пустым' scope=root}
{/if}

<form method="post" enctype="multipart/form-data" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$brand->id|escape}">

	<div class="form-row">
		<label class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$brand->name|escape}" required>
	</div>

	<hr>
	
	<div class="form-row">
		<label class="form-label">Адрес</label>
		<div class="form-input-box" data-prefix="/brands/">
			<input type="text" class="form-input" name="url" value="{$brand->url|escape}" required>
		</div>
		
		{if $brand->url}
		<em class="form-tip"><a target="_blank" href="../brands/{$brand->url}">Открыть бренд на сайте</a></em>
		{/if}
	</div>

	<div class="form-row">
		<label class="form-label">Заголовок</label>
		<input type="text" class="form-input" name="meta_title" value="{$brand->meta_title|escape}">
		<em class="form-tip">title</em>
	</div>
	
	<div class="form-row">
		<label class="form-label">Ключевые слова</label>
		<input type="text" class="form-input" name="meta_keywords" value="{$brand->meta_keywords|escape}">
		<em class="form-tip">meta_keywords</em>
	</div>
	
	<div class="form-row">
		<label class="form-label">Описание</label>
		<textarea name="meta_description" cols="30" rows="4" class="form-input">{$brand->meta_description|escape}</textarea>
		<em class="form-tip">meta_description</em>
	</div>

	<p class="block-title">Изображение бренда</p>
	
	<div class="form-row">
		<input class="form-input" name="image" type="file" accept="image/*">
	</div>
	
	{if $brand->image}
		<input type="hidden" name="delete_image" value="1" disabled>
	
		<span class="image-box">
			<img src="../{$config->brands_images_dir}{$brand->image}" alt=""/>
		</span>

		<a href="#" class="action-link" data-action="delete-image">Удалить изображение</a>
	{/if}

	
	<p class="block-title">Описание</p>
	<textarea name="description" class="js-editor" rows="10">{$brand->description|escape}</textarea>
	
	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить"/>
	</div>
</form>

{capture name = 'scripts'}
<script>
(function($){
	'use strict';
	
	// Delete image
	$('[data-action=delete-image]').on('click', function(e){
		e.preventDefault();
		
		$('.image-box').remove();
		$(this).remove();
		$('input[name=delete_image]').prop('disabled', false);
	});
	
})(window.jQuery);
</script>
{/capture}