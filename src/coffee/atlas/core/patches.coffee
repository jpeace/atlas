String.prototype.capitalize = ->
  this.charAt(0).toUpperCase() + this.slice(1)

Array.prototype.last = ->
  return null if this.length is 0
  this[this.length-1]