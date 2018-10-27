{$meta_title = 'Настройки' scope=root}

{if $message_success == 'saved'}
	{$alert_success = 'Настройки сохранены' scope=root}
{elseif $message_error == 'watermark_is_not_writable'}
	{$alert_error = "Установите права на запись для файла {$config->watermark_file}" scope=root}
{/if}

<form method="post" enctype="multipart/form-data" autocomplete="off">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
    
	<p class="block-title">Настройки сайта</p>
	
	<div class="form-row">
		<label class="form-label">Имя сайта</label>
		<input class="form-input" type="text" name="site_name" value="{$settings->site_name|escape}">
	</div>

	<div class="form-row">
		<label class="form-label">Имя компании</label>
		<input class="form-input" type="text" name="company_name" value="{$settings->company_name|escape}">
	</div>
	
	<div class="form-row">
		<label class="form-label">Формат даты</label>
		<input class="form-input" type="text" name="date_format" value="{$settings->date_format|escape}" data-width="sm">
	</div>
	
	<div class="form-row">
		<label class="form-label">Email для восстановления пароля</label>
		<input class="form-input" type="text" name="admin_email" value="{$settings->admin_email|escape}">
	</div>

	<hr>
	
	<p class="block-title">Оповещения</p>
        
	<div class="form-row">
		<label class="form-label">Оповещение о заказах</label>
		<input class="form-input" type="text" name="order_email" value="{$settings->order_email|escape}">
	</div>
	
	<div class="form-row">
		<label class="form-label">Оповещение о комментариях</label>
		<input class="form-input" type="text" name="comment_email"  value="{$settings->comment_email|escape}">
	</div>
	
	<div class="form-row">
		<label class="form-label">Обратный адрес оповещений</label>
		<input class="form-input" type="text" name="notify_from_email" value="{$settings->notify_from_email|escape}">
	</div>

	<hr>
	
	<p class="block-title">Формат цены</p>
	
	<div class="form-row">
		<label class="form-label">Разделитель копеек</label>
		<select class="form-input" name="decimals_point" data-width="md">
			<option value='.' {if $settings->decimals_point == '.'}selected{/if}>точка: 12.45 {$currency->sign|escape}</option>
			<option value=',' {if $settings->decimals_point == ','}selected{/if}>запятая: 12,45 {$currency->sign|escape}</option>
		</select>
	</div>
	
	<div class="form-row">
		<label class="form-label">Разделитель тысяч</label>
		<select class="form-input" name="thousands_separator" data-width="md">
			<option value='' {if $settings->thousands_separator == ''}selected{/if}>без разделителя: 1245678 {$currency->sign|escape}</option>
			<option value=' ' {if $settings->thousands_separator == ' '}selected{/if}>пробел: 1 245 678 {$currency->sign|escape}</option>
			<option value=',' {if $settings->thousands_separator == ','}selected{/if}>запятая: 1,245,678 {$currency->sign|escape}</option>
		</select>
	</div>

	<hr>

	<p class="block-title">Настройки каталога</p>
	
	<div class="form-row">
		<label class="form-label">Товаров на странице сайта</label>
		<input class="form-input" type="text" name="products_num" value="{$settings->products_num|escape}" data-width="xs">
	</div>
	
	<div class="form-row">
		<label class="form-label">Товаров на странице админки</label>
		<input class="form-input" type="text" name="products_num_admin" value="{$settings->products_num_admin|escape}" data-width="xs">
	</div>
	
	<div class="form-row">
		<label class="form-label">Максимум товаров в заказе</label>
		<input class="form-input" type="text" name="max_order_amount" value="{$settings->max_order_amount|escape}" data-width="xs">
	</div>
	
	<div class="form-row">
		<label class="form-label">Единицы измерения товаров</label>
		<input class="form-input" type="text" name="units" value="{$settings->units|escape}" data-width="xs">
	</div>

	<hr>
    
	<p class="block-title">Изображения товаров</p>

	<div class="settings-watermark-box">
		<div class="form-row">
			<label class="form-label">Водяной знак</label>
			<input class="form-input" name="watermark_file" type="file" accept="image/*">
		</div>

		<span class="watermark-preview">
			<img src="design/images/watermark_dummy.jpg" class="watermark-product" alt="">
		</span>
		
		<script>
			// Set watermark position and opacity
			(function(){
				var $w = document.createElement('img');
					$w.src = '{$config->root_url}/{$config->watermark_file}?{math equation="rand(10,10000)"}';
					$w.classList.add('watermark-image');
					
				var $box = document.getElementsByClassName('watermark-preview')[0]; 

				$w.onload = function (){
					var x = Math.min.apply(null, [(280-$w.width) * {$settings->watermark_offset_x|escape} / 100, 280]),
						y = Math.min.apply(null, [(280-$w.height) * {$settings->watermark_offset_y|escape} / 100, 280]);

					$w.style.setProperty('top', y + 'px')
					$w.style.setProperty('left', x + 'px')
					$w.style.setProperty('opacity', 1 - Math.min.apply(null, [100, {$settings->watermark_transparency|escape}]) / 100)	  
					$box.appendChild($w)
				}
			})();
		</script>

		<div class="form-row">
			<label class="form-label">Горизонтальное положение</label>
			
			<span class="form-input-box" data-suffix="%" data-width="xs">
				<input class="form-input" type="text" name="watermark_offset_x" value="{$settings->watermark_offset_x|escape}">
			</span>
		</div>
		
		<div class="form-row">
			<label class="form-label">Вертикальное положение</label>
			<span class="form-input-box" data-suffix="%" data-width="xs">
				<input class="form-input" type="text" name="watermark_offset_y" value="{$settings->watermark_offset_y|escape}">
			</span>
		</div>
		
		<div class="form-row">
			<label class="form-label">Прозрачность знака</label>
			<span class="form-input-box" data-suffix="%" data-width="xs">
				<input class="form-input" type="text" name="watermark_transparency" value="{$settings->watermark_transparency|escape}">
			</span>
			<em class="form-tip">больше &mdash; прозрачней</em>
		</div>
		
		<div class="form-row">
			<label class="form-label">Резкость изображений</label>
			<span class="form-input-box" data-suffix="%" data-width="xs">
				<input class="form-input" type="text" name="images_sharpen" value="{$settings->images_sharpen|escape}">
			</span>
			<em class="form-tip">рекомендуется 20%</em>
		</div>
	</div>
	<hr>
	
	<p class="block-title">Интеграция с <a target="_blank" href="http://prostiezvonki.ru">простыми звонками</a></p>

	<div class="form-row">
		<label class="form-label">Сервер</label>
		<input class="form-input" name="pz_server" type="text" value="{$settings->pz_server|escape}" data-width="md">
	</div>
	
	<div class="form-row">
		<label class="form-label">Пароль</label>
		<input class="form-input" name="pz_password" type="text" value="{$settings->pz_password|escape}" data-width="md">
	</div>
	
	<p class="block-title">Телефоны менеджеров:</p>
	
	{foreach $managers as $i => $manager}
		<div class="form-row">
			<label class="form-label">{$manager->login}</label>
			<input class="form-input" name="pz_phones[{$manager->login}]" type="text" value="{$settings->pz_phones[$manager->login]|escape}" data-width="sm">
		</div>
	{/foreach}

	<div class="action-panel">
		<input type="submit" class="btn" name="save" value="Сохранить">
	</div>
</form>