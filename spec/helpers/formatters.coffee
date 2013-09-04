class TestFormatter
	canFormat: (value) ->
		_.isString(value)

	emphasize: (value, args) ->
		args ?= "!"
		"#{value}#{args}"

atlas.addFormatter 'test', TestFormatter