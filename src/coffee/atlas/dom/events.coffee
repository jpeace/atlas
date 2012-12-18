class Events
  constructor: (@element) ->

  addEvent: (event, fn) ->
    if @element.addEventListener
      @element.addEventListener(event, fn, false)
    else if @element.attachEvent
      @element.attachEvent("on#{event}", fn);
    else
      old = if @element["on#{event}"]? then @element["on#{event}"] else ->
      @element["on#{event}"] = (e) ->
        unless e?
          e = window.event;
        old.call(this, e);
        fn.call(this, e);

  this.domReady = (win, fn) ->
    # Taken from Diego Perini's contentloaded at https://github.com/dperini/ContentLoaded/blob/master/src/contentloaded.js
    done = false
    top = true
    doc = win.document
    root = doc.documentElement

    add = if doc.addEventListener? then 'addEventListener' else 'attachEvent'
    rem = if doc.addEventListener? then 'removeEventListener' else 'detachEvent'
    pre = if doc.addEventListener? then '' else 'on'

    init = (e) ->
      return if e.type is 'readystatechange' and doc.readyState isnt 'complete'
      (if e.type is 'load' then win else doc)[rem](pre + e.type, init, false)
      if !done && (done = true) 
        fn.call(win, e.type || e)
  
    poll = ->
      try
        root.doScroll('left')
      catch e
        setTimeout(poll, 50) 
        return
      init('poll')
  
    if doc.readyState is 'complete' 
      fn.call(win, 'lazy')
    else
      if doc.createEventObject and root.doScroll 
        try
          top = !win.frameElement
        catch e
        poll() if top
  
    doc[add](pre + 'DOMContentLoaded', init, false)
    doc[add](pre + 'readystatechange', init, false)
    win[add](pre + 'load', init, false)
  
return Events