# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Append timezone=<timezone> to each booking URL
$(document).on 'change', '#set-timezone_', () ->
  $.each $(".available"), (t) ->
    $this = $(this)
    _href = $this.attr('href')

    timezone = $('#set-timezone_').val()

    localized_url = _href.replace(/&timezone=[^&]*&?/, '&').replace(/&+$/, '')

    $this.attr("href", localized_url + '&timezone=' + encodeURIComponent(timezone))

#
$(document).on 'click', '#set-timezone_', () ->
  $.each $(".available"), (t) ->
    $this = $(this)
    _href = $this.attr('href')

    timezone = $('#set-timezone_').val()

    localized_url = _href.replace(/&timezone=[^&]*&?/, '&').replace(/&+$/, '')

    $this.attr("href", localized_url + '&timezone=' + encodeURIComponent(timezone))


$(document).on 'load', '#set-timezone_', () ->
  $.each $(".available"), (t) ->
    $this = $(this)
    _href = $this.attr('href')

    timezone = $('#set-timezone_').val()

    localized_url = _href.replace(/&timezone=[^&]*&?/, '&').replace(/&+$/, '')
    $this.attr("href", localized_url + '&timezone=' + encodeURIComponent(timezone))

$(document).on 'change', '#conversation_timezone', () ->
  "X"

$(document).on 'load', '#start_time_time_component', () ->
  "y"
