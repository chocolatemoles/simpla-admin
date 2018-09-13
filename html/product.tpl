{if $product->id}
	{$meta_title = $product->name scope=root}
	{$page_title = 'Редактирование товара' scope=root}
{else}
	{$meta_title = 'Новый товар' scope=root}
{/if}

{if $message_success=='added'}
	{$alert_success = 'Товар добавлен' scope=root}
{elseif $message_success=='updated'}
	{$alert_success = 'Товар изменен' scope=root}
{elseif $message_error=='url_exists'}
	{$alert_error = 'Товар с таким адресом уже существует' scope=root}
{elseif $message_error=='empty_name'}
	{$alert_error = 'Введите название' scope=root}
{/if}

<form method="post" enctype="multipart/form-data" autocomplete="off" data-form="product">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$product->id|escape}">

	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$product->name|escape}" required>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Активен</label>
		<input type="checkbox" class="form-checkbox" name="visible" value="1" {if $product->visible} checked{/if}>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Рекомендуемый</label>
		<input type="checkbox" class="form-checkbox" name="featured" value="1" {if $product->featured} checked{/if}>
	</div>
	
	<div class="form-row {if !$brands} hidden{/if}">
		<label for="" class="form-label">Бренд</label>
		<select name="brand_id" class="form-input">
			<option value="0" data-name="" {if !$product->brand_id} selected{/if}>Не указан</option>
			{foreach $brands as $brand}
				<option value="{$brand->id}" data-name="{$brand->name|escape}" {if $product->brand_id == $brand->id} selected{/if}>{$brand->name|escape}</option>
			{/foreach}
		</select>
	</div>

	<!-- Categories -->
	<div class="form-row {if !$categories} hidden{/if}">
		<label for="" class="form-label">Категория</label>
		
		{function name=select_categories level=0}
			{foreach $categories as $category}
				<option value="{$category->id}" {if $category->id == $selected_id} selected{/if} data-name="{$category->name|escape}">{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$category->name|escape}</option>
				{select_categories categories=$category->subcategories selected_id=$selected_id level=$level+1}
			{/foreach}
		{/function}
		
		<span class="product-categories-box">
			{foreach $product_categories as $product_category}
				<span class="product-categories-row">
					{* fix obsen bug *}
					{if $product_category->category_id}
						{$selected_id = $product_category->category_id}
					{else}
						{$selected_id = $product_category->id}
					{/if}

					<select name="categories[]" class="form-input">
						{select_categories categories=$categories selected_id=$selected_id}
					</select>

					<a href="#" class="action-link gray {if $product_category@first} hidden{/if}" data-action="delete-category">Удалить</a>
				</span>
			{/foreach}
		</span>
	</div>

	<div class="form-row {if !$categories} hidden{/if}">
		<label for="" class="form-label">&nbsp;</label>
		<a href="#" class="action-link green" data-action="add-category">Добавить категорию</a>
	</div>
	
	<hr>
	
	<!-- Variants -->
	<p class="block-title">Варианты товара</p>
	
	<div class="product-variants-box">
		{assign first_variant $product_variants|first}
		<div class="list js-list-variants {if $product_variants|count <= 1 && !$first_variant->name} single-variant{/if}" >
			<div class="product-variants-titles">
				<span data-width="sm">Название варианта</span>
				<span data-width="sm">Артикул</span>
				<span data-width="sm">Цена</span>
				<span data-width="sm">Старая цена</span>
				<span data-width="xs">Кол-во</span>
			</div>
			
			{foreach $product_variants as $variant}
				<div class="list-item">
					<input type="hidden" name="variants[id][]" value="{$variant->id|escape}">
				
					<div class="list-move"></div>

					<input type="text" class="form-input colored" name="variants[name][]" value="{$variant->name|escape}" data-width="sm">
					<input type="text" class="form-input colored" name="variants[sku][]" value="{$variant->sku|escape}" data-width="sm">
					
					<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
						<input type="text" class="form-input colored text-right" name="variants[price][]" value="{$variant->price|escape}">
					</span>
					
					<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
						<input type="text" class="form-input colored text-right" name="variants[compare_price][]" value="{$variant->compare_price|escape}">
					</span>
					
					<span class="form-input-box" data-suffix="{$settings->units}" data-width="xs">
						<input type="text" class="form-input colored" name="variants[stock][]" value="{if $variant->infinity || $variant->stock == ''}∞{else}{$variant->stock|escape}{/if}">
					</span>

					{if $variant->attachment}
						<div class="list-variant-attachment">
							<p class="list-variant-attachment-label">Цифорвой товар:</p>
							<p class="list-variant-attachment-name">{$variant->attachment}</p>
							<a href="#" class="action-link gray" data-action="delete-attachment">Удалить цифровой товар</a>
						</div>
					{/if}

					<div class="list-variant-attachment-upload hidden">
						<p class="list-variant-attachment-label">Цифорвой товар:</p>
						<input type="file" name="attachment[]">
						<input type="hidden" name="delete_attachment[]">
					</div>
				
					<div class="list-actions">
						<a href="#" class="list-action {if $variant->attachment} unseen{/if}" data-action="add-attachment" title="Добавить цифровой товар"></a>
						<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
					</div>
				</div>
			{/foreach}
		</div>
		
		<a href="#" class="action-link green" data-action="add-variant">Добавить вариант</a>
	</div>
	
	<hr>
	
	<!-- SEO stuff -->
	<p class="block-title">Параметры страницы</p>
	
	<div class="form-row">
		<label for="" class="form-label">Адрес</label>
		
		<span class="form-input-box" data-prefix="/products/">
			<input type="text" class="form-input" name="url" value="{$product->url|escape}" required>
		</span>
		
		{if $product->url}
		<em class="form-tip"><a target="_blank" href="../products/{$product->url}">Открыть товар на сайте</a></em>
		{/if}
	</div>

	<div class="form-row">
		<label for="" class="form-label">Заголовок</label>
		<input type="text" class="form-input" name="meta_title" value="{$product->meta_title|escape}">
		<em class="form-tip">title</em>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Ключевые слова</label>
		<input type="text" class="form-input" name="meta_keywords" value="{$product->meta_keywords|escape}">
		<em class="form-tip">meta_keywords</em>
	</div>

	<div class="form-row">
		<label for="" class="form-label">Описание</label>
		<textarea name="meta_description" cols="30" rows="5" class="form-input">{$product->meta_description|escape}</textarea>
		<em class="form-tip">meta_description</em>
	</div>	

	<!-- Tabs -->
	<div class="tabs">
		<div class="tabs-nav">
			<button type="button" class="tabs-btn active" data-target="images">Изображения товара</button>
			<button type="button" class="tabs-btn {if !$categories} hidden{/if}" data-target="features">Свойства товара</button>
			<button type="button" class="tabs-btn" data-target="related-products">Связанные товары</button>
		</div>

		<div class="tabs-content">
			<div class="tabs-tab active" data-content="images">
				<!-- Tabs / Images -->
				<div class="product-images-grid clearfix">
					{foreach $product_images as $image}
					<div class="product-image">
						<input type="hidden" name="images[]" value="{$image->id}">
						<a href="#" class="product-image-delete" title="Удалить"></a>
						<img src="{$image->filename|resize:100:100}" alt="">
					</div>
					{/foreach}
					
					<div class="product-images-dropzone-box">
						<input type="file" name="dropped_images[]" class="product-images-dropinput" accept="image/*" title="Загрузить изображние" multiple>
					</div>
				</div>
			</div>
			
			<div class="tabs-tab {if !$categories} hidden{/if}" data-content="features">
				<!-- Tabs / Features -->
				<div class="product-features-titles">
					<span class="form-label" data-width="md">Название</span>
					<span class="form-label">Значение</span>
				</div>
				
				<div class="js-product-features">
					{foreach $features as $feature}
						{assign feature_id $feature->id}
						<div class="form-row">
							<label class="form-label" data-width="md">{$feature->name}</label>
							<input type="text" class="form-input colored" name="options[{$feature_id}]" value="{$options.$feature_id->value|escape}" data-id="{$feature_id}">
						</div>
					{/foreach}
				</div>
				
				<a href="#" class="action-link green" data-action="add-feature">Добавить новое свойство</a>
			</div>

			<div class="tabs-tab" data-content="related-products">
				<!-- Tabs / Related products -->

				<div class="list list-related-products">
					{foreach $related_products as $related_product}
						<div class="list-item">
							<input type="hidden" name="related_products[]" value="{$related_product->id}">
						
							<div class="list-move"></div>

							<div class="list-image">
								<a href="index.php?module=ProductAdmin&id={$related_product->id}" target="_blank">
									<img class="product_icon" src="{$related_product->images[0]->filename|resize:35:35}">
								</a>
							</div>
							
							<div class="list-name">
								<a href="index.php?module=ProductAdmin&id={$related_product->id}" target="_blank">{$related_product->name}</a>
							</div>
							
							<div class="list-actions">
								<a href="#" class="list-action" data-action="delete"></a>
							</div>
						</div>
					{/foreach}
				</div>
				
				<input type="text" class="form-input colored js-autocomplete-related" placeholder="Введите название товара и выберите его из списка">
			</div>
		</div>
	</div>

	<p class="block-title">Краткое описание</p>
	<textarea name="annotation" class="js-editor" cols="30" rows="5">{$product->annotation|escape}</textarea>

	<p class="block-title">Полное описание</p>
	<textarea name="body" class="js-editor" cols="30" rows="15">{$product->body|escape}</textarea>

	<div class="action-panel">
		<input class="btn" type="submit" name="save" value="Сохранить">
	</div>
