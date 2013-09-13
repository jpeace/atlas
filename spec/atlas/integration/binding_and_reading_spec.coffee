describe 'Binding and reading in presenters', ->
  it 'correctly binds', ->
    env = tests.integration.getEnvironment()
    env.userDetailsPresenter.change('Jim Slim', 30)
    expect(env.nameInput.value).toBe('Jim Slim')
    expect(env.ageInput.value).toBe('30')
    expect(env.moneySpan.textContent).toBe('$350.45')
    expect(env.phraseSpan.textContent).toBe('too dumb!')
    env.userDetailsPresenter.change('', 65)
    expect(env.phraseSpan.textContent).toBe('too old!')

  it 'correctly reads', ->
    env = tests.integration.getEnvironment()
    env.nameInput.value = 'New Name'
    env.ageInput.value = '40'
    env.moneySpan.innerHTML = '$525.25'
    env.userDetailsPresenter.update()
    expect(env.userDetailsPresenter.user.name).toBe('New Name')
    expect(env.userDetailsPresenter.user.age).toBe(40)
    expect(env.userDetailsPresenter.user.money).toBe(525.25)
    expect(env.phraseSpan.textContent).toBe('too dumb!')
    env.ageInput.value = '60'
    env.userDetailsPresenter.update()
    expect(env.phraseSpan.textContent).toBe('too old!')