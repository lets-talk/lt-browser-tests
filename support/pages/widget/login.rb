# frozen_string_literal: true

module Pages
  module Widget
    #
    # Class to define method to interact
    # with login
    #
    # @author [danielbarria]
    #
    class Login < Page
      attr_reader :email, :name, :widget
      def initialize(session:, name:, email:, widget:)
        super(session: session)
        @name = name
        @email = email
        @widget = widget
      end

      def login
        visit_widget_examples(query_params: widget.query_params)
        session.within_frame 'lt-messenger-iframe' do
          session.fill_in 'name', with: name
          session.fill_in 'email', with: email
          session.click_button 'Start'
        end
      end

      private

      def visit_widget_examples(query_params:)
        url = "#{ENV['WIDGET_URL']}?#{query_params}"
        session.visit(url)
        session.click_button('Chat')
        expect(session).to have_selector('#lt-messenger-iframe')
      end
    end
  end
end
