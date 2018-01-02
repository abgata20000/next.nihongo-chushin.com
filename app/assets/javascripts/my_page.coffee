onPageLoad 'my_pages', ->
  window.selectColor = (elem) ->
    $this = $(elem)
    $('.color-box').removeClass('selected')
    $this.addClass('selected')
    color = $this.data('color')
    $('#user_color').val(color)

