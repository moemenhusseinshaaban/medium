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
      $primeira_janela = page.current_window
      $segunda_janela = page.window_opened_by do
        page.find('button[onclick*=myFunction]', :visible => true).click
      end
    }
    # uso a segunda tela e dou um click
    page.within_window $segunda_janela do
      puts "Segunda tela usando: #{page.has_text? "LEARN HTML"}"
      # abre uma terceira janela
      page.find("a[href='/html/tryit.asp?filename=tryhtml_default']", visible: true).click
    end
    until_window(3)
    puts "Fecha a terceira janela" # sem o contador iria gerar erro
    page.switch_to_window page.windows.last
    page.windows.last.close # fecha a terceira janela
    page.switch_to_window $primeira_janela
  end

  def until_window(x, count_value = 4)
    count = 0
    until count > count_value
      puts page.windows.count
      break if page.windows.count == x
      sleep 1; count += 1
    end
  end
end

test = TestWindows.new
test.load_page
test.problem_window
sleep 15 # para ver na tela a mudanca.