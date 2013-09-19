efs = tests.dom.elementFromString

atlas.presenters.UserDetails =
  class UserDetails extends atlas.core.Presenter
    init: ->
      @message = ''
      @user =
        name: 'Joe Blow'
        age: 45
        money: 350.45
        friends: [{name:'Rob'},{name:'Bob'}]
        agePhrase: ->
          if @age > 50 then 'too old!' else 'too dumb!' 
      @bind()   

    model: ->
      user: @user
      message: @message

    change: (name, age) ->
      @user.name = name
      @user.age = age
      @bind()

    update: ->
      @read()
      @bind()

    changeClicked: =>
      @read()
      @message = 'Changed!'
      @bind()

    friendClicked: (eventInfo) =>
      friend = eventInfo.item
      @read()
      @message = friend.name
      @bind()

viewHtml =  """
              <div data-presenter="UserDetails">
                <div data-bind="user">
                  <input id="name" type="text" data-bind="name"></input>
                  <input id="age" type="text" data-bind="age"></input>
                  <span id="money" data-bind="money" data-format="number.currency"></span>
                  You are <span id="phrase" data-bind="agePhrase"></span>
                  <button id="change" data-name="change">Change It!</button>
                  <ul data-bind="friends as collection">
                    <li>
                      <button data-bind="name" data-name="friend"></button>
                    </li>
                  </ul>
                </div>
              </div>
            """

Bootstrapper = require 'atlas/bootstrap'

tests.integration.getEnvironment = ->
  root = efs(viewHtml)
  bootstrapper = new Bootstrapper(root).bootstrap()

  inputs = (i for i in root.getElementsByTagName('input'))
  buttons = (b for b in root.getElementsByTagName('button'))
  spans = (s for s in root.getElementsByTagName('span'))

  {
    userDetailsPresenter: bootstrapper.presenters[0],

    nameInput: _.find(inputs, (i) -> i.id is 'name'),
    ageInput: _.find(inputs, (i) -> i.id is 'age'),
    changeButton: _.find(buttons, (b) -> b.id is 'change'),
    friendButtons: _.filter(buttons, (b) -> b.getAttribute('data-name') is 'friend'),
    moneySpan: _.find(spans, (s) -> s.id is 'money'),
    phraseSpan: _.find(spans, (s) -> s.id is 'phrase'),
  }