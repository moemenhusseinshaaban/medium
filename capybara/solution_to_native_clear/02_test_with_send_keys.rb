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
    count = 0
    begin
      element01 = $browser.find('div[name="fname"]', :visible => true)
      element02 = $browser.find('div[name="lname"]', :visible => true)
      element01.native.clear
      element01.send_keys "test 1"
      element02.native.clear
      element02.send_keys "test 2"
    rescue => ex
        print ex
    end
    }
end

problema_do_clean
sleep 15 # para ver na tela a mudanca.
