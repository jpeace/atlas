Builder = require 'atlas/dom/builder'
Events = require 'atlas/dom/events'
ElementWrapper = require 'atlas/dom/element_wrapper'

atlas.export 'dom',
	eventsToVerbs : 
    click : 'Clicked'
    dblclick : 'DoubleClicked'
    focus : 'GotFocus'
    blur : 'LostFocus'

domFunction = (arg) ->
  if typeof arg is 'string'
    new Builder(window.document).createElement(arg)
  else if _.isFunction(arg)
    Events.domReady(window, arg)
  else if arg instanceof Element
    new ElementWrapper(arg)
  else
    throw new Error("Unrecognized argument to DOM function #{arg}")

(exports ? this).__$ = domFunction