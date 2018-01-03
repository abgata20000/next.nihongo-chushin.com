$(document).on 'turbolinks:load', ->
  setTimeout ->
    $('.notice-message').fadeOut('slow');
  , 3000

