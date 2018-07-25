(function($){
	'use strict';
	
	$(document).ready(function(){
		var $tabsSet = $('.tabs');
	
		$tabsSet.each(function(){
			var $tabs = $(this),
				$tabsNav = $tabs.find('.tabs-nav'),
				$tabsContent = $tabs.find('.tabs-content');

			$tabsNav.on('click', 'button', function(e){
				e.preventDefault();
				
				var $tabBtn = $(this);
				
				if( !$tabBtn.hasClass('active') ) {
					var tabTarget = $tabBtn.data('target'),
						$tabSelected = $tabsContent.find('[data-content="' + tabTarget + '"]');
					
					$tabBtn.addClass('active').siblings('.tabs-btn').removeClass('active');
					$tabSelected.addClass('active').siblings('.tabs-tab').removeClass('active');
				}
			});
		});
	});
})(window.jQuery);