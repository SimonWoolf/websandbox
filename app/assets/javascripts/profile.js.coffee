# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


show_flash = (msg) ->
  $("#flash").html(msg).show().delay(500).fadeOut("slow")

$ ->
  $('#save').on 'click', ->
    $.ajax
      type: "PATCH",
      url: $(location).attr('pathname'),
      data: {profile: {html: $('.profile_content').html().trim()}},
      success: -> show_flash("<div class='alert-box round notice'>Save successful</div>")
