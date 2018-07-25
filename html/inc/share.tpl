{assign share_data []}
{if $smarty.get.module == 'PageAdmin' && $page->url}
	{$share_data[] = "'url': '{$config->root_url|urlencode}/{$page->url|urlencode}'"}
	{$share_data[] = "'title': '{$page->name|urlencode}'"}
	{if $page->meta_description}
	{$share_data[] = "'description': '{$page->meta_description|urlencode}'"}
	{/if}
	{if $page->meta_keywords}
	{$share_data[] = "'hashtags': '{$page->meta_keywords|replace:' ':''|urlencode}'"}
	{/if}
{elseif $smarty.get.module == 'PostAdmin' && $post->url}
	{$share_data[] = "'url': '{$config->root_url|urlencode}/blog/{$post->url|urlencode}'"}
	{$share_data[] = "'title': '{$post->name|urlencode}'"}
	{if $post->meta_description}
	{$share_data[] = "'description': '{$post->meta_description|urlencode}'"}
	{/if}
	{if $post->meta_keywords}
	{$share_data[] = "'hashtags': '{$post->meta_keywords|replace:' ':''|urlencode}'"}
	{/if}
{elseif $smarty.get.module == 'ProductAdmin' && $product->url}
	{$share_data[] = "'url': '{$config->root_url|urlencode}/products/{$product->url|urlencode}'"}
	{$share_data[] = "'title': '{$product->name|urlencode}'"}
	{if $product->meta_description}
	{$share_data[] = "'description': '{$product->meta_description|urlencode}'"}
	{/if}
	{if $product->meta_keywords}
	{$share_data[] = "'hashtags': '{$product->meta_keywords|replace:' ':''|urlencode}'"}
	{/if}
	{if $product_images.0->filename}
	{$share_data[] = "'image': '{$product_images.0->filename|resize:1000:1000|urlencode}'"}
	{/if}
{elseif $smarty.get.module == 'BrandAdmin' && $brand->url}
	{$share_data[] = "'url': '{$config->root_url|urlencode}/brands/{$brand->url|urlencode}'"}
	{$share_data[] = "'title': '{$brand->name|urlencode}'"}
	{if $brand->meta_description}
	{$share_data[] = "'description': '{$brand->meta_description|urlencode}'"}
	{/if}
	{if $brand->meta_keywords}
	{$share_data[] = "'hashtags': '{$brand->meta_keywords|replace:' ':''|urlencode}'"}
	{/if}
	{if $brand->image}
	{$share_data[] = "'image': '{$config->root_url|urlencode}/files/brands/{$brand->image|urlencode}'"}
	{/if}
{elseif $smarty.get.module == 'CategoryAdmin' && $category->url}
	{$share_data[] = "'url': '{$config->root_url|urlencode}/catalog/{$category->url|urlencode}'"}
	{$share_data[] = "'title': '{$category->name|urlencode}'"}
	{if $category->meta_description}
	{$share_data[] = "'description': '{$category->meta_description|urlencode}'"}
	{/if}
	{if $category->meta_keywords}
	{$share_data[] = "'hashtags': '{$category->meta_keywords|replace:' ':''|urlencode}'"}
	{/if}
	{if $category->image}
	{$share_data[] = "'image': '{$config->root_url|urlencode}/files/categories/{$category->image|urlencode}'"}
	{/if}
{/if}

{if $share_data}
	<div class="share">
		<button type="button" class="share-btn" data-share="vk" title="Поделиться во Вконтакте"><i class="icon-vkontakte"></i></button>
		<button type="button" class="share-btn" data-share="twitter" title="Поделиться в Twitter"><i class="icon-twitter"></i></button>
		<button type="button" class="share-btn" data-share="facebook" title="Поделиться в Facebook"><i class="icon-facebook"></i></button>
	</div>

	<script>
		var shareData = { {$share_data|implode:', '} };
		var shareButtons = document.getElementsByClassName('share-btn');
		var sharePopupX = screen.width/2 - 700/2;
		var sharePopupY = 150;

		for (var i = 0; i < shareButtons.length; i++) {
			shareButtons[i].addEventListener('click', function (e) {
				e.preventDefault();
				
				var url = '';

				switch(this.getAttribute('data-share'))
				{
					case 'vk':
						url += '//vk.com/share.php?url=' + shareData.url;
						url += shareData.title ? ('&title=' + shareData.title) : '';
						url += shareData.description ? ('&description=' + shareData.description) : '';
						url += shareData.image ? ('&image=' + shareData.image) : '';
						url += '&noparse=true';
						break;
					case 'facebook':
						url += '//facebook.com/sharer.php?u=' + shareData.url;	
						url += shareData.title ? ('&title=' + shareData.title) : '';
						url += shareData.image ? ('&picture=' + shareData.image) : '';
						break;
					case 'twitter':
						url += '//twitter.com/share?src=sp&url=' + shareData.url;
						url += shareData.title ? ('&text=' + shareData.title) : '';
						url += shareData.hashtags ? ('&hashtags=' + shareData.hashtags) : '';
						break;
					default: 
						return false;
				}

				window.open(url, '', 'toolbar=0, status=0, width=700, height=450, left=' + sharePopupX + ', top=' + sharePopupY);
			}, false);
		}
	</script>
{/if}