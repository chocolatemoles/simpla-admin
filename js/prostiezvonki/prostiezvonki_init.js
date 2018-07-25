(function($){
	'use strict';
	
	var $pzPopup = $('.pz-popup');
	
	function setNotice(message) {
		console.log(message)
		$pzPopup.html(message).addClass('visible');
	}
	
	// Простые звонки
	pz.setUserPhone(pzConfig.phone);
	
	pz.connect({
		client_id: pzConfig.password,
		client_type: pzConfig.type,
		host: pzConfig.server
	});

	$('.js-ip-call').on('click', function (e) {
		e.preventDefault();
		
		var phone = $(this).data('phone').trim();
		
		pz.call(phone);
	});

	pz.onEvent(function (event) {
		if (event.isIncoming())
		{
			$.ajax({
				type: 'GET',
				url: 'ajax/search_orders.php',
				data: {
					keyword: event.from,
					limit: '1'
				},
				dataType: 'json'
			}).success(function (data) {
				if (event.to == pzConfig.phone)
				{
					if (data.length > 0)
					{
						setNotice('Звонит <a href="index.php?module=OrderAdmin&id=' + data[0].id + '">' + data[0].name + '</a>');
					}
					else
					{
						setNotice('Звонок с ' + event.from + ' <a href="index.php?module=OrderAdmin&phone=' + event.from + '">Создать заказ</a>');
					};
				};
			});
		};
	});

})(window.jQuery);