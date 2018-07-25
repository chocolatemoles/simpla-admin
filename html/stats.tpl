{$meta_title = 'Статистика' scope=root}
{$page_subtitle = 'Принятые и выполненные заказы' scope=root}

<style>
	#chart hr{
		margin: 15px 0
	}
</style>

<div id="chart"></div>

{capture name = 'scripts'}
<script src="design/js/charts/highstock.min.js"></script>
<script src="design/js/charts/modules/exporting.js"></script>

<script>
(function($){
	'use strict';
	
	$.get('ajax/stat/stat.php', function (data) {
		if(data.length == 0)
		{
			$('#chart').html($('<p>', {
				'class': 'alert',
				'text': 'Нет подходящих заказов'
			}))
			
			return false;
		}
		
		var dataChart = [];
		
		$.each(data, function(e, d){
			dataChart.push([Date.UTC(d.year, d.month - 1, d.day, 0, 0, 0), parseFloat(d.y)])
		})

		Highcharts.setOptions({
			lang: {
				loading: 'Загрузка...',
                months: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
                weekdays: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
                shortMonths: ['Янв', 'Фев', 'Март', 'Апр', 'Май', 'Июнь', 'Июль', 'Авг', 'Сент', 'Окт', 'Нояб', 'Дек'],
                exportButtonTitle: "Экспорт",
                printButtonTitle: "Печать",
                rangeSelectorFrom: "С",
                rangeSelectorTo: "По",
                rangeSelectorZoom: "Период",
                downloadPNG: 'Скачать PNG',
                downloadJPEG: 'Скачать JPEG',
                downloadPDF: 'Скачать PDF',
                downloadSVG: 'Скачать SVG',
                printChart: 'Напечатать график'
			}
		});
		
		Highcharts.stockChart('chart', {
			chart:{
				zoomType: 'x'
			},
			xAxis: {
                gridLineWidth: 1,
            },
			yAxis: {
				min: 0,
			},
			rangeSelector: {
				buttons: [{
					type: 'week',
					count: 1,
					text: 'Неделя'
				},{
					type: 'month',
					count: 1,
					text: 'Месяц'
				}, {
					type: 'year',
					count: 1,
					text: 'Год'
				}, {
					type: 'all',
					count: 1,
					text: 'Все время'
				}],
				buttonTheme: {
					width: 75
				},
				selected: 0,
				inputEnabled: false
			},
			series: [{
				type: 'areaspline',
				name: 'Сумма заказов',
				data: dataChart,
				tooltip: {
					valueDecimals: '{$currency->cents}',
					valueSuffix: ' {$currency->sign}'
				},
				marker: {
					enabled: true,
					radius: 3
				},
				fillColor: {
					linearGradient: {
						x1: 0,
						y1: 0,
						x2: 0,
						y2: 1
					},
					stops: [
						[0, Highcharts.getOptions().colors[0]],
						[1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
					]
				}
			}]
		});
	});

})(window.jQuery);
</script>
{/capture}