require 'capybara'
require 'selenium-webdriver'

module CapybaraExtension
  def jquery(event)
    base.jquery(event)
  end
end

module CapybaraSeleniumExtension
  def jquery(evento)
    dir_atual = File.expand_path File.dirname(__FILE__) # pega o caminho do arquivo
    js = File.read("#{dir_atual}/jquery.min.js") # ler o arquivo jquery
    driver.execute_script(js)
    driver.execute_script("$(arguments[0]).trigger(\"#{evento}\")", native)
  end
end

# importando minha funcao para dentro do framework
::Capybara::Selenium::Node.send :include, CapybaraSeleniumExtension
::Capybara::Node::Element.send :include, CapybaraExtension

# criando uma instancia do browser separada pra usar, assim como o selenium faz
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome )
end
$browser = Capybara::Session.new(:chrome); Capybara.default_max_wait_time = 20
$browser.visit('https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_onmouseover')

# mudo o frame que esta focado na tela, para o frame que desejo usar
$browser.within_frame(0){
  $browser.find("img[onmouseover*=bigImg]").jquery("mouseover") # funcao jquery na mesma linha do find do capybara
}

sleep 15 # mostrar o mouse sobre o elemento