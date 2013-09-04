describe 'Binding and reading in presenters', ->

  efs = tests.dom.elementFromString

  atlas.presenters.UserDetails =
    class UserDetails extends atlas.core.Presenter
      init: ->
        @user =
          name: 'Joe Blow'
          age: 45
          money: 350.45
          agePhrase: ->
            if @age > 50 then 'too old!' else 'too dumb!'    

      model: ->
        user: @user

      change: (name, age) ->
        @user.name = name
        @user.age = age
        @bind()

      update: ->
        @read()
        @bind()

  viewHtml =  """
                <div data-presenter="UserDetails">
                  <p data-bind="user">
                    <input id="name" type="text" data-bind="name"></input>
                    <input id="age" type="text" data-bind="age"></input>
                    <span id="money" data-bind="money" data-format="number.currency"></span>
                    You are <span id="phrase" data-bind="agePhrase"></span>
                  </p>
                </div>
              """

  Bootstrapper = require 'atlas/bootstrap'

  root = efs(viewHtml)
  inputs = (i for i in root.getElementsByTagName('input'))
  spans = (s for s in root.getElementsByTagName('span'))

  bootstrapper = new Bootstrapper(root).bootstrap()
  userDetails = _.find(bootstrapper.presenters, (p) -> p.name is 'UserDetails')

  nameInput = _.find(inputs, (i) -> i.id is 'name')
  ageInput = _.find(inputs, (i) -> i.id is 'age')
  moneySpan = _.find(spans, (s) -> s.id is 'money')
  phraseSpan = _.find(spans, (s) -> s.id is 'phrase')

  it 'correctly binds', ->
    userDetails.change('Jim Slim', 30)
    expect(nameInput.value).toBe('Jim Slim')
    expect(ageInput.value).toBe('30')
    expect(moneySpan.textContent).toBe('$350.45')
    expect(phraseSpan.textContent).toBe('too dumb!')
    userDetails.change('', 65)
    expect(phraseSpan.textContent).toBe('too old!')

  it 'correctly reads', ->
    nameInput.value = 'New Name'
    ageInput.value = '40'
    moneySpan.innerHTML = '$525.25'
    userDetails.update()
    expect(userDetails.user.name).toBe('New Name')
    expect(userDetails.user.age).toBe(40)
    expect(userDetails.user.money).toBe(525.25)
    expect(phraseSpan.textContent).toBe('too dumb!')
    ageInput.value = '60'
    userDetails.update()
    expect(phraseSpan.textContent).toBe('too old!')