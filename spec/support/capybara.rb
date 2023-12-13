# spec/support/capybara.rb
require 'capybara/rails'
require 'selenium/webdriver'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.binary = 'C:\Program Files (x86)\Mozilla Firefox\firefox.exe'

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.javascript_driver = :selenium