</form>

<div class="hidden">
	<!-- Dummy / Categories -->
	{function name=select_categories_dummy level=0}
		{foreach $categories as $category}
			<option value="{$category->id}" data-name="{$category->name|escape}">{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$category->name|escape}</option>
			{select_categories_dummy categories=$category->subcategories level=$level+1}
		{/foreach}
	{/function}
	<span class="product-categories-row js-dummy-categories">
		<select name="categories[]" class="form-input">
			{select_categories_dummy categories=$categories level=0}
		</select>
		
		<a href="#" class="action-link gray" data-action="delete-category">Удалить</a>
	</span>
	
	<!-- Dummy / Variant -->
	<div class="list-item js-dummy-variant">
		<input type="hidden" name="variants[id][]" value="">
	
		<div class="list-move"></div>

		<input type="text" class="form-input colored" name="variants[name][]" value="" data-width="sm">
		<input type="text" class="form-input colored" name="variants[sku][]" value="" data-width="sm">
		
		<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
			<input type="text" class="form-input colored text-right" name="variants[price][]" value="">
		</span>
		
		<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
			<input type="text" class="form-input colored text-right" name="variants[compare_price][]" value="">
		</span>
		
		<span class="form-input-box" data-suffix="{$settings->units}" data-width="xs">
			<input type="text" class="form-input colored" name="variants[stock][]" value="∞">
		</span>

		<div class="list-variant-attachment-upload hidden">
			<p class="list-variant-attachment-label">Цифорвой товар:</p>
			<input type="file" name="attachment[]">
			<input type="hidden" name="delete_attachment[]">
		</div>
	
		<div class="list-actions">
			<a href="#" class="list-action" data-action="add-attachment" title="Добавить цифровой товар"></a>
			<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
		</div>
	</div>

	<!-- Dummy / Feature -->
	<div class="form-row js-dummy-feature">
		<input type="text" class="form-input colored" name="new_features_names[]" data-width="md">
		<input type="text" class="form-input colored" name="new_features_values[]">
	</div>
	
	<!-- Dummy / Related product -->
	<div class="list-item js-dummy-related-product">
		<input type="hidden" name="related_products[]" value="">
	
		<div class="list-move"></div>
		<div class="list-image"></div>
		<div class="list-name"></div>
		
		<div class="list-actions">
			<a href="#" class="list-action" data-action="delete"></a>
		</div>
	</div>
