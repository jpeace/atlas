require 'atlas/bootstrap'
(exports ? this).tests =
  dom: {},
  bindings: {},
  integration: {}

String.prototype.stripWhitespace = ->
	this.replace(/(\t|\r|\n)/g, '')