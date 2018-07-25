{if $category->id}
	{$meta_title = $category->name scope=root}
	{$page_title = 'Редактирование категории' scope=root}
{else}
	{$meta_title = 'Новая категория' scope=root}
{/if}

{if $message_success=='added'}
	{$alert_success = 'Категория добавлена' scope=root}
{elseif $message_success=='updated'}
	{$alert_success = 'Категория обновлена' scope=root}
{elseif $message_error=='url_exists'}
	{$alert_error = 'Категория с таким адресом уже существует' scope=root}
{elseif $message_error=='name_empty'}
	{$alert_error = 'У категории должно быть название' scope=root}
{elseif $message_error=='url_empty'}
	{$alert_error = 'URl адрес не может быть пустым' scope=root}
{/if}

<form method="post" enctype="multipart/form-data" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$category->id|escape}">

	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$category->name|escape}" required>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Активна</label>
		<input type="checkbox" class="form-checkbox" name="visible" value="1"{if $category->visible} checked{/if} >
	</div>	

	<div class="form-row">
		<label for="" class="form-label">Категория</label>
		<select name="parent_id" class="form-input">
			<option value="0">Корневая категория</option>
			{function name=category_select level=0}
				{foreach $cats as $cat}
					{if $category->id != $cat->id}
						<option value="{$cat->id}" {if $category->parent_id == $cat->id}selected{/if}>
							{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$cat->name}
						</option>
						{category_select cats=$cat->subcategories level=$level+1}
					{/if}
				{/foreach}
			{/function}
			{category_select cats=$categories}
		</select>
	</div>		

	<div class="form-row">
		<label for="" class="form-label">Адрес</label>
		<span class="form-input-box" data-prefix="/catalog/">
			<input type="text" class="form-input" name="url" value="{$category->url|escape}" required>
		</span>
		{if $category->url}
			<em class="form-tip"><a href="../catalog/{$category->url}" target="_blank">Открыть категорию на сайте</a></em>
		{/if}
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Заголовок</label>
		<input type="text" class="form-input" name="meta_title" value="{$category->meta_title|escape}">
		<em class="form-tip">title</em>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Ключевые слова</label>
		<input type="text" class="form-input" name="meta_keywords" value="{$category->meta_keywords|escape}">
		<em class="form-tip">meta_keywords</em>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Описание</label>
		<textarea class="form-input" name="meta_description" rows="4">{$category->meta_description|escape}</textarea>
		<em class="form-tip">meta_description</em>
	</div>

	<hr>

	<p class="block-title">Изображение категории</p>
	
	<div class="form-row">
		<input class="form-input" name="image" type="file" accept="image/*">
	</div>

	{if $category->image}
		<input type="hidden" name="delete_image" value="1" disabled>
	
		<span class="image-box">
			<img src="../{$config->categories_images_dir}{$category->image}" alt=""/>
		</span>

		<a href="#" class="action-link" data-action="delete-image">Удалить изображение</a>
	{/if}
	
	<hr>

	<p class="block-title">Описание</p>
	<textarea name="description" class="js-editor" rows="8">{$category->description|escape}</textarea>
	
	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
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
	})
})(window.jQuery);
</script>
{/capture}