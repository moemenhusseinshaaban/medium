require 'capybara'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome )
end

$browser = Capybara::Session.new(:chrome);Capybara.default_max_wait_time = 20
$browser.visit('https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_onmouseover')
$browser.driver.browser.switch_to.frame ("iframeResult")

def trigger_event(elem, evento)
  $browser.execute_script("$(arguments[0]).trigger(\"#{evento}\")", elem)
end

elem = $browser.find("img[onmouseover*=bigImg]")
trigger_event(elem, "mouseover")

sleep 10 # somente para ver o elemento sumindo.
