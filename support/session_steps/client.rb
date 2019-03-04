# frozen_string_literal: true

module SessionSteps
  #
  # Class to encapsulate logic
  # to interact with client in a widget
  #
  # @author [danielbarria]
  #
  class Client < SessionSteps
    include Pages::Widget
    attr_reader :session, :pages

    def initialize(name:, email:, session:, widget_name: 'widget')
      @session = session
      @widget = nil
      @pages = nil
      setup_widget(name: widget_name)
      add_pages(name: name, email: email)
    end

    private

    def setup_widget(name:)
      @widget = Pages::Widget::WidgetSettings.new(
        name: name,
        session: @session
      )
    end

    def add_pages(name:, email:)
      @pages = {
        inquiries: Inquiries.new(session: @session),
        messages: Messages.new(session: @session),
        rate: @widget.rate,
        login: Login.new(
          session: @session, name: name, email: email, widget: @widget
        )
      }
    end
  end
end
