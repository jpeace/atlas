class NumberFormatter extends atlas.binding.formatters.Base
	canFormat: (value, args) ->
		_.isNumber(value)

	canParse: (string, args) ->
		_.isString(string)

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

atlas.addFormatter 'number', NumberFormatter