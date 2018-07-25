function updateObject(object, id, values, callback){
	$.ajax({
		type: 'POST',
		dataType: 'json',
		url: 'ajax/update_object.php',
		data: {
			'object': object,
			'id': id,
			'values': values,
			'session_id': backend.session_id
		},
		success: callback
	});
};

(function($){
	'use strict';

	// Sidebar
	var $sidebar = $('.content-left');

	if (!Modernizr.touchevents)
	{
		var scrollbar = Scrollbar.init(document.querySelector('.sidemenu-categories-wrapper'), {
			continuousScrolling: false
		});

		scrollbar.addListener(function(status ){
			if(status.offset.y > 0)
				$sidebar.addClass('with-shadow')
			else
				$sidebar.removeClass('with-shadow')
		})
	}
	
	$sidebar
		.on('click', '.mobile-menu-toggle', function(e){
			e.preventDefault();
			
			$sidebar.toggleClass('menu-opened')
		})
		.on('click', '.sidemenu-toggle', function(e){
			e.preventDefault();

			this.parentNode.classList.toggle('opened')
			
			if (!Modernizr.touchevents)
				scrollbar.update()
		});

	// Main form
	var $form = $('[data-form=main]');
	var checkAll = true;
	
	$form
		.on('submit', function(){
			if ($form.find('select[name=action]').val() == 'delete' && !confirm('Подтвердите удаление'))
			{
				$('.loading').removeClass('loading');
				return false;
			}
		})
		// Set 'visible'
		.on('click', '[data-action=visible]', function(e){
			e.preventDefault();
			
			var $link = $(this),
				$listItem = $link.closest('.list-item'),
				id = $listItem.find('input[type=checkbox]').val(),
				state = $listItem.hasClass('invisible') ? 1 : 0;
				
			$link.addClass('loading');

			updateObject(backend.object, id, {'visible': state}, function (data) {
				$link.removeClass('loading');
				$listItem.toggleClass('invisible', state);
			})	
		})
		// Set 'enable'
		.on('click', '[data-action=enable]', function(e){
			e.preventDefault();

			var $link = $(this),
				$listItem = $link.closest('.list-item'),
				id = $listItem.find('input[type=checkbox]').val(),
				state = $listItem.hasClass('invisible') ? 1 : 0;
						
			$link.addClass('loading');

			updateObject(backend.object, id, {'enabled': state}, function (data) {
				$link.removeClass('loading');
				$listItem.toggleClass('invisible', state);
			})
		})
		// Delete item
		.on('click', '[data-action=delete]', function(e){
			e.preventDefault();
			
			var $link = $(this);

			$link.addClass('loading');	
			$form.find('input[type=checkbox]').prop('checked', false);
			$link.closest('.list-item').find('input[type=checkbox]').prop('checked', true);
			$form.find('select[name=action] option[value=delete]').prop('selected', true);
			
			$form.submit();
		})
		// Check all
		.on('click', '[data-action=check-all]', function(e){
			e.preventDefault();
			
			this.innerHTML = checkAll ? 'Снять все' : 'Выбрать все';
			$('input[type=checkbox]:not(:disabled)').prop('checked', checkAll);
			checkAll = !checkAll;
		});
	
}(window.jQuery));