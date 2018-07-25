{if $pages_count > 1}
	<div class="pagination">
		{* Количество выводимых ссылок на страницы *}
		{$visible_pages = 11}

		{* По умолчанию начинаем вывод со страницы 1 *}
		{$page_from = 1}

		{* Если выбранная пользователем страница дальше середины "окна" - начинаем вывод уже не с первой *}
		{if $current_page > floor($visible_pages/2)}
			{$page_from = max(1, $current_page-floor($visible_pages/2)-1)}
		{/if}

		{* Если выбранная пользователем страница близка к концу навигации - начинаем с "конца-окно" *}
		{if $current_page > $pages_count-ceil($visible_pages/2)}
			{$page_from = max(1, $pages_count-$visible_pages-1)}
		{/if}

		{* До какой страницы выводить - выводим всё окно, но не более ощего количества страниц *}
		{$page_to = min($page_from+$visible_pages, $pages_count-1)}

		{if $current_page>1}<a href="{url page=$current_page-1}" class="js-page-prev"><i class="icon-angle-left"></i></a>{/if}
		
		{* Ссылка на 1 страницу отображается всегда *}
		<a href="{url page=1}" class="{if $current_page == 1}active{else}droppable{/if}" data-type="page" data-id="">1</a>

		{* Выводим страницы нашего "окна" *}
		{section name=pages loop=$page_to start=$page_from}
			{* Номер текущей выводимой страницы *}
			{$p = $smarty.section.pages.index+1}
			{* Для крайних страниц "окна" выводим троеточие, если окно не возле границы навигации *}
			{if ($p == $page_from+1 && $p!=2) || ($p == $page_to && $p != $pages_count-1)}
				<a href="{url page=$p}" class="{if $p == $current_page}active{/if}">...</a>
			{else}
				<a href="{url page=$p}" class="{if $p == $current_page}active{else}droppable{/if}" data-type="page" data-id="">{$p}</a>
			{/if}
		{/section}

		{* Ссылка на последнююю страницу отображается всегда *}
		<a href="{url page=$pages_count}" class="{if $current_page == $pages_count}active{else}droppable{/if}" data-type="page" data-id="">{$pages_count}</a>

		<a href="{url page=all}">все сразу</a>
		
		{if $current_page<$pages_count}<a href="{url page=$current_page+1}" class="js-page-next"><i class="icon-angle-right"></i></a>{/if}
	</div>
	
	<script>
		(function(){
			document.onkeydown = function(e) {
				{if $current_page > 1}
					if(e.keyCode == 37)
						window.location = '{url page=$current_page-1}';
				{/if}
				
				{if $current_page<$pages_count}
					if(e.keyCode == 39)
						window.location = '{url page=$current_page+1}';
				{/if}
			};
		})();
	</script>
{/if}