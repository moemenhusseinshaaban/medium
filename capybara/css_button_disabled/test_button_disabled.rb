require 'capybara'
require 'capybara/dsl'
require 'rspec'

# Configuracao que vai ficar no env.rb
Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :firefox

Capybara.configure do |config|
  value = Array.new ["https://www.w3schools.com/code/tryit.asp?filename=GIXO5GOVQYJF",
                "https://www.w3schools.com/code/tryit.asp?filename=GIXNIA4Z7H1S"]
  puts value.sample.to_s
  config.app_host = value.sample.to_s
  config.default_max_wait_time = 30
end

#######################################

# Nossa Page usamos o DSL instancia

class VerificaAtributo

  ###
  # https://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element
  # disabled?

  include Capybara::DSL
  include RSpec::Matchers

  # o visit vai ficar no step definition, uma adaptacao aqui
  def load_page
    page.visit('')
  end

  def problem_button_disabled
    # esta dentro do primeiro frame, e retorna a instancia da segunda tela
    page.find('button',text: "Run »").click
    page.within_frame('iframeResult', :visible => true) {

        button = page.find('button[type="button"][id="12345"]', :visible => true)
        if button.disabled?
          puts "O botão está desabilitado"
        else
          puts "Botão Habilitado!"
        end

        # Sem precisa usar o find, posso usar o has_css? ou has_select? para validar o disabled no meu assert.
        p has_css = page.has_css?('button[type="button"][id="12345"][disabled]')
        expect(has_css).to be_truthy, "Esperado encontrar o elemento! Resultado: #{has_css.inspect}"

        p has_selector = page.has_selector?('button[type="button"][id="12345"][disabled]')
        expect(has_selector).to be_falsey, "Esperado Não encontrar o elemento! Resultado: #{has_selector.inspect}"
    }
  end
end

test = VerificaAtributo.new
test.load_page
test.problem_button_disabled
sleep 15 # para ver na tela a mudanca.
