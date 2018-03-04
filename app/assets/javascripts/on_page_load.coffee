# ネームスペースに対応した個別jsファイルローダー
@onPageLoad = (classes, callback) ->
  # $(document).on 'turbolinks:load', ->
  $(document).ready ->
    conditions = regularize(classes)
    unless conditions
      console.error '[onPageLoad] Unexpected arguments!'
      return

    conditions.forEach (a_classes) ->
      callback() if isOnPage(a_classes)

regularize = (classes) ->
  if typeof(classes) == 'string'
    [classes]
  else if Object.prototype.toString.call(classes).includes('Array')
    classes
  else
    null

isOnPage = (classes) ->
  $('body').hasClass(classes)
