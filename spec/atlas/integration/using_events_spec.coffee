describe 'Using events in presenters', ->  
  createEvent = tests.dom.createEvent

  it 'executes events properly', ->
    env = tests.integration.getEnvironment()
    expect(env.userDetailsPresenter.message).toBe('')
    env.changeButton.dispatchEvent(createEvent('click'))
    expect(env.userDetailsPresenter.message).toBe('Changed!')

  it 'executes collection events properly', ->
    env = tests.integration.getEnvironment()
    expect(env.userDetailsPresenter.message).toBe('')
    friendButtons = env.friendButtons

    friendButtons[0].dispatchEvent(createEvent('click'))
    expect(env.userDetailsPresenter.message).toBe('Rob')

    friendButtons[1].dispatchEvent(createEvent('click'))
    expect(env.userDetailsPresenter.message).toBe('Bob')