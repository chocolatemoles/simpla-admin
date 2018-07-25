{if $style_file}
	{$meta_title = "Тема &laquo;{$theme}&raquo; стиль {$style_file}" scope=root}
{/if}

{if $message_error == 'permissions'}
	{$alert_error = "Установите права на запись для файла {$style_file}" scope=root}
{elseif $message_error == 'theme_locked'}
	{$alert_error = 'Текущая тема защищена от изменений. Создайте копию темы.' scope=root}
{/if}

{if $style_file}
	<div id="ace">{$style_content|escape}</div>
	
	<div class="action-panel">
		<button type="button" class="btn" name="save">Сохранить</button>
	</div>
{/if}

{capture name = 'sidebar'}
	<ul class="sidebar-list">
		{foreach $styles as $s}
			<li {if $style_file == $s} class="selected"{/if}>
				<a href="index.php?module=StylesAdmin&file={$s}">{$s}</a>
			</li>
		{/foreach}
	</ul>
{/capture}

{capture name = 'scripts'}
<script src="design/js/ace/ace.js"></script>
<script>
(function($){
	'use strict';
	
	var $ace = $('#ace');
	
	var editor = ace.edit('ace');
		editor.setTheme('ace/theme/chrome');
		editor.session.setMode('ace/mode/css');
		{if $message_error}
		editor.setReadOnly(true);
		{/if}
		editor.focus();
		editor.commands.addCommand({
			name: 'save',
			bindKey: {
				win: 'Ctrl-S',
				mac: 'Command-S'
			},
			exec: function(editor) {
				save();
			}
		});
		
	$('button[name=save]').click(function (e) {
		e.preventDefault();
		save();
	});

	function save() {
		$ace.toggleClass('saved', true)

		$.ajax({
			type: 'POST',
			url: 'ajax/save_style.php',
			data: {
				'content': editor.getValue(),
				'theme': '{$theme}',
				'style': '{$style_file}',
				'session_id': '{$smarty.session.id}'
			},
			success: function (data) {
				$ace.toggleClass('saved', false)
			},
			dataType: 'json'
		});
	};
	
}(window.jQuery));
</script>
{/capture}