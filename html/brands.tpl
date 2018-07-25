{$meta_title = 'Бренды' scope=root}

{if $brands}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list">
			{foreach $brands as $brand}
				<div class="list-item">
					<input type="checkbox" name="check[]" class="list-checkbox" value="{$brand->id}">

					<div class="list-name">
						<a href="index.php?module=BrandAdmin&id={$brand->id}">{$brand->name|escape}</a>
					</div>
					
					<div class="list-actions">
						<a href="../brands/{$brand->url}" class="list-action" data-action="preview" title="Предпросмотр в новом окне" target="_blank"></a>
						<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
					</div>
				</div>
			{/foreach}
		</div>

		<div class="action-panel">
			<a href="#" class="action-link" data-action="select-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="delete">Удалить</option>
			</select>
			
			<input type="submit" class="btn" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет брендов</p>
{/if}

{capture name = sidebar}
	<a class="btn btn-green" href="index.php?module=BrandAdmin">Добавить бренд</a>
{/capture}