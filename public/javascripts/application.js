/* themes */
function set_theme(new_theme) {
	createCookie("theme", new_theme, 365);
	
	var theme_divs = ['code', 'source-numbers', 'source-code'];
	
	for (tdiv in theme_divs) {
		var classArray = $(theme_divs[tdiv]).classNames().toArray();
		
		for (var index = 0, len = classArray.size(); index < len; ++index) {
	        	$(theme_divs[tdiv]).removeClassName(classArray[index]);
		}
		
		Element.addClassName(theme_divs[tdiv], new_theme);
	}
}


/* parsers */
function set_parser(parser) {
	createCookie("parser", parser, 365);
}

function select_parser() {
	/* set our default parser */
	var par_cookie = readCookie('parser');
	
	if ( par_cookie && $('paste_parser_id') && $('paste_code').empty() ) {
		$('paste_parser_id').childElements().each( function(child) { 
			if (child.value == par_cookie) {
				child.writeAttribute('selected', 'selected');
			}
		})
	}
}

/* cookies */
function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	
	return null;
}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else expires = "";
	
	document.cookie = name+"="+value+expires+"; path=/";
}

function setupClipboard(elem_to_wire, text_elem, hover_elem) {
	ZeroClipboard.setMoviePath( '/ZeroClipboard.swf' );

	var clip = new ZeroClipboard.Client();
	clip.setHandCursor( true );
	clip.setCSSEffects( false );

	clip.setText( document.getElementById(text_elem).value );

	clip.addEventListener( 'mouseOver', function(client) {
	                                $(hover_elem).show(); 
	                        } );

	clip.addEventListener( 'mouseOut', function(client) { 
	                                $(hover_elem).hide(); 
	                        } );

	clip.glue(elem_to_wire);
}