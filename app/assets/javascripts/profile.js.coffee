# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

format_flash = (msg, type) ->
  "<div class='alert-box " + type + "'>" + msg + "</div>"

@show_flash = (msg, type) ->
  $("#flash").html(format_flash(msg, type))
             .show()
             .delay(1000)
             .fadeOut("slow")

$(document).ready ->
  $('#save').on 'click', ->
    $.ajax
      type: "PATCH",
      url: $(location).attr('pathname'),
      data: {profile: {html: $('.profile_content').html().trim()}},
      success: -> show_flash("Save successful", "notice")
      statusCode:
        401: ->
          show_flash("You need to create an account to save your profile.  <a href='/users/sign_up' style='color: white;'>Sign up</a>")
