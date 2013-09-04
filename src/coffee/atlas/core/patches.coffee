String.prototype.capitalize = ->
  this.charAt(0).toUpperCase() + this.slice(1)

String.prototype.numberWithCommas = ->
	# Stolen from http://stackoverflow.com/questions/2901102/how-to-print-a-number-with-commas-as-thousands-separators-in-javascript
	pieces = this.split(".");
	pieces[0] = pieces[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",")
	pieces.join('.')

Array.prototype.last = ->
  return null if this.length is 0
  this[this.length-1]