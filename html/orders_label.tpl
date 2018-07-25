{if $label->id}
	{$meta_title = $label->name|escape scope=root}
	{$page_title = 'Редактирование метки' scope=root}
{else}
	{$meta_title = 'Новая метка' scope=root}
{/if}

{if $message_success == 'added'}
	{$alert_success = 'Метка добавлена' scope=root}
{elseif $message_success == 'updated'}
	{$alert_success = 'Метка обновлена' scope=root}
{elseif $message_error == 'empty_name'}
	{$alert_error = 'Название метки не может быть пустым' scope=root}
{/if}

<form method="post" autocomplete="off">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">
	<input type="hidden" name="id" value="{$label->id}">
	
	<div class="form-row">
		<label for="" class="form-label">Название</label>
		<input type="text" class="form-input" name="name" value="{$label->name|escape}">
	</div>

	<div class="form-row">
		<label for="" class="form-label">Цвет</label>
		
		<span class="form-input-box" data-prefix="#" data-width="sm">
			<input type="text" class="form-input" name="color" value="{$label->color|escape}">
		</span>
		
		<span class="label-color-preview" style="background: #{$label->color|escape}">&nbsp;</span>
	</div>

	<div class="form-row">
		<label for="" class="form-label">&nbsp;</label>

		<a href="#" class="color-preset" title="Pink" style="background:#E91E63;" data-hex="E91E63"></a>
		<a href="#" class="color-preset" title="Purple" style="background:#9C27B0;" data-hex="9C27B0"></a>
		<a href="#" class="color-preset" title="Deep Purple" style="background:#673AB7;" data-hex="673AB7"></a>
		<a href="#" class="color-preset" title="Indigo" style="background:#3F51B5;" data-hex="3F51B5"></a>
		<a href="#" class="color-preset" title="Blue" style="background:#2196F3;" data-hex="2196F3"></a>
		<a href="#" class="color-preset" title="Light Blue" style="background:#03A9F4;" data-hex="03A9F4"></a>
		<a href="#" class="color-preset" title="Cyan" style="background:#00BCD4;" data-hex="00BCD4"></a>
		<a href="#" class="color-preset" title="Teal" style="background:#009688;" data-hex="009688"></a>
		<a href="#" class="color-preset" title="Green" style="background:#4CAF50;" data-hex="4CAF50"></a>
		<a href="#" class="color-preset" title="Light Green" style="background:#8BC34A;" data-hex="8BC34A"></a>
		<a href="#" class="color-preset" title="Lime" style="background:#CDDC39;" data-hex="CDDC39"></a>
		<a href="#" class="color-preset" title="Yellow" style="background:#FFEB3B;" data-hex="FFEB3B"></a>
		<a href="#" class="color-preset" title="Amber" style="background:#FFC107;" data-hex="FFC107"></a>
		<a href="#" class="color-preset" title="Orange" style="background:#FF9800;" data-hex="FF9800"></a>
		<a href="#" class="color-preset" title="Deep Orange" style="background:#FF5722;" data-hex="FF5722"></a>
		<a href="#" class="color-preset" title="Brown" style="background:#795548;" data-hex="795548"></a>
		<a href="#" class="color-preset" title="Grey" style="background:#9E9E9E;" data-hex="9E9E9E"></a>
		<a href="#" class="color-preset" title="Blue Grey" style="background:#607D8B;" data-hex="607D8B"></a>
	</div>

	<div class="action-panel">
		<input type="submit" class="btn" value="Сохранить">
	</div>
</form>

{capture name = 'scripts'}
<link rel="stylesheet" href="design/js/colorpicker/colorpicker.min.css">
<script src="design/js/colorpicker/colorpicker.min.js"></script>
<script>
(function($){
	'use strict';
	
	var $color = $('[name=color]'),
		$colorPreview = $('.label-color-preview');
	
	$('.color-preset').on('click', function(e){
		e.preventDefault();
		$color.val(this.getAttribute('data-hex')).change()
	});
	
	$color
		.colorpicker({
			useHashPrefix: false,
			useAlpha: false,
			extensions: false
		})
		.on('change', function(){
			$colorPreview.css('background', '#' + this.value)
		});
		
}(window.jQuery));
</script>
{/capture}