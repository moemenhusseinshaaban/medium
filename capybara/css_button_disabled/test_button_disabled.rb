require 'capybara'
require 'capybara/dsl'

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

  include Capybara::DSL

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
          fail('O botão está desabilitado')
        else
          puts "Botão Habilitado!"
        end
    }
  end
end

test = VerificaAtributo.new
test.load_page
test.problem_button_disabled
sleep 15 # para ver na tela a mudanca.