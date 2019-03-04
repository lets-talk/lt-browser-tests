# frozen_string_literal: true

require 'dotenv/load'
require 'rspec'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'faker'
require 'uri'
require 'byebug'
require 'rspec/retry'

require './support/pages/page'

# loading page object files
pages_paths = File.join(Dir.pwd, 'support', 'pages', '**', '*.rb')
Dir.glob(pages_paths).each { |file| require file }

# loading session  files
session_paths = File.join(Dir.pwd, 'support', 'session_steps', '**', '*.rb')
Dir.glob(session_paths).each { |file| require file }

# Capybara screenshot config
Capybara.save_path = './tmp/screenshots'
Capybara::Screenshot.prune_strategy = :keep_last_run

chrome_args = %w[headless disable-gpu --lang=es]

if ENV.key?('HEADLESS') && ENV['HEADLESS'] == 'false'
  chrome_args.delete('headless')
  chrome_args.delete('disable-gpu')
end

capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  chromeOptions: {
    prefs: { 'intl.accept_languages': 'es-CL' },
    args: chrome_args
  }
)

Capybara.register_driver :client do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.register_driver :agent do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :client
Capybara.default_driver = :agent
Capybara.app_host = 'http://pingpong.staging.letsta.lk'
Capybara.default_max_wait_time = 20

RSpec.configure do |config|
  config.before do
    config.include Capybara::DSL
    config.verbose_retry = true
    config.display_try_failure_messages = true
  end

  config.around :each, type: :feature do |ex|
    ex.run_with_retry retry: 3
  end

  config.after do |example_group|
    # Capybara screenshot config
    Capybara::Screenshot.screenshot_and_save_page if example_group.exception
  end

  # callback to be run between retries
  config.retry_callback = proc do |ex|
    # run some additional clean up task - can be filtered by example metadata
    Capybara.reset! if ex.metadata[:type] == :feature
  end
end
