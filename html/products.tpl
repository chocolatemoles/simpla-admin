{$meta_title = "Товары{if $brand->name} &laquo;{$brand->name}&raquo;{/if}" scope=root}

{if $filter == 'featured'}
	{$plural_filter = $products_count|plural:'рекомендуемый':'рекомендуемых':'рекомендуемых'}	
{elseif $filter == 'visible'}
	{$plural_filter = $products_count|plural:'активный':'активных':'активных'}	
{elseif $filter == 'hidden'}
	{$plural_filter = $products_count|plural:'неактивный':'неактивных':'неактивных'}	
{elseif $filter == 'outofstock'}
	{$plural_filter = $products_count|plural:'отсутствующий':'отсутствующих':'отсутствующих'}	
{/if}

{if $products_count}
	{if $keyword}
		{$page_subtitle = "По запросу &laquo;{$keyword}&raquo; найден{$products_count|plural:'':'о':'о'} {$products_count} товар{$products_count|plural:'':'ов':'а'}" scope=root}	
	{elseif $filter == 'discounted'}
		{$page_subtitle = "{$products_count} товар{$products_count|plural:'':'ов':'а'} со скидкой" scope=root}	
	{else}
		{$page_subtitle = "{$products_count}{if $plural_filter} {$plural_filter}{/if} товар{$products_count|plural:'':'ов':'а'}" scope=root}	
	{/if}
{else}
	{if $keyword}
		{$page_subtitle = "По запросу &laquo;{$keyword}&raquo; товаров не найдено" scope=root}
	{elseif $filter == 'discounted'}
		{$page_subtitle = "Нет товаров со скидкой" scope=root}	
	{else}
		{$page_subtitle = "Нет{if $plural_filter} {$plural_filter}{/if} товаров" scope=root}	
	{/if}
{/if}

{if $category->name}
	{$page_subtitle = $page_subtitle|cat:" в категории &laquo;{$category->name}&raquo;" scope=root}
{/if}

