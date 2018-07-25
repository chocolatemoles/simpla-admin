{if $message_success == 'added'}
	{if in_array($smarty.get.module, ['CategoryAdmin', 'OrdersLabelAdmin', 'GroupAdmin', 'PageAdmin', 'PostAdmin'])}
		{$add_more_plural = 'одну'}
	{elseif $smarty.get.module == 'ManagerAdmin'}
		{$add_more_plural = 'одного'}
	{elseif $smarty.get.module == 'FeatureAdmin'}
		{$add_more_plural = 'одно'}
	{else}
		{$add_more_plural = 'один'}
	{/if}

	<a href="http://simpla-admin/simpla/index.php?module={$smarty.get.module}{if $smarty.get.menu_id}&menu_id={$smarty.get.menu_id}{/if}">Добавить еще {$add_more_plural}</a>
{/if}