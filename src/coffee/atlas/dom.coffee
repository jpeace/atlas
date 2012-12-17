Search = require 'atlas/dom/search'
Builder = require 'atlas/dom/builder'
Events = require 'atlas/dom/events'

domFunction = (arg) ->
  if typeof arg is 'string'
    new Builder(window.document).createElement(arg)
  else if _.isFunction(arg)
    Events.domReady(window, arg)
  else if arg instanceof Element
    new Search(arg)
  else
    throw new Error("Unrecognized argument to DOM function #{arg}")

(exports ? this).__$ = domFunction