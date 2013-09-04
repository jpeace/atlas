require 'atlas/binding'

getFormatter = ->
	new atlas.formatters.number()

describe 'Number formatter', ->
	describe 'when formatting currency', ->
		it 'defaults to displaying commas and cents', ->
			expect(getFormatter().currency(1423)).toBe('$1,423.00')

		it 'can turn off cents', ->
			expect(getFormatter().currency(1423, 'cents:false')).toBe('$1,423')

		it 'can turn off commas', ->
			expect(getFormatter().currency(1423.54, 'commas:false')).toBe('$1423.54')

		it 'can change the currency symbol', ->
			expect(getFormatter().currency(54, 'symbol:¢, postfix:true, cents:false')).toBe('54¢')

	describe 'when parsing currency', ->
		it 'handles commas and currency symbols', ->
			expect(getFormatter().parseCurrency('$1,253,221.51')).toBe(1253221.51)