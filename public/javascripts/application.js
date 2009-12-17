// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function resizeIt() {
    var textarea_id = 'comment_body';
    var str = $(textarea_id).value;
    var cols = $(textarea_id).cols;

    var linecount = 0;
    $A(str.split("\n")).each( function(l) {
      linecount += Math.ceil( l.length / cols ); // take into account long lines
    } 
	)
  
  $(textarea_id).rows = linecount + 1;
	if(str.length >= 1999){ 
		$(textarea_id).value = str.substr(0,1999);
	 }
}

document.observe("dom:loaded",function(){  
	if ($$('.new_comment').length){
  	Event.observe('comment_body', 'keydown', resizeIt );
  	resizeIt(); //initial on load
  	$('comment_extra_field').parentNode.hide();  
  }
	if ($$('.new_contact').length){
  	$('contact_extra_field').parentNode.hide();  
  }
})


