require 'rspec'
require 'selenium-webdriver'

describe 'Ruby RSpec Examples' do

  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://www.wunderlist.com"
    @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
  end

  after(:each) do
    logout
    @driver.quit
  end

  def login
    @driver.get @base_url + "/login"
    @wait.until { @driver.find_element(:name, "email") }
    @driver.find_element(:name, "email").clear
    @driver.find_element(:name, "email").send_keys "qabot.6w@gmail.com"
    @driver.find_element(:name, "password").clear
    @driver.find_element(:name, "password").send_keys "wunderlist"
    @driver.find_element(:xpath, "//input[@value='Sign In']").click
    @wait.until { @driver.find_element(:css, "div.avatar") }
  end

  def logout
    @driver.get @base_url + "/logout"
    @wait.until { @driver.current_url == "https://www.wunderlist.com/download/" }
  end

  it "Wunderlist Login and Logout" do
    2.times do
      login
      logout
      expect(@driver.title).to include "Wunderlist Downloads"
    end
  end

end

=begin
1. create new empty project
2. create folder
3. create rspec file to write test cases
4. create Gemfile.rb and system automatically creates Gemfile.lock
5. create Rakefile
=end