{if $products}
	<div class="action-panel-top">
		<a href="#" class="action-link hidden" data-action="expand-all-variants">Развернуть все варианты</a>
	</div>
	
	{include file='pagination.tpl'}
	
	<form method="post" autocomplete="off" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list with-move with-image">
		{foreach $products as $product}
			<div class="list-item {if !$product->visible} invisible{/if} {if $product->featured} featured{/if}">
				<input type="hidden" name="positions[{$product->id}]" value="{$product->position}">
				
				<div class="list-move"></div>
				
				<input type="checkbox" class="list-checkbox" name="check[]" value="{$product->id}">

				{$image = $product->images|@first}
				{if $image}
					<a href="index.php?module=ProductAdmin&id={$product->id}" class="list-image">
						<img src="{$image->filename|escape|resize:35:35}">
					</a>
				{/if}
				
				<div class="list-name">
					<a href="index.php?module=ProductAdmin&id={$product->id}">{$product->name|escape}</a>
				</div>

				<div class="list-variants">
					{foreach $product->variants as $variant}
						<div class="list-variant {if !$variant@first} additional-variant{/if}">
							<span class="form-input-box" data-suffix="{$currency->sign}" data-width="sm">
								<input class="form-input colored text-right price{if $variant->compare_price > 0} color-red{/if}" type="text" name="price[{$variant->id}]" value="{$variant->price}" {if $variant->compare_price>0} title="Старая цена &mdash; {$variant->compare_price} {$currency->sign}"{/if}>
							</span>
							
							<span class="form-input-box" data-suffix="{$settings->units}" data-width="xs">
								<input class="form-input colored" type="text" name="stock[{$variant->id}]" value="{if $variant->infinity}∞{else}{$variant->stock}{/if}">
							</span>
							
							<span class="list-variant-name" title="{$variant->name|escape}">{$variant->name|escape}</span>
						</div>
					{/foreach}
					
					{$variants_num = $product->variants|count}
					{if $variants_num > 1}
						<a href="#" class="action-link" data-action="expand-variants">
							<span class="expand">{$variants_num} {$variants_num|plural:'вариант':'вариантов':'варианта'} <i class="icon-angle-down"></i></span>
							<span class="collapse">Свернуть <i class="icon-angle-up"></i></span>
						</a>
					{/if}
				</div>

				<div class="list-actions">
					<a href="../products/{$product->url}" class="list-action" data-action="preview" title="Предпросмотр в новом окне" target="_blank"></a>
					<a href="#" class="list-action" data-action="visible" title="Активен"></a>
					<a href="#" class="list-action" data-action="featured" title="Рекомендуемый"></a>
					<a href="#" class="list-action" data-action="duplicate" title="Дублировать"></a>
					<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
				</div>
			</div>
		{/foreach}
		</div>

		{include file='pagination.tpl'}
		
		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="enable">Сделать видимыми</option>
				<option value="disable">Сделать невидимыми</option>
				<option value="set_featured">Сделать рекомендуемым</option>
				<option value="unset_featured">Отменить рекомендуемый</option>
				<option value="duplicate">Создать дубликат</option>
				{if $pages_count > 1}
					<option value="move_to_page">Переместить на страницу</option>
				{/if}
				{if $categories|count > 1}
					<option value="move_to_category">Переместить в категорию</option>
				{/if}
				{if $all_brands|count > 0}
					<option value="move_to_brand">Указать бренд</option>
				{/if}
				<option value="delete">Удалить</option>
			</select>

			<select name="target_page" class="form-input hidden" data-width="auto">
				{section target_page $pages_count}
					<option value="{$smarty.section.target_page.index+1}">{$smarty.section.target_page.index+1}</option>
				{/section}
			</select>

			<select name="target_category" class="form-input hidden" data-width="auto">
				{function name=category_select level=0}
					{foreach $categories as $category}
						<option
							value='{$category->id}'>{section sp $level}- {/section}{$category->name|escape}</option>
						{category_select categories=$category->subcategories selected_id=$selected_id level=$level+1}
					{/foreach}
				{/function}
				{category_select categories=$categories}
			</select>

			<select name="target_brand" class="form-input hidden" data-width="auto">
				<option value="0">Не указан</option>
				{foreach $all_brands as $b}
					<option value="{$b->id}">{$b->name}</option>
				{/foreach}
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет товаров</p>
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=ProductAdmin">Добавить товар</a>

	{include file = 'inc/search.tpl'}
	
	<ul class="sidebar-list">
		<li{if !$filter} class="selected"{/if}>
			<a href="{url brand_id=null category_id=null keyword=null page=null filter=null}">Все товары</a>
		</li>
		<li{if $filter=='featured'} class="selected"{/if}>
			<a href="{url keyword=null brand_id=null category_id=null page=null filter='featured'}">Рекомендуемые</a>
		</li>
		<li{if $filter=='discounted'} class="selected"{/if}>
			<a href="{url keyword=null brand_id=null category_id=null page=null filter='discounted'}">Со скидкой</a>
		</li>
		<li {if $filter=='visible'} class="selected"{/if}>
			<a href="{url keyword=null brand_id=null category_id=null page=null filter='visible'}">Активные</a>
		</li>
		<li {if $filter=='hidden'} class="selected"{/if}>
			<a href="{url keyword=null brand_id=null category_id=null page=null filter='hidden'}">Неактивные</a>
		</li>
		<li {if $filter=='outofstock'} class="selected"{/if}>
			<a href="{url keyword=null brand_id=null category_id=null page=null filter='outofstock'}">Отсутствующие</a>
		</li>
	</ul>

	{function name=categories_tree}
		{if $categories}
			<ul>
				{foreach $categories as $c}
					<li class="{if $category->id == $c->id}selected{/if}">
						<a href="{url keyword=null brand_id=null page=null category_id={$c->id}}">{$c->name}</a>
					</li>
					{categories_tree categories=$c->subcategories}
				{/foreach}
			</ul>
		{/if}
	{/function}
	
	{if $categories}
	<ul class="sidebar-list">
		<li{if !$category->id} class="selected"{/if}>
			<a href="{url category_id=null brand_id=null}">Все категории</a>
		</li>
		
		{foreach $categories as $c}
			<li class="{if $category->id == $c->id}selected{/if}">
				<a href='{url keyword=null brand_id=null page=null category_id={$c->id}}'>{$c->name}</a>
			</li>
			{categories_tree categories=$c->subcategories}
		{/foreach}
	</ul>
	{/if}

	{if $brands}
		<ul class="sidebar-list">
			<li{if !$brand->id} class="selected"{/if}>
				<a href="{url brand_id=null}">Все бренды</a>
			</li>
			{foreach $brands as $b}
				<li class="{if $brand->id == $b->id}selected{/if}">
					<a href="{url keyword=null page=null brand_id=$b->id}">{$b->name}</a>
				</li>
			{/foreach}
		</ul>
	{/if}
{/capture}

