class Base
	argsToOptions: (args) ->
		options = {}
		if args?
			for a in args.split(',')
				[key, value] = a.trim().split(':')
				options[key.trim()] = @parseOptionValue(value.trim())
		options

	parseOptionValue: (optionValue) ->
		if optionValue is 'true'
			true
		else if optionValue is 'false'
			false
		else
			optionValue