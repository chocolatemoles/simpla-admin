{$meta_title = 'Купоны' scope=root}

{if $coupons_count}
{$page_title = "{$coupons_count} {$coupons_count|plural:'купон':'купонов':'купона'}" scope=root}
{/if}

{if $coupons}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		{include file='pagination.tpl'}
		
		<div class="list">
			{foreach $coupons as $coupon}
				<div class="list-item {if !$coupon->valid} invisible{/if}">
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$coupon->id}">
					
					<div class="list-name">
						<a href="index.php?module=CouponAdmin&id={$coupon->id}">{$coupon->code}</a>
					</div>
					
					<div class="list-discount list-discount-{$coupon->type}">
						{$coupon->value*1} {if $coupon->type=='absolute'}{$currency->sign}{else}%{/if}<br>
					</div>

					
					<div class="list-info">
						{if $coupon->min_order_price>0}
							<p class="list-info-coupon-min-price">Для заказов от {$coupon->min_order_price|convert} {$currency->sign}</p>
						{/if}
						
						{if $coupon->single}
							<p>Одноразовый</p>
						{/if}
						
						{if $coupon->usages>0}
							<p>Использован {$coupon->usages|escape} {$coupon->usages|plural:'раз':'раз':'раза'}</p>
						{/if}
						
						{if $coupon->expire}
							<p>
								{if $smarty.now|date_format:'%Y%m%d' <= $coupon->expire|date_format:'%Y%m%d'}
									Действует до {$coupon->expire|date}
								{else}
									Истёк {$coupon->expire|date}
								{/if}
							</p>
						{/if}
					</div>

					<div class="list-actions">
						<a href="#" class="list-action" data-action="delete"></a>
					</div>
				</div>
			{/foreach}
		</div>

		{include file='pagination.tpl'}
		
		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>

			<select name="action" class="form-input" data-width="auto">
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет купонов</p>
{/if}

{capture name = 'sidebar'}
	<a class="btn btn-green" href="index.php?module=CouponAdmin">Новый купон</a>
{/capture}