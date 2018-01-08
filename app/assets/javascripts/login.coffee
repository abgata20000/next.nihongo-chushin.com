onPageLoad 'sessions', ->
  window.selectIcon = (elem) ->
    $this = $(elem)
    $('.icon').removeClass('selected')
    $this.addClass('selected')
    icon = $this.data('icon')
    $('#user_session_icon').val(icon)

  window.showSecretIcons = () ->
    $('.secret').css('display', 'inline-block')
