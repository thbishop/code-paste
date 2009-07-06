// this will set our theme as desired
function set_theme(new_theme) {
	var theme_divs = ['code', 'source-numbers', 'source-code'];
	
	for (tdiv in theme_divs) {
		var classArray = $(theme_divs[tdiv]).classNames().toArray();
		
		for (var index = 0, len = classArray.size(); index < len; ++index) {
	        	$(theme_divs[tdiv]).removeClassName(classArray[index]);
		}
		
		Element.addClassName(theme_divs[tdiv], new_theme);
	}
}