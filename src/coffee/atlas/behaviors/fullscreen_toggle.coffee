class FullscreenToggle
  configure: (@element, arg) ->
    ew = __$(@element).addEvent('click', @toggle)
    
  toggle: =>
    if document.webkitFullscreenElement
      document.webkitCancelFullScreen()
    else
      document.documentElement.webkitRequestFullScreen();

return FullscreenToggle