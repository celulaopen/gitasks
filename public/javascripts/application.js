$(document).ready(function() {

	if ($('footer').length) {
		content_heigh_value();
		$(window).resize(function() {
			content_heigh_value();
		});
	}
	
	//Zebra Tables
	$(".zebra").delegate("tr", "hover", function(){ 
	  $(this).children('.edit').toggleClass("edithover");
		$(this).toggleClass("trhover");
	});
	
	//Buttons eventes functions
	$('a.minibutton').bind({
    mousedown: function() {
      $(this).addClass('mousedown');
    },
    blur: function() {
      $(this).removeClass('mousedown');
    },
    mouseup: function() {
      $(this).removeClass('mousedown');
    }
  });
	
});

var content_heigh_value = function(){
	var height_header = $("header").height(); 
	var height_footer = $("footer").height();
	var height_body = $(window).height();
	var padding_value_on_css = 60; //padding of footer and self content tag
	var height_value = height_body - ( height_footer + height_header ) - padding_value_on_css;
	$("#content").height(height_value);	
}

var show_overlayer = function(){
	$('#overlay').css({
		height:	$(document).height(),
		opacity: '0.6'
	});
	$('#overlay').show();
}
var hide_overlayer = function(){
	$('#overlay').hide();
}

var disable_context_menu = function() {
	$(document).bind("contextmenu",function(e){  
		return false;  
	});
};

//------------------------------------------------------------------------------------------------------
//	FUNÇÃO PARA DESABILITAR O ENTER E O BACKSPACE
//------------------------------------------------------------------------------------------------------
function dasabilitarenter(){

    if (typeof window.event != 'undefined') // IE
        document.onkeydown = function() // IE
        {
            var t = event.srcElement.type;
            var kc = event.keyCode;
            return ((kc != 8 && kc != 13 && kc != 27) || (t == 'text' && kc != 13 && kc != 27) ||
            (t == 'textarea' && kc != 27) ||
            (t == 'button' && kc == 13) ||
            (t == 'submit' && kc == 13) ||
            (t == 'password' && kc != 27 && kc != 13) ||
            (t == '' && kc == 13))
        }
    else 
        document.onkeypress = function(e) // FireFox
        {
            var t = e.target.type;
            var kc = e.keyCode;
            if ((kc != 8 && kc != 13 && kc != 27) || (t == 'text' && kc != 13 && kc != 27) ||
            (t == 'textarea' && kc != 27) ||
            (t == 'button' && kc == 13) ||
            (t == 'submit' && kc == 13) ||
            (t == 'password' && kc != 27 && kc != 13) ||
            (t == '' && kc == 13)) 
                return true
            else {
                return false
            }
        }
}
