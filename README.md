# lt-browser-tests
Opinionated structure for capybara browser tests using standalone RSpec

This project uses the following principles:

- Two browser sessions
- Pages classes that store capybara methods for specific page
  - Every page class inherits from /support/pages/page.rb to add Capybara::DSL, RSpec::Matchers and define session instance var
  - Use namespace to separate every system and pages to scope helpers
- SessionSteps classes to define what pages can be accessed by a user type
  - Every class must inherit from support/session_steps/session_steps.rb to add helper methods to User type instance

# How to run locally

This project runs against a dockerized version of camperfarm. You need to clone https://github.com/lets-talk/camperfarm-web to your local machine. Also, is necessary to add the following lines to your host file:

```
127.0.0.1 pingpong.qak.letsta.lk
127.0.0.1 api.qak.letsta.lk
127.0.0.1 chrome.com
```

## Setup containers

The first time, you need to set up your containers with the following commands:

```
  docker-compose run camperfarm bundle exec rake db:create
  docker-compose run camperfarm bundle exec rake db:schema:load
  docker-compose run camperfarm bundle exec rake capybara:populate_init_data
  docker-compose run camperfarm bundle exec rake db:migrate
  docker-compose run camperfarm bundle exec rake assets:precompile
```

## Run the tests

To run all containers execute:

- `cd ~/camperfarm-web`
- `docker-compose up`

Then, in another shell, run:

- `cd ~/lt-browser-tests`
- `bundle exec rspec`


## How to see specs running live in a browser

If you want to see how the specs run in a browser, you need to open a VNC client to `localhost:5900` using the password `secret`. This will open a VCN connection to the Chrome container. This container has a selenium server that executes capybara specs using a Chrome browser. Amazing, right?

