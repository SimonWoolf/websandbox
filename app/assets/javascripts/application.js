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
	$elem.draggable()
	return $elem;
}

var show_flash = function(msg) {
    $("#flash").html(msg).delay(500).fadeOut("slow");
};

$(function() {
  $(document).foundation();

  $('#edit_panel').draggable().resizable({resize: function(e, ui){
  	var widthChange = ui.size.width - 30
  	var heightChange = ui.size.height - 80
  	$('#edit_field_html').css({'width': widthChange , 'height': heightChange})
  }})

  $('.profile_content *').draggable({ disabled: true })

  $('#edit_button').on('click', function(e){
  	$('.profile_content').toggleClass('uneditable')
  	$(this).toggleClass('editing')
  	if($(this).hasClass('editing')){
  		$('.profile_content *').draggable('enable')
  	}else{
  		$('.profile_content *').draggable('disable')
  	}
  })
  
  $('#save').on('click', function() {
    $.ajax({
      type: "PATCH",
      url: $(location).attr('pathname'),
      data: {profile: {html: $('.profile_content').html().trim()}},
      success: function(){show_flash("<div class='alert-box round notice'>Save successful</div>")}
    });
  });

   //Only register *click* for editable elements
  var clickedElement;

	$('*').on('click', function(event){
		if($(event.target).closest('#edit_panel').length) return true;
		if($(event.target).is('html,body,.uneditable,.uneditable *,#uneditable') && $('#edit_panel').is(':visible')) {
			$('#edit_panel').hide();
		}
  })

  $('html').on('click','main', function(event){
  	console.log(event)
  	if($('.profile_content').hasClass('uneditable')){
		}else if($(event.target).is('main') || $(event.target).is('.profile_content')){
			console.log('again')
			$('#edit_panel').show()
			$('#edit_panel').css({'left': event.clientLeft + 15 + 'px' ,'top': event.offsetTop + 'px'})
			$('#edit_field_html').val(" ")
			clickedElement = $('.profile_content').append("<div id='tmp'></div>").find($('#tmp'))
		}
  })

	$('html').on('click', '*:not(html,body,main,.uneditable,.uneditable *,#uneditable)', function(event){
		console.log('edit')
		$('#edit_panel').show()
		$('#edit_panel').css({'left': event.target.clientLeft + 15 + 'px' ,'top': event.target.clientHeight + event.target.offsetTop + 'px'})
		$('#edit_field_html').val(event.target.outerHTML)
		clickedElement = event.target
	})

	$('html').on('mouseenter', '*:not(html,body,main,.uneditable,.uneditable *,#uneditable)', function(event){
		$(this).css({'border':'2px dashed red'})
	})
	$('html').on('mouseleave', '*:not(html,body,main,.uneditable,.uneditable *,#uneditable)', function(){
		$(this).css({'border':'none'})
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
