class Login < SitePrism::Page
    include RSpec::Matchers
    include Capybara::DSL

    set_url '/login'
    element :mail, '#email' 
    element :password, '#password' 
    element :button_entrar, '#entrar'
    element :sair, :xpath, '//button[text()="Sair"]'
    
    def to_fill_in_login(string)
        mail.set 'palagio@palagio.com'
        password.set 'Ga123@'
    end

    def click_button()
        button_entrar.click()
    end

    def validar_url
        expect(page).to have_current_path('https://next.qacoders-academy.com.br/home', url: true)
        expect(page).to have_content('Sair')
    end
end

#palagio@palagio.com
#Ga123@