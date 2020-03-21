require 'capybara'
require 'capybara/dsl'

# Configuracao que vai ficar no env.rb
Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :firefox

Capybara.configure do |config|
  config.app_host = "https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_open"
  config.default_max_wait_time = 30
end
#######################################

# Nossa Page usamos o DSL instancia

class TestWindows

  include Capybara::DSL

  # o visit vai ficar no step definition, uma adaptacao aqui
  def load_page
    page.visit('')
  end

  def problem_window
    # esta dentro do primeiro frame, e retorna a instancia da segunda tela
    page.within_frame('iframeResult', :visible => true) {
      $janelaq = page.window_opened_by do
        page.find('button[onclick*=myFunction]', :visible => true).click
      end
    }
    # uso a segunda tela e dou um click
    page.within_window $janelaq do
      print page.has_css? "a[href='/html/tryit.asp?filename=tryhtml_default']"
      page.find("a[href='/html/tryit.asp?filename=tryhtml_default']", visible: true).click
    end
    page.switch_to_window page.windows.first
  end
end

test = TestWindows.new
test.load_page
test.problem_window
sleep 15 # para ver na tela a mudanca.