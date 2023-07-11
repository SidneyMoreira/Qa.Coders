require 'capybara/cucumber'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'site_prism'
require 'pry'
require_relative 'prints.rb'
require_relative 'pages_helpers.rb'

World(Prints, Pages)

ENVIRONMENT = ENV['ENVIRONMENT']
puts "Environment >> #{ENVIRONMENT}"

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/environments/#{ENVIRONMENT}.yml")

Capybara.configure do |config|
    config.default_driver = :selenium_chrome
    config.app_host = CONFIG['url_default']
    config.default_max_wait_time = 10
end