</div>					

{capture name = 'styles'}
<link href="design/js/autocomplete/autocomplete.css" rel="stylesheet">
<link href="design/js/tabs/tabs.css" rel="stylesheet">
{/capture}

{capture name = 'scripts'}
<script src="design/js/autocomplete/jquery.autocomplete.min.js"></script>
<script src="design/js/sortable/sortable.min.js"></script>
<script src="design/js/tabs/tabs.js"></script>

<script>
(function($){
	'use strict';
	
	var $form = $('[data-form=product]');
	var $listVariants = $('.js-list-variants');
	var $listRelated = $('.list-related-products');

	var $dummyCalegories = $('.js-dummy-categories').removeClass('js-dummy-categories');
	var $dummyVariant 	 = $('.js-dummy-variant').removeClass('js-dummy-variant');
	var $dummyFeature 	 = $('.js-dummy-feature').removeClass('js-dummy-feature');
	var $dummyRelated 	 = $('.js-dummy-related-product').removeClass('js-dummy-related-product');

	$form
		.on('click', '.action-link', function(e){
			e.preventDefault();

			var $link = $(this),
				action = $link.data('action');

			switch(action) {
				// Add category
				case 'add-category':
					$('.product-categories-box').append($dummyCalegories.clone())
					break;
				// Remove category
				case 'delete-category':
					$link.parent('.product-categories-row').remove();
					break;
				// Add variant
				case 'add-variant':
					var count = $listVariants.find('.list-item').length;
					
					if($listVariants.hasClass('single-variant'))
						$listVariants.removeClass('single-variant').find('input[name^="variants[name]"]').focus();
					else
						$listVariants.append($dummyVariant.clone()).find('input[name^="variants[name]"]').focus()
					
					break;
				// Add feature
				case 'add-feature':
					$('.js-product-features').append($dummyFeature.clone()).find('input[name^=new_features_name]').focus()
					break;
			}
		});

	// Variants
	$listVariants
		.on('click', '.action-link', function(e){
			e.preventDefault();

			var $link = $(this),
				action = $link.data('action');
			
			switch(action) {
				// Remove attachment
				case 'delete-attachment':
					var $listItem = $link.parents('.list-item');

					$listItem.find('[data-action=add-attachment]').removeClass('unseen');
					$listItem.find('[name^=delete_attachment]').val('1');
					$link.parent().remove();
					break;
			}
		})
		.on('click', '.list-action', function(e){
			e.preventDefault();

			var $link = $(this),
				$listItem = $link.parents('.list-item'),
				action = $link.data('action');

			switch(action) {
				// Add attachment
				case 'add-attachment':
					$link.addClass('unseen')
					$listItem
						.find('.list-variant-attachment-upload').removeClass('hidden')
						.find('input').click();
					break;
				// Delete variant
				case 'delete':
					var count = $listVariants.find('.list-item').length;
					
					if(count == 1)
						$listVariants.addClass('single-variant').find('input[name^="variants[name]"]').val('');
					else
						$listItem.remove();

					break;
			}
			
		})
		.on('focus', 'input[name^="variants[stock]"]', function(){
			if(this.value == '∞')
				this.value = '';
		})
		.on('blur', 'input[name^="variants[stock]"]', function(){
			if(this.value == '')
				this.value = '∞';
		});

	// Sort | Variants
	Sortable.create(document.querySelector('.js-list-variants'), {
		sort: true,
		handle: '.list-move',
		draggable: '.list-item',
		animation: 50,
	});
	
	// Related products
	$listRelated
		.on('click', '[data-action=delete]', function(e){
			e.preventDefault();

			var $link = $(this),
				$listItem = $link.parents('.list-item');
				
				$listItem.remove();
		})
	
	// Sort | Related products
	Sortable.create(document.querySelector('.list-related-products'), {
		sort: true,
		handle: '.list-move',
		draggable: '.list-item',
		animation: 50,
	});
	
	// Images
	var $imagesGrid = $('.product-images-grid');
	var $imagesDropInput = $('.product-images-dropinput');
	var $imagesDropZone = $('.product-images-dropzone-box');
	
	$imagesGrid.on('click', '.product-image-delete', function(e){
		e.preventDefault();
		
		$(this).parent().remove();
	});
	
	$imagesDropInput.on('change', function(e){
		var files = e.target.files; 
		
		$.each(files, function(i, file){
			if(!file.type.match('image.*'))
				return;
			
			var reader = new FileReader();
			
			reader.onload = (function(f){
				return function(ev){
					var $image = $('<div>', {
						'class': 'product-image',
						'html': [
							$('<input>', {
								'name': 'images_urls[]',
								'type': 'hidden',
								'value': f.name
							}),
							$('<a>', {
								'href': '#',
								'class': 'product-image-delete',
								'title': 'Удалить'
							}),
							$('<img>', {
								'src': ev.target.result
							})
						]
					});

					$image.insertBefore($imagesDropZone)
				}
			})(file);
			
			reader.readAsDataURL(file);
		})
	});
	
	$(document)
		.on('dragover', function(){ 
			$imagesDropZone.addClass('highlight')
		})
		.on('dragleave drop', function(){ 
			$imagesDropZone.removeClass('highlight')
		});

	// Sort / Images
	Sortable.create(document.querySelector('.product-images-grid'), {
		sort: true,
		draggable: '.product-image',
		animation: 50,
	});

	// Autocomplete | Related products
	var $autocompleteInputRelated = $('.js-autocomplete-related');
	
	$autocompleteInputRelated.on('keypress', function(e){
		if (e.keyCode == 13)
			return false;	
	});

	$autocompleteInputRelated.autocomplete({
		serviceUrl: 'ajax/search_products.php',
		showNoSuggestionNotice: true,
		noSuggestionNotice: 'Нет товаров',
		onSelect: function (suggestion) {
			var $newItem = $dummyRelated.clone();

			$newItem.find('[name^=related_products]').val(suggestion.data.id);
			$newItem.find('.list-name').html( $('<a>', {
				href: 'index.php?module=ProductAdmin&id=' + suggestion.data.id,
				text: suggestion.data.name,
				target: '_blank'
			}) );
			
			if (suggestion.data.image)
			{
				$newItem.find('.list-image').html( 
					$('<a>', {
						href: 'index.php?module=ProductAdmin&id=' + suggestion.data.id,
						text: suggestion.data.name,
						target: '_blank',
						html: $('<img>', {
							src: suggestion.data.image,
							alt: suggestion.data.name
						})
					}) 
				);
			}
			
			$listRelated.append($newItem);
			
			$autocompleteInputRelated.val('').focus();
		},
		formatResult: function(suggestions, currentValue){
			var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
			var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
			return (suggestions.data.image ? '<div class="autocomplete-image"><img src="' + suggestions.data.image + '"></div>' : '') + suggestions.value.replace(new RegExp(pattern, 'gi'), '<span>$1<\/span>');
		}
	});

	// Autocomplete | Features
	$form.on('focus', '[name^=options]', function(e){
		var $this = $(this);
		
		$this.autocomplete({
			serviceUrl: 'ajax/options_autocomplete.php',
			minChars: 0,
			params: {
				feature_id: $this.data('id')
			},
			noCache: false,
			beforeRender: function (container) {
				container.addClass('simple');
			},
			formatResult: function(suggestions, currentValue){
				var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
				var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
				return suggestions.value.replace(new RegExp(pattern, 'gi'), '<span>$1<\/span>');
			}
		});
	});
	
	$('select[name="categories[]"]:first').change(function () {
		$('.js-product-features').empty();
		
		$.ajax({
			url: "ajax/get_features.php",
			data: {
				category_id: $(this).find('option:selected').val(),
				product_id: '{$product->id}'
			},
			dataType: 'json',
			success: function (data) {
				for (var i = 0; i < data.length; i++) {
					var feature = data[i];

					$('<div>', {
						'class': 'form-row',
						'html': [
							$('<label>', {
								'class': 'form-label',
								'data-width': 'md',
								'text': feature.name,
							}),
							$('<input>', {
								'type': 'text',
								'class': 'form-input colored',
								'name': 'options[' + feature.id + ']',
								'data-id': feature.id,
								'value': feature.value,
							}),
						]
					}).appendTo('.js-product-features');
				}
			}
		});
	});
	
})(window.jQuery);
</script>
{/capture}