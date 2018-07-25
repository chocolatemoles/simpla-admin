{$wrapper=false scope=root}
<!doctype html>
<html lang="ru">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="-1">
	<title>Заказ №{$order->id}</title>
	
	<link rel="stylesheet" href="design/fonts/roboto/roboto.css">
	
	<link rel="stylesheet" href="design/css/normalize.css">
	<link rel="stylesheet" href="design/css/order-print.css">
	
	<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>
</head>
<body>
	<p class="order-id">Заказ №{$order->id}</p>
	<p class="order-date">от {$order->date|date}</p>

	<p class="company-name">{$settings->site_name}</p>
	<p class="website-url">{$config->root_url}</p>
	
	<table class="purchases">
		<thead>
			<tr>
				<td>Арт.</td>
				<td>Наименование</td>
				<td>Цена</td>
				<td>Кол-во</td>
				<td>Итого</td>
			</tr>
		</thead>
		
		<tbody>
			{foreach $purchases as $purchase}
			<tr>
				<td class="purchase-sku">
					{$purchase->sku}
				</td>
				
				<td class="purchase-name">
					{$purchase->product_name} 
					{if $purchase->variant_name} 
					<p class="purchase-variant">{$purchase->variant_name}</p>
					{/if}
				</td>
				
				<td class="purchase-price">
					{$purchase->price|convert}
				</td>
				
				<td class="purchase-amount">
					{$purchase->amount} {$settings->units}
				</td>
				
				<td class="purchase-total">
					{($purchase->price*$purchase->amount)|convert}
				</td>
			</tr>
			{/foreach}

			{if $order->delivery_price > 0 && !$order->separate_delivery}
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">{$delivery->name|escape}</td>
				<td class="purchase-total">{$order->delivery_price|convert}</td>
			</tr>
			{/if}
		</tbody>
	</table>
	
	<table class="total">
		<tbody>
			{if $order->discount>0}
				<tr>
					<td>Скидка</td>
					<td class="total-price">{$order->discount} %</td>
				</tr>
			{/if}
			
			{if $order->coupon_discount>0}
				<tr>
					<td>Купон{if $order->coupon_code} ({$order->coupon_code}){/if}</td>
					<td class="total-price">{$order->coupon_discount|convert}&nbsp;{$currency->sign}</td>
				</tr>
			{/if}
			
			<tr {if !$payment_method} class="total-row"{/if}>
				<td>Итого</td>
				<td class="total-price">{$order->total_price|convert}&nbsp;{$currency->sign}</td>
			</tr>
			
			{if $payment_method}
				<tr>
					<td>Способ оплаты</td>
					<td>{$payment_method->name}</td>
				</tr>
				
				<tr class="total-row">
					<td>К оплате</td>
					<td class="total-price">{$order->total_price|convert:$payment_method->currency_id}
						&nbsp;{$payment_currency->sign}</td>
				</tr>
			{/if}
			
			{if $order->delivery_price > 0 && $order->separate_delivery}
			<tr>
				<td>{$delivery->name|escape}</td>
				<td class="total-price">{$order->delivery_price|convert} &nbsp;{$currency->sign}</td>
			</tr>
			{/if}
		</tbody>
	</table>

	<div class="clearfix"></div>

	<table class="customer">
		<tbody>
			{if $order->name}
			<tr>
				<td>Покупатель</td>
				<td>{$order->name|escape}</td>
			</tr>
			{/if}
			{if $order->phone}
			<tr>
				<td>Телефон</td>
				<td>{$order->phone|escape}</td>
			</tr>
			{/if}
			{if $order->address}
			<tr>
				<td>Адрес</td>
				<td>{$order->address|escape}</td>
			</tr>
			{/if}
			{if $order->comment}
			<tr>
				<td>Комментарий</td>
				<td><em>{$order->comment|escape|nl2br}</em></td>
			</tr>
			{/if}
		</tbody>
	</table>

	{if $order->address}
	<div id="map"></div>
	
	<script>
		ymaps.ready(init);

		function init() {
			var myMap = new ymaps.Map('map', {
				center: [55.753994, 37.622093],
				zoom: 15
			});

			ymaps.geocode('{$order->address|escape}', {
				results: 1
			}).then(function (res) {
				var firstGeoObject = res.geoObjects.get(0),
					coords = firstGeoObject.geometry.getCoordinates(),
					bounds = firstGeoObject.properties.get('boundedBy');
					
					console.log(coords)
				myMap.geoObjects.add(firstGeoObject);

				myMap.setBounds(bounds, {
					checkZoomRange: true
				});
			});
			
			/* Поймаем событие завершения загрузки карты. */
			// Сначала мы получаем первый экземпляр коллекции слоев, потом первый слой коллекции.
			var layer = myMap.layers.get(0).get(0);
			// Отслеживаем событие окончания отрисовки тайлов.
			waitForTilesLoad(layer).then(function() {
				// Вызываем, например, печать документа window.print();
				setTimeout(function(){
					window.print(); 
				}, 1000)
				
			});
		}
			
		// Получить слой, содержащий тайлы.
		function getTileContainer(layer) {
			for (var k in layer) {
				if (layer.hasOwnProperty(k)) {
					if (
						layer[k] instanceof ymaps.layer.tileContainer.CanvasContainer
						|| layer[k] instanceof ymaps.layer.tileContainer.DomContainer
					) {
						return layer[k];
					}
				}
			}
			return null;
		}

		// Определить, все ли тайлы загружены. Возвращает Promise.
		function waitForTilesLoad(layer) {
			return new ymaps.vow.Promise(function (resolve, reject) {
				var tc = getTileContainer(layer), readyAll = true;
				tc.tiles.each(function (tile, number) {
					if (!tile.isReady()) {
						readyAll = false;
					}
				});
				if (readyAll) {
					resolve();
				} else {
					tc.events.once("ready", function() {
						resolve();
					});
				}
			});
		}
	</script>
	{else}
	<script>
		window.onload = function(){
			window.print(); 
		}
	</script>
	{/if}
</body>
</html>