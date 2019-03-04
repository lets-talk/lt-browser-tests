# frozen_string_literal: true

require 'dotenv/load'
require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'faker'
require 'uri'
require 'byebug'

require './support/pages/page'

# loading page object files
pages_paths = File.join(Dir.pwd, 'support', 'pages', '**', '*.rb')
Dir.glob(pages_paths).each { |file| require file }

# loading session  files
session_paths = File.join(Dir.pwd, 'support', 'session_steps', '**', '*.rb')
Dir.glob(session_paths).each { |file| require file }

Capybara.register_driver :client do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end
Capybara.register_driver :agent do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.default_driver = :agent
Capybara.app_host = 'http://pingpong.staging.letsta.lk'
Capybara.default_max_wait_time = 15

RSpec.configure do |config|
  config.before do
    config.include Capybara::DSL
  end
end
