{$meta_title = 'Бекап' scope=root}

{if $message_success == 'created'}
	{$alert_success = 'Бекап создан' scope=root}
{elseif $message_success == 'restored'}
	{$alert_success = 'Бекап восстановлен' scope=root}
{elseif $message_error == 'no_permission'}
	{$alert_error = "Установите права на запись в папку {$backup_files_dir}" scope=root}
{/if}

{if $backups}
	<form method="post" data-form="backup">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		<div class="list">
			{foreach $backups as $backup}
				<div class="list-item">
					{if $message_error != 'no_permission'}
						<input type="checkbox" class="list-checkbox" name="check[]" value="{$backup->name}">
					{/if}
					
					<div class="list-name">
						<a href="files/backup/{$backup->name}">{$backup->name}</a>
						({if $backup->size>1024*1024}{($backup->size/1024/1024)|round:2} МБ{else}{($backup->size/1024)|round:2} КБ{/if})
					</div>
					
					<div class="list-actions">
						<a href="#" class="list-action" title="Восстановить этот бекап" data-action="restore" data-file="{$backup->name}"></a>
					
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
{/if}

{if $message_error != 'no_permission'}
	{capture name = 'sidebar'}
		<form method="post" data-form="backup-create">
			<input type="hidden" name="session_id" value="{$smarty.session.id}">
			<input type="hidden" name="action" value="create">

			<button type="submit" class="btn btn-green btn-backup">
				<span class="btn-backup-text">Создать бекап</span>
			</button>
		</form>

		<form method="post" data-form="backup-restore">
			<input type="hidden" name="session_id" value="{$smarty.session.id}">
			<input type="hidden" name="action" value="restore">
			<input type="hidden" name="name" value="">
		</form>
	{/capture}
{/if}

{capture name = 'scripts'}
<script>
(function($){
	'use strict';

	var $formBackup			= $('[data-form=backup]'),
		$formBackupRestore	= $('[data-form=backup-restore]'),
		$formBackupCreate	= $('[data-form=backup-create]'),
		checkAll = true;
		
	$formBackup
		.on('submit', function(){
			if ($formBackup.find('select[name=action]').val() == 'delete' && !confirm('Подтвердите удаление'))
			{
				$('.loading').removeClass('loading');
				return false;
			}
		})
		.on('click', '[data-action=delete]', function(e){
			e.preventDefault();
		
			var $link = $(this);
			
			$link.addClass('loading')
			$formBackup.find('input[type=checkbox]').prop('checked', false);
			$link.closest('.list-item').find('input[type=checkbox]').prop('checked', true);
			$formBackup.submit();
		})
		.on('click', '[data-action=restore]', function(e){
			e.preventDefault();

			var $link = $(this),
				file = $link.data('file');
				
			$link.addClass('loading');

			$formBackupRestore.find('input[name=name]').val(file);
			$formBackupRestore.submit();
		})
		.on('click', '[data-action=check-all]', function(e){
			e.preventDefault();
			
			this.innerHTML = checkAll ? 'Снять все' : 'Выбрать все';
			$('input[type=checkbox]:not(:disabled)').prop('checked', checkAll);
			checkAll = !checkAll;
		});
	
	$formBackupRestore
		.on('submit', function(){
			if (!confirm('Текущие данные будут потеряны. Подтвердите восстановление'))
			{
				$('.loading').removeClass('loading');
				return false;
			}
		});
	
	$formBackupCreate
		.on('submit', function(){
			$formBackupCreate.find('button').prop('disabled', true).addClass('loading');
		});
		
})(window.jQuery);
</script>
{/capture}