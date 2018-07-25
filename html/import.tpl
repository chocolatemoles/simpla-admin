{$meta_title = 'Импорт товаров' scope=root}

{if $message_error == 'no_permission'}
	{$alert_error = "Установите права на запись в папку {$import_files_dir}" scope=root}
{elseif $message_error == 'convert_error'}
	{$alert_error = 'Не получилось сконвертировать файл в кодировку UTF8' scope=root}
{elseif $message_error == 'locale_error'}
	{$alert_info = "На сервере не установлена локаль {$locale}, импорт может работать некорректно" scope=root}
{/if}

{if $message_error != 'no_permission'}
	{if $filename}
		<p class="block-title">Импорт &laquo;{$filename|escape}&raquo;</p>
		
		<div class="import-progress">
			<div class="import-progress-bar" style="width: 0%"></div>
			<div class="import-progress-percent">0%</div>
		</div>
		
		<div class="import-result-counts"></div>
		<div class="import-result"></div>
	{else}
		<form method="post" enctype="multipart/form-data">
			<input type="hidden" name="session_id" value="{$smarty.session.id}">
			
			<div class="form-row">
				<input name="file" class="form-input" type="file" value="">
				<em class="form-tip">
				максимальный размер файла —
				{if $config->max_upload_filesize>1024*1024}
					{$config->max_upload_filesize/1024/1024|round:'2'} МБ
				{else}
					{$config->max_upload_filesize/1024|round:'2'} КБ
				{/if}
				</em>
			</div>

			<input class="btn btn-green" type="submit" value="Загрузить">
		</form>
		
		<hr>
		
		<div class="import-help">
			<p>Создайте бекап на случай неудачного импорта</p>
			<p>Сохраните таблицу в формате CSV</p>
			<p>В первой строке таблицы должны быть указаны названия колонок в таком формате:</p>

			<ul class="import-help-example">
				<li><label>Товар</label> название товара</li>
				<li><label>Категория</label> категория товара</li>
				<li><label>Бренд</label> бренд товара</li>
				<li><label>Вариант</label> название варианта</li>
				<li><label>Цена</label> цена товара</li>
				<li><label>Старая цена</label> старая цена товара</li>
				<li><label>Склад</label> количество товара на складе</li>
				<li><label>Артикул</label> артикул товара</li>
				<li><label>Видим</label> отображение товара на сайте (0 или 1)</li>
				<li><label>Рекомендуемый</label> является ли товар рекомендуемым (0 или 1)</li>
				<li><label>Аннотация</label> краткое описание товара</li>
				<li><label>Адрес</label> адрес страницы товара</li>
				<li><label>Описание</label> полное описание товара</li>
				<li><label>Изображения</label> имена локальных файлов или url изображений в интернете, через запятую</li>
				<li><label>Заголовок страницы</label> заголовок страницы товара (Meta title)</li>
				<li><label>Ключевые слова</label> ключевые слова (Meta keywords)</li>
				<li><label>Описание страницы</label> описание страницы товара (Meta description)</li>
				<li><label>&nbsp;</label> Любое другое название колонки трактуется как название свойства товара</li>
				<li><label>&nbsp;</label> <a href="files/import/example.csv">Скачать пример файла</a></li>
			</ul>
		</div>
	{/if}
{/if}

{if $filename}
{capture name = 'scripts'}
<script>
(function(){
	'use strict';

	var $progressBar = $('.import-progress-bar'),
		$progressPercent = $('.import-progress-percent'),
		$result = $('.import-result'),
		$resultCounts = $('.import-result-counts'),
		percent = '0%',
		countAdded = 0,
		countUpdated = 0;

	function do_import(from) {
		$.ajax({
			url: 'ajax/import.php',
			data: {
				from: from
			},
			dataType: 'json',
			success: function (data) {
				for (var key in data.items)
				{
					console.log(data.items[key])
					var $item = $('<div>', {
						class: 'import-result-item ' + data.items[key].status,
						html: [$('<a>', {
								class: 'import-result-name',
								text: data.items[key].product.name,
								href: 'index.php?module=ProductAdmin&id=' + data.items[key].product.id,
								target: '_blank'
							}),
							$('<span>', {
								text: data.items[key].variant.name ? ', ' + data.items[key].variant.name : ''
							})],
						title: data.items[key].status == 'added' ? 'Добавлен' : 'Обновлен'
					});
					
					$result.prepend($item);
					
					if(data.items[key].status == 'added')
						countAdded++;
					else
						countUpdated++;
					
					counter(countAdded, countUpdated);
				}

				percent = (100 * data.from / data.totalsize).toFixed() + '%';
				
				$progressBar.css('width', percent)
				$progressPercent.text(percent)
				
				if (data != false && !data.end)
				{
					do_import(data.from);
				}
				else {
					$progressBar.css('width', '100%')
					$progressPercent.text('100%')
				}
			},
			error: function (xhr, status, errorThrown) {
				alert(errorThrown + '\n' + xhr.responseText);
			}
		});
	}
	
	function counter(countAdded, countUpdated){
		if(countAdded > 0)
			var textAdded = countAdded + plural(countAdded, [' товар добавлен', ' товара добавлено', ' товаров добавлено']);

		if(countUpdated > 0)
			var textUpdated = countUpdated + plural(countUpdated, [' товар обновлен', ' товара обновлено', ' товаров обновлено']);

		if(textAdded && textUpdated)
			var text = textAdded + ', ' + textUpdated;
		else
			var text = textAdded ? textAdded : textUpdated;

		$resultCounts.html('<p>' + text + '</p>');
	}
	
	function plural(n,f){
		n%=100;if(n>10&&n<20)return f[2];n%=10;return f[n>1&&n<5?1:n==1?0:2]
	}

	do_import(0);
	
})(window.jQuery);
</script>
{/capture}
{/if}