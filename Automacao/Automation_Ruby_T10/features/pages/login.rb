class Login < SitePrism::Page
    include RSpec::Matchers
    include Capybara::DSL

    set_url '/login'
    element :mail, '#email' 
    element :password, '#password' 
    element :button_entrar, '#entrar' 
    
    def to_fill_in_login(string)
        mail.set 'sidmoreira.hp@gmail.com'
        password.set 'TESTE@postman123'
    end
end