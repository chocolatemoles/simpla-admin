{$meta_title = 'Экспорт товаров' scope=root}

{if $message_error == 'no_permission'}
	{$alert_error = "Установите права на запись в папку {$export_files_dir}" scope=root}
{elseif $message_error == 'iconv_or_mb_convert_encoding'}
	{$alert_error = 'Отсутствует iconv или mb_convert_encoding' scope=root}
{/if}

{if $exports}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">
		
		<div class="list">
			{foreach $exports as $export}
				<div class="list-item">
					{if $message_error != 'no_permission'}
						<div class="checkbox cell">
							<input type="checkbox" class="list-checkbox" name="check[]" value="{$export->name}">
						</div>
					{/if}
					<div class="list-name">
						<a href="files/export/{$export->name}">{$export->name}</a>
						
						({if $export->size>1024*1024}{($export->size/1024/1024)|round:2} МБ{else}{($export->size/1024)|round:2} КБ{/if})
					</div>
					
					<div class="list-actions">
						{if $message_error != 'no_permission'}
							<a href="#" class="list-action" title="Удалить" data-action="delete"></a>
						{/if}
					</div>
				</div>
			{/foreach}
		</div>
		
		{if $message_error != 'no_permission'}
			<div class="action-panel">
				<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

				<select name="action" class="form-input" data-width="auto">
					<option value="delete">Удалить</option>
				</select>

				<input class="btn" type="submit" value="Применить">
			</div>
		{/if}
	</form>

	{capture name = 'sidebar'}
		{if $message_error != 'no_permission'}
			<button class="btn btn-green btn-progress">Экспортировать</button>
		{/if}
	{/capture}
{else}
	{if $message_error != 'no_permission'}
		<button class="btn btn-green btn-progress">Экспортировать</button>
	{/if}
{/if}

{capture name = 'scripts'}
<link rel="stylesheet" href="design/js/progress/progress.css">
<script src="design/js/progress/progress.js"></script>
<script>
(function($){
	'use strict';
	
	// var filename = 'export_{trim($manager->login)}_{date("Y_m_d_G_i_s")}.csv'; // For Obsen 
	var filename = 'export.csv';

	new ProgressButton(document.querySelector('.btn-progress'), {
		callback : function( instance ) {
			do_export(instance, 1);
		}
	});

	function do_export(instance, page) {
		page = typeof(page) != 'undefined' ? page : 1;

		$.ajax({
			url: 'ajax/export.php',
			data: {
				page: page, filename: filename
			},
			dataType: 'json',
			success: function (data) {
				if (data.error) {
					instance._stop(1);
					alert(data.error);
				}
				else if (data && data.end){
					instance._stop(1);
					window.location.href = 'files/export/' + filename;
				} else {
					instance._setProgress( Math.round(100 * data.page / data.totalpages) );
					do_export(instance, data.page * 1 + 1);	
				}
			},
			error: function (xhr, status, errorThrown) {
				alert(errorThrown + '\n' + xhr.responseText);
			}
		});
	}
	
})(window.jQuery);
</script>
{/capture}