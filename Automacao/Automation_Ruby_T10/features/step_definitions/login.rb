Dado('que eu esteja na tela de {string}') do |string|
    login.load
    #binding.pry
  end
  
  Quando('preencho o formulário de {string}') do |string|
    login.to_fill_in_login(string)
  end
  
  Quando('clico no botão {string}') do |string|
    login.click_button
  end
  
  Entao('devo ser redirecionado para tela {string}') do |string|
    login.validar_url
  end