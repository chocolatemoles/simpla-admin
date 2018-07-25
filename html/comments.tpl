{$meta_title='Комментарии' scope=root}

{if $keyword && $comments_count}
	{$page_subtitle = "{$comments_count|plural:'Нашелся':'Нашлось':'Нашлись'} {$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'}" scope=root}
{elseif !$type}
	{$page_subtitle = "{$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'}" scope=root}
{elseif $type=='product'}
	{$page_subtitle = "{$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} к товарам" scope=root}
{elseif $type=='blog'}
	{$page_subtitle = "{$comments_count} {$comments_count|plural:'комментарий':'комментариев':'комментария'} к записям в блоге" scope=root}
{/if}

{if $comments}
	<form method="post" data-form="main">
		<input type="hidden" name="session_id" value="{$smarty.session.id}">

		{include file='pagination.tpl'}
		
		<div class="list list-comments">
			{foreach $comments as $comment}
				<div class="list-item {if !$comment->approved} unapproved{/if}">
					<input type="checkbox" class="list-checkbox" name="check[]" value="{$comment->id}">
					
					<div class="list-name">{$comment->name|escape}</div>
					
					<div class="list-comment-text">{$comment->text|escape|nl2br}</div>

					<div class="list-comment-source">
						{if $comment->type == 'product'}
							к товару
							<a target="_blank" href="{$config->root_url}/products/{$comment->product->url}#comment_{$comment->id}">
								{$comment->product->name}
							</a>
						{elseif $comment->type == 'blog'}
							к статье
							<a target="_blank" href="{$config->root_url}/blog/{$comment->post->url}#comment_{$comment->id}">
								{$comment->post->name}
							</a>
						{/if}
					</div>

					<div class="list-comment-date">{$comment->date|date} в {$comment->date|time}</div>
					
					<div class="list-actions">
						{if !$comment->approved}
						<a href="#" class="list-action" data-action="approve" title="Одобрить"></a>
						{/if}
						<a href="#" class="list-action" data-action="delete" title="Удалить"></a>
					</div>
				</div>
			{/foreach}
		</div>

		{include file='pagination.tpl'}
		
		<div class="action-panel">
			<a href="#" class="action-link" data-action="check-all">Выбрать все</a>
			<span class="action-link-sep"></span>
			<a href="#" class="action-link" data-action="check-unapproved">Выбрать ожидающие одобрения</a>
			
			<select name="action" class="form-input" data-width="auto">
				<option value="approve">Одобрить</option>
				<option value="delete">Удалить</option>
			</select>

			<input class="btn" type="submit" value="Применить">
		</div>
	</form>
{else}
	<p class="alert">Нет комментариев</p>
{/if}


{capture name = 'sidebar'}
	{include file = 'inc/search.tpl'}

	<div class="sidebar-list">
		<li{if !$type} class="selected"{/if}>
			<a href="{url type=null}">Все комментарии</a>
		</li>
		<li{if $type == 'product'} class="selected"{/if}>
			<a href="{url keyword=null type=product}">К товарам</a>
		</li>
		<li{if $type == 'blog'} class="selected"{/if}>
			<a href="{url keyword=null type=blog}">К блогу</a>
		</li>
	</div>
{/capture}

{capture name = 'scripts'}
<script>
(function(){
	'use strict';
	
	var $form = $('[data-form=main]');
	
	$form.on('click', '[data-action=approve]', function(e){
		e.preventDefault();
		
		var $link = $(this),
			$listItem = $link.closest('.list-item'),
			id = $listItem.find('input[type=checkbox]').val();

		$link.addClass('loading');
			
		updateObject('comment', id, { 'approved': 1 }, function(){
			$link.remove();
			$listItem.removeClass('unapproved');
		})
	})
	
	// Check unapproved
	$('[data-action=check-unapproved]').on('click', function(e){
		e.preventDefault();
		
		$form.find('input[type=checkbox]').prop('checked', false);
		$form.find('.unapproved input[type=checkbox]').prop('checked', true);
	})
	
})(window.jQuery);
</script>
{/capture}