class DefaultText
  configure: (@element, arg) ->
    ew = __$(@element)
    @defaultText = arg
    @hasEnteredValue = false

    ew.addEvent('blur', @blur)
    ew.addEvent('focus', @focus)
    @blur()

  blur: =>
    if !@element.value? or @element.value is ''
      ew = __$(@element)
      ew.addClass('atlas-default-text')
      @element.value = @defaultText
      @hasEnteredValue = false
    else
      @hasEnteredValue = true

  focus: =>
    ew = __$(@element)
    ew.removeClass('atlas-default-text')
    unless @hasEnteredValue
      @element.value = ''

return DefaultText