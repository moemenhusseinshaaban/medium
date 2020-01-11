require 'capybara'

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_max_wait_time = 15
$browser = Capybara::Session.new(:firefox)
$browser.visit("https://www.w3schools.com/code/tryit.asp?filename=GASWGTGYEHKK")

def problema_do_clean

  $browser.first('button', :text => 'Run »', :visible => true).click
  $browser.within_frame('iframeResult', :visible=>true){
    begin
      element01 = $browser.find('input[name="fname"]', :visible => true)
      element02 = $browser.find('input[name="lname"]', :visible => true)
      element01.set "test 1"
      element02.set "test 2"
    rescue => ex
        print ex
    end
    }
end

problema_do_clean
sleep 15 # para ver na tela a mudanca.
