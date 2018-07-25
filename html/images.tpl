{$meta_title = 'Изображения' scope=root}
{$page_title = "Изображения темы &laquo;{$theme}&raquo;" scope=root}

{if $message_error == 'permissions'}
	{$alert_error = "Установите права на запись для папки {$images_dir}" scope=root}
{elseif $message_error == 'name_exists'}
	{$alert_error = 'Файл с таким именем уже существует' scope=root}
{elseif $message_error == 'theme_locked'}
	{$alert_error = 'Текущая тема защищена от изменений. Создайте копию темы.' scope=root}
{/if}

<form method="post" enctype="multipart/form-data" autocomplete="off" data-form="images">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="delete_image" value="">
	
	{if $images}
		<div class="template-images-grid">
			{foreach $images as $image}
				<div class="template-image-item" data-name="{$image->name|escape}">
					<input type="hidden" name="old_name[]" value="{$image->name|escape}" disabled>
					<input type="text" name="new_name[]" class="form-input template-image-name" value="{$image->name|escape}" disabled>

					<a href="../{$images_dir}{$image->name|escape}" class="template-image-image">
						<img src="../{$images_dir}{$image->name|escape}">
					</a>

					<div class="template-image-properties">
						<div class="template-image-size">
							{if $image->size>1024*1024}
								{($image->size/1024/1024)|round:2} МБ
							{elseif $image->size>1024}
								{($image->size/1024)|round:2} КБ
							{else}
								{$image->size} Байт
							{/if}
						</div>

						<div class="template-image-dimentions">
							{$image->width}&times;{$image->height} px
						</div>
					</div>
					
					{if $message_error != 'theme_locked'}
					<div class="template-image-actions">
						<a href="#" class="template-image-action" data-action="rename" title="Переименовать"></a>
						<a href="#" class="template-image-action" data-action="delete" title="Удалить"></a>
					</div>
					{/if}
				</div>
			{/foreach}
		</div>
	{else}
		<p class="alert">Нет изображений</p>
	{/if}
	
	{if $message_error != 'theme_locked'}
		<hr>
		
		<p class="block-title">Загрузка изображний</p>
		
		<div class="js-images-placeholder">
			<div class="form-row">
				<input type="file" name="upload_images[]" class="form-input" accept="image/*">
			</div>

			<a href="#" class="action-link green" data-action="add-image">Добавить изображение</a>
		</div>
	{/if}
	
	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
	</div>
</form>

{capture name = 'scripts'}
<link rel="stylesheet" href="design/js/mfp/magnific-popup.css">
<script src="design/js/mfp/magnific-popup.min.js"></script>
<script>
(function($){
	'use strict';
	
	var $form = $('[data-form=images]'),
		$formDeleteImage = $form.find('[name=delete_image]');

	$form
		.on('click', '[data-action=rename]', function(e){
			e.preventDefault();
			
			$(this).closest('.template-image-item').find('input').prop('disabled', false).focus()
		})
		.on('click', '[data-action=delete]', function(e){
			e.preventDefault();
			
			$formDeleteImage.val( $(this).closest('.template-image-item').data('name') );
			$form.submit();
		})
		.on('click', '[data-action=add-image]', function(e){
			e.preventDefault();

			$(this).before( $('<div>', {
				'class': 'form-row',
				'html': $('<input>', {
					'type': 'file',
					'name': 'upload_images[]',
					'class': 'form-input',
					'accept': 'image/*'
				})
			}));
		})
		.submit(function () {
			if ($formDeleteImage.val() != '' && !confirm('Подтвердите удаление'))
			{
				$formDeleteImage.val('')
				return false;
			}
		});

	// Popup gallery
	$('.template-image-image').magnificPopup({
		type: 'image',
		gallery:{
			enabled:true
		},
		autoFocusLast: false
	});
	
}(window.jQuery));
</script>
{/capture}