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
  var $elem = $(text);
  if($elem.length > 1) {
    show_flash("One tag only", "warning");
  } else {
    $(clickedElement).replaceWith($elem);
    $elem.draggable();
    return $elem;
  }
}

function updateFromFieldsAndHidePanel(clickedElement){
  var text = $('#edit_field_html').val();
  var css = $('#edit_field_css').val();
  clickedElement = updateHTML(text, clickedElement)[0];
  $(clickedElement).attr('style', css);
  $('#edit_panel').hide();
}

$(function() {
  $(document).foundation();

  $('#edit_panel').draggable();

  $('.profile_content *').draggable({ disabled: true });

  $('#edit_button').on('click', function(){
    $('#grid-background').fadeToggle('slow');
    $('.profile_content').toggleClass('uneditable');
    $(this).toggleClass('editing');
    if($(this).hasClass('editing')){
      $(this).html('Stop editing');
      $('.profile_content *').draggable('enable');
    }else{
      $(this).html('Edit');
      $('.profile_content *').draggable('disable');
    }
  });

   //Only register *click* for editable elements
  var clickedElement;
  var uneditable = 'html,body,.uneditable,.uneditable *,#uneditable';
  var editable = '*:not(' + uneditable + ')';

	$('*').on('click', function(event){
		if($(event.target).closest('#edit_panel').length) {return true;}
		if($(event.target).is(uneditable) && $('#edit_panel').is(':visible')) {
			updateFromFieldsAndHidePanel(clickedElement);
		}
  });

  $('.profile_content').on('click', editable, function(event){
    console.log(event.target.outerHTML);
    $('#edit_panel').show();
    $('#edit_panel').css({'left': event.target.clientLeft + 15 + 'px',
                          'top': event.target.clientHeight + event.target.offsetTop + 'px'});
    $('#edit_field_css').val($(event.target)
                             .attr('style')
                             .replace(/;\s?/g, ";\n") //put newlines after semicolons in css
                            );
    $('#edit_field_html').val($(event.target)
                              .clone() // so that style isn't dropped from the preview html
                              .removeAttr("style")
                              .prop('outerHTML')
                             );
    clickedElement = event.target;
  });

  $('.profile_content').on('mouseenter', editable, function(){
    $(this).css({'border':'2px dashed red'});
  });
  $('.profile_content').on('mouseleave', editable, function(){
    $(this).css({'border':'none'});
  });

  $('#edit_field_html,#edit_field_css').on('keydown',function(pressed){
    if(pressed.keyCode === 13 && pressed.shiftKey){ // shift+enter
      // do not override -- so can use this to insert a newline
    }else if(pressed.keyCode === 13){ //enter
      pressed.preventDefault();
      updateFromFieldsAndHidePanel(clickedElement);
    }else if(pressed.keyCode === 27){ //Esc
      $('#edit_panel').hide();
    }else if(pressed.keyCode === 8 && pressed.shiftKey){ //shift+backspace
      $('#edit_field_html').val("");
      clickedElement = updateHTML("", clickedElement)[0];
    }
  });

});
