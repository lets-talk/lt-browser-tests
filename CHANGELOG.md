# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Hotfix [0.2.2] - 2020-01-24
### Fixed
- Update Readme file with instructions to run specs locally with dockerized camperfarm

## Hotfix [0.2.2] - 2020-01-24
### Fixed
- Conversation title matcher

## Hotfix [0.2.1] - 2020-01-24
### Fixed
- Client name display on conversation list for agent adding a second message form widget and an sleep

## Release [0.2.0] - 2019-10-14
### Added
- Docker file to run on circle ci

### Changed
- Change language to english

### Fixed
- Truncate client name

## Hotfix [0.1.1] - 2019-03-04
### Added
- rspec-retry gem because capybara sometimes fails
- version file

### Fixed
- Changelog release version

## Release [0.1.0] - 2019-03-03
### Added
- Parent Page class
- Child page widget classes for inquiries, login, messages
- Child page Admin old classes for login & conversartion messages
- Parent Session Steps class and child classes for agent and client
- Binary & Stars rate page classes
- Widget Settings yaml files
- Very simple & current unused Let's Talk API class
- Capybara Screenshot gem and configuration
- tmp/screenshots directory for Capybara Screenshot
- Default headless execution for specs
- Headless option to execute chrome with UI
- Readme file
- Changelog file
- .env-template for current used env vars
- Capybara config to set browser lang



