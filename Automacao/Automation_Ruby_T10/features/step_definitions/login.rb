Dado('que eu esteja na tela de {string}') do |string|
    login.load
    #binding.pry
  end
  
  Quando('preencho o formulário de {string}') do |string|
    @login.to_fill_in_login(string)
  end
  
  Quando('clico no botão {string}') do |string|
    login.button_entrar.click()
  end
  
  Entao('devo ser redirecionado para tela {string}') do |string|
    pending # Write code here that turns the phrase above into concrete actions
  end