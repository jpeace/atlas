require 'atlas/bootstrap'
(exports ? this).tests =
  dom: {},
  bindings: {}

String.prototype.stripWhitespace = ->
	this.replace(/(\t|\r|\n)/g, '')