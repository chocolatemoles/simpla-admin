{if $feature->id}
	{$meta_title = $feature->name|escape scope=root}
	{$page_title = 'Редактирование свойства' scope=root}
{else}
	{$meta_title = 'Новое свойство' scope=root}
{/if}

{capture name = 'alerts'}
	{if $message_success == 'added'}
		{$alert_success = 'Свойство добавлено' scope=root}
	{elseif $message_success == 'updated'}
		{$alert_success = 'Свойство обновлено' scope=root}
	{/if}
{/capture}

<form method="post" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$feature->id|escape}">

	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$feature->name|escape}" required>
	</div>

	<div class="form-row">
		<label for="" class="form-label">Использовать в категориях</label>
		<select class="form-input" name="feature_categories[]" multiple size="10">
			{function name=category_select selected_id=$product_category level=0}
				{foreach $categories as $category}
					<option value='{$category->id}' {if in_array($category->id, $feature_categories)}selected{/if}
							category_name='{$category->single_name}'>{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$category->name}</option>
					{category_select categories=$category->subcategories selected_id=$selected_id  level=$level+1}
				{/foreach}
			{/function}
			{category_select categories=$categories}
		</select>
		<em class="form-tip" style="width: 200px">Используйте клавиши shift и ctrl для выбора нескольких категорий</em>
	</div>
	
	<div class="form-row">
		<label for="" class="form-label">Использовать в фильтре</label>
		<input type="checkbox" class="form-checkbox" name="in_filter" value="1" {if $feature->in_filter} checked{/if}>
	</div>

	<div class="action-panel">
		<input class="btn" type="submit" value="Сохранить">
	</div>
</form>