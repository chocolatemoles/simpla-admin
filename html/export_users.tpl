{$meta_title = 'Экспорт покупателей' scope=root}

{if $message_error == 'no_permission'}
	{$alert_error = "Установите права на запись в папку {$export_files_dir}" scope=root}
{elseif $message_error == 'iconv_or_mb_convert_encoding'}
	{$alert_error = 'Отсутствует iconv или mb_convert_encoding' scope=root}
{/if}

{if $message_error != 'no_permission'}
	<button class="btn btn-green btn-progress">Экспортировать</button>
{/if}

{capture name = 'scripts'}
<link rel="stylesheet" href="design/js/progress/progress.css">
<script src="design/js/progress/progress.js"></script>
<script>
(function($){
	'use strict';
	
	var group_id = '{$group_id}',
		keyword = '{$keyword|escape}',
		sort = '{$sort|escape}';
	
	new ProgressButton(document.querySelector('.btn-progress'), {
		callback : function( instance ) {
			do_export(instance, 1);
		}
	});

	function do_export(instance, page) {
		page = typeof(page) != 'undefined' ? page : 1;

		$.ajax({
			url: 'ajax/export_users.php',
			data: {
				page: page, group_id: group_id, keyword: keyword, sort: sort
			},
			dataType: 'json',
			success: function (data) {
				if (data.error) {
					instance._stop(1);
					alert(data.error);
				}
				else if (data && !data.end) {
					instance._setProgress( Math.round(100 * data.page / data.totalpages) );
					do_export(instance, data.page * 1 + 1);
				}
				else {
					instance._stop(1);
					window.location.href = 'files/export_users/users.csv';
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