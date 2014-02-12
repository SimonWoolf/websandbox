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
      type: "PUT",
      url: $(location).attr('pathname'),
      data: {profile: {html: $('.profile_content').html().trim()}},
      success: ->
        show_flash("Save successful", "notice")
      complete: (resp) ->
        console.log(JSON.stringify(resp))
      statusCode:
        401: ->
          $('#signUpModal').foundation('reveal', 'open')
        403: ->
          show_flash("You are on a stranger's profile. You need to be their friend before you can edit their profile.", "alert")
