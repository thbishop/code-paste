// this will set our theme as desired
function set_theme(new_theme) {
	var classArray = $('code').classNames().toArray();

    for (var index = 0, len = classArray.size(); index < len; ++index) {
        $('code').removeClassName(classArray[index]);
	}
	
	Element.addClassName('code', new_theme);
	
	
	
	var classArray = $('source-numbers').classNames().toArray();

    for (var index = 0, len = classArray.size(); index < len; ++index) {
        $('source-numbers').removeClassName(classArray[index]);
	}
	
	Element.addClassName('source-numbers', new_theme);
	
	
	
	var classArray = $('source-code').classNames().toArray();

    for (var index = 0, len = classArray.size(); index < len; ++index) {
        $('source-code').removeClassName(classArray[index]);
	}
	
	Element.addClassName('source-code', new_theme);
}