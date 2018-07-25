(function($){
	'use strict';
	
	if(backend.module == 'PageAdmin')
		var firstTextarea = 'body';
	else if(backend.module == 'BrandAdmin' || backend.module == 'CategoryAdmin')
		var firstTextarea = 'description';
	else if(backend.module == 'ProductAdmin' || backend.module == 'PageAdmin')
		var firstTextarea = 'annotation';

	if(typeof(firstTextarea) !== 'undefined')
	{
		backend.metaDescription = $('[name=' + firstTextarea + ']').val()
			.replace(/(<([^>]+)>)/ig, " ")
			.replace(/(\&nbsp;)/ig, " ")
			.replace(/\s+/ig, " ")
			.replace(/^\s+|\s+$|\r|\n/g, '')
			.substr(0, 512);

		backend.metaCanChange['description'] = (backend.metaInputs.$description.val() == backend.metaDescription || backend.metaInputs.$description.val() == '') ? true : false;
	}
	
	tinymce.init({
		selector: '.js-editor',
		language: 'ru',
		skin: "lightgray",
		plugins: [
			'advlist autolink lists link image charmap print preview hr wordcount',
			'textcolor colorpicker nonbreaking',
			'searchreplace visualblocks code fullscreen',
			'insertdatetime media table paste autosave visualchars'
		],
		toolbar: [
			'undo redo | formatselect | forecolor backcolor | bold italic \
			| alignleft aligncenter alignright alignjustify \
			| bullist numlist outdent indent | link unlink image | visualblocks visualchars removeformat code | fullscreen'
		],
		content_css: ['design/fonts/roboto/roboto.css'],
		file_picker_callback : function (callback, value, meta) {
			tinymce.activeEditor.windowManager.open({
				file: 'design/js/elFinder/elfinder.html',
				title: 'elFinder 2.1',
				width: 900,  
				height: 450
			}, {
				oninsert: function (file, fm) {
					callback('../files/' + file.path);
				}
			});
		
			return false;
		},
		setup: function (editor) {
			editor.on('keyup paste change', function (e) {
				if(editor.id == firstTextarea)
				{
					backend.metaDescription = editor
						.getContent()
						.replace(/(<([^>]+)>)/ig, " ")
						.replace(/(\&nbsp;)/ig, " ")
						.replace(/\s+/ig, " ")
						.replace(/^\s+|\s+$|\r|\n/g, '')
						.substr(0, 512);
						
					backend.metaSet();
				}
			});
		}
	});
})(window.jQuery);