{if $products}
{capture name = 'scripts'}
<script src="design/js/sortable/sortable.min.js"></script>
<script src="design/js/jquery.form.min.js"></script>
<script>
(function($){
	'use strict';

	var $form = $('[data-form=main]');

	// List actions
	$form
		.on('click', '[data-action=duplicate]', function(e){
			e.preventDefault();
			
			var $link = $(this);

			$form.find('input[type=checkbox]').prop('checked', false);
			$link.addClass('loading').closest('.list-item').find('input[type=checkbox]').prop('checked', true);
			$form.find('select[name=action] option[value=duplicate]').prop('selected', true);
			$form.submit();
		})
		.on('click', '[data-action=featured]', function(e){
			e.preventDefault();
			
			var $link = $(this),
				$listItem = $link.closest('.list-item'),
				id = $listItem.find('input[type=checkbox]').val(),
				state = $listItem.hasClass('featured') ? 0 : 1;

			$link.addClass('loading');
				
			updateObject('product', id, { 'featured': state }, function(data){
				$link.removeClass('loading');
				$listItem.toggleClass('featured', state);
			});
		})
		
	// Change actions
	var $actionPanel = $('.action-panel');
	$actionPanel.on('change', 'select[name=action]', function(){
		var action = $(this).val();
		
		$actionPanel.find('select:not([name=action])').addClass('hidden');
		
		switch(action)
		{
			case 'move_to_page':
				$actionPanel.find('select[name=target_page]').removeClass('hidden')
				break;
			case 'move_to_category':
				$actionPanel.find('select[name=target_category]').removeClass('hidden')
				break;
			case 'move_to_brand':
				$actionPanel.find('select[name=target_brand]').removeClass('hidden')
				break;
		}
		
	})
	
	// Sort
	Sortable.create(document.getElementsByClassName('list')[0], {
		sort: true,
		handle: '.list-move',
		draggable: '.list-item',
		animation: 50,
		onChoose: function(){
			$form.find('input[type=checkbox]').prop('checked', false);
		},
		onEnd: function () {
			$form.ajaxSubmit();	
		}
	});
	
	// Show expand variants link
	if($('.additional-variant').length)
		$('[data-action=expand-all-variants]').removeClass('hidden');
		
	// Expand all variants
	var expandAllVariants = true;
	$('[data-action=expand-all-variants]').on('click', function(e){
		e.preventDefault();

		this.text = expandAllVariants ? 'Свернуть все варианты' : 'Развернуть все варианты';
		$('.list-variants').toggleClass('expanded', expandAllVariants);
		expandAllVariants = !expandAllVariants;
	})
	
	// Expand variants
	$('[data-action=expand-variants]').on('click', function(e){
		e.preventDefault();
		
		$(this).parent().toggleClass('expanded');
	})
	
	// Unlimited stock
	$('input[name^=stock]')
		.focus(function(){
			if(this.value == '∞')
				this.value = '';
		})
		.blur(function (){
			if(this.value == '')
				this.value = '∞';
		});

})(window.jQuery);
</script>
{/capture}
{/if}