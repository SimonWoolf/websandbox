// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

function updateHTML(text, clickedElement){
	$elem = $(text)
	$(clickedElement).replaceWith($elem)
	return $elem;
}

$(function() {
  $(document).foundation();

  $('#edit_button').on('click', function(e){
  	$('.profile_content').toggleClass('uneditable')
  })

  // Only register *click* for editable elements
  var clickedElement;

	$('*').on('click', function(event){
		if($(event.target).closest('#edit_panel').length) return true;
		if($(event.target).is('html,body,.uneditable,.uneditable *,#uneditable') && $('#edit_panel').is(':visible')) {
			$('#edit_panel').hide();
		}	
  })

	$('html').on('click', '*:not(html,body,.uneditable,.uneditable *,#uneditable)', function(event){
		console.log('clicked')
		console.log('other')
		console.log('edit')
		console.log(event)
		$('#edit_panel').show()

		$('#edit_panel').css({'left': event.target.clientLeft + 15 + 'px' ,'top': event.target.clientHeight + event.target.offsetTop + 'px'})
		$('#edit_field_html').val(event.target.outerHTML)
		clickedElement = event.target
	})

	$('#edit_field_html').on('keydown',function(pressed){
		if(pressed.keyCode == 13){
			pressed.preventDefault()
			var text = $('#edit_field_html').val()
			clickedElement = updateHTML(text, clickedElement)[0];
			$('#edit_panel').hide();
		}else if(pressed.keyCode == 27){
			$('#edit_panel').hide();
		}else if(pressed.keyCode == 8 && pressed.shiftKey){
			$('#edit_field_html').val("");
			clickedElement = updateHTML("", clickedElement)[0];
		}
	})

});
