// Translate
backend.translitUrl = function (string) {
	string = string.toLowerCase().replace(/[\s]+/gi, '-');

	var ru = ('а-б-в-ґ-г-д-е-ё-є-ж-з-и-і-ї-й-к-л-м-н-о-п-р-с-т-у-ф-х-ц-ч-ш-щ-ъ-ы-ь-э-ю-я').split('-');
	var en = ('a-b-v-g-g-d-e-e-e-zh-z-i-i-i-j-k-l-m-n-o-p-r-s-t-u-f-h-ts-ch-sh-sch--y--e-yu-ya').split('-');
	var result = '';
	
	for (var i = 0; i < string.length; i++) {
		var symbol = string.charAt(i),
			newSymbol = ru.indexOf(symbol);
		
		result += newSymbol >= 0 ? en[newSymbol] : symbol;
	}
	
	return result.replace(/[^0-9a-z_\-]+/gi, '');
};

// Inputs
backend.metaInputs = {
	$url: $('[name=url]'),
	$title: $('[name=meta_title]'),
	$keywords: $('[name=meta_keywords]'),
	$description: $('[name=meta_description]'),
}

if(backend.module == 'PageAdmin')
{
	backend.metaInputs['$name'] = $('[name=header]');
	backend.metaInputs['$menu_name'] = $('[name=name]');
}
else if(backend.module == 'ProductAdmin')
{
	backend.metaInputs['$name'] = $('[name=name]');
	backend.metaInputs['$brand']  = $('[name=brand_id]');
	backend.metaInputs['$categories'] = $('[data-form=product]').find('[name="categories[]"]');
	
	backend.metaInputs.$brand.on('change', function(){
		backend.metaSet();
	});

	backend.metaInputs.$categories.on('change', function(){
		backend.metaSet();
	});
}
else
{
	backend.metaInputs['$name'] = $('[name=name]');
}

// Generate
backend.metaGenerate = {
	keywords: function(){
		var result = backend.metaInputs.$name.val();
		
		if(backend.module == 'ProductAdmin')
		{
			var brand = backend.metaInputs.$brand.find('option:selected').data('name');
			if (typeof(brand) == 'string' && brand != '')
				result += ', ' + brand;
			
			backend.metaInputs.$categories.each(function (i, el) {
				var category = $(this).find('option:selected').data('name');
				if (typeof(category) == 'string' && category != '')
					result += ', ' + category;
			});
		}

		return result;
	},
	url: function(){
		return backend.translitUrl(backend.metaInputs.$name.val());
	}
}

// Can change
backend.metaCanChange = {
	url: (backend.metaInputs.$url.val() == backend.metaGenerate.url() || backend.metaInputs.$url.val() == '') ? true : false,
	title: (backend.metaInputs.$title.val() == backend.metaInputs.$name.val() || backend.metaInputs.$title.val() == '') ? true : false,
	keywords: (backend.metaInputs.$keywords.val() == backend.metaGenerate.keywords() || backend.metaInputs.$keywords.val() == '') ? true : false,
};

if(backend.module == 'PageAdmin')
	backend.metaCanChange['menu_name'] = (backend.metaInputs.$name.val() == backend.metaInputs.$menu_name.val() || backend.metaInputs.$menu_name.val() == '') ? true : false;

// Set change
backend.metaInputs.$url.on('change', function(){
	backend.metaCanChange.url = false;
});

backend.metaInputs.$title.on('change', function(){
	backend.metaCanChange.title = false;
});

backend.metaInputs.$keywords.on('change', function(){
	backend.metaCanChange.keywords = false;
});

backend.metaInputs.$description.on('change', function(){
	backend.metaCanChange.description = false;
});

if(backend.module == 'PageAdmin')
	backend.metaInputs.$menu_name.on('change', function(){
		backend.metaCanChange.menu_name = false;
	});

// Set
backend.metaSet = function(){
	if (this.metaCanChange.url)
		this.metaInputs.$url.val(this.metaGenerate.url);
	
	if (this.metaCanChange.title)
		this.metaInputs.$title.val(this.metaInputs.$name.val());
	
	if (this.metaCanChange.keywords)
		this.metaInputs.$keywords.val(this.metaGenerate.keywords);
	
	if (this.metaCanChange.description)
		this.metaInputs.$description.val(backend.metaDescription);
	
	if(backend.module == 'PageAdmin' && this.metaCanChange.menu_name)
		this.metaInputs.$menu_name.val(this.metaInputs.$name.val());
}

// On change name
backend.metaInputs.$name.on('keyup', function(){
	backend.metaSet();
});