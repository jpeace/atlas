Base = require 'atlas/binding/formatters/base'

class NumberFormatter extends Base
	canFormat: (value, args) ->
		_.isNumber(value)

	currency: (value, args) ->
		options = @argsToOptions(args)
		
		cents = options.cents ? true
		commas = options.commas ? true
		symbol = options.symbol ? '$'
		postfix = options.postfix ? false

		formatted = if cents then value.toFixed(2) else value.toFixed(0)
		formatted = formatted.numberWithCommas() if commas
		if postfix
			"#{formatted}#{symbol}"
		else
			"#{symbol}#{formatted}"

	parseCurrency: (string, args) ->
		options = @argsToOptions(args)
		symbol = options.symbol ? '$'
		parseFloat(string.replace(symbol,'','g').replace(/,/g,''))

return NumberFormatter