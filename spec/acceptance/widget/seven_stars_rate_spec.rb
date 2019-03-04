# frozen_string_literal: true

require 'spec_helper'

describe 'rate', type: feature do
  let(:client_name) { Faker::Name.name }
  let(:agent) {
    SessionSteps::Agent.new(
      email: ENV['AGENT_EMAIL'],
      password: ENV['AGENT_PASSWORD'],
      session: Capybara.current_session
    )
  }

  let(:client) {
    SessionSteps::Client.new(
      name: client_name,
      email: Faker::Internet.email,
      session: Capybara::Session.new(:client),
      widget_name: 'widget-test-7-stars-feedback'
    )
  }

  let(:client_message_1) { Faker::Lorem.sentence(3) }

  it '7-stars feedback should appear when closing conversation' do
    # Login agent
    agent.login.login

    # Client login, select inquiery and send message
    client.login.login
    client.inquiries.select_inquiry(name: 'Support')
    client.messages.send_message(message: client_message_1)

    # Agent check new client conversation, select conversation
    agent.conversations_list.click_new_conversation(client_name: client_name)
    agent.messages.join_current_conversation
    agent.messages.finish_conversation

    # Client check if evaluation is displayed
    # and evaluate the conversation
    client.rate.select_star(number: 7)
    client.rate.expect_new_conversation_message
  end
end
