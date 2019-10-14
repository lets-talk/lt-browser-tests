# frozen_string_literal: true

module Pages
  module Widget
    module Rate
      #
      # Class to define method to interact
      # with star rate
      #
      # @author [danielbarria]
      #
      class Stars < Page
        def select_star(number:)
          session.within_frame 'lt-messenger-iframe' do
            session.find(
              ".feedback-stars i[data-value='#{number}']"
            ).click
          end
        end

        def expect_new_conversation_message
          session.within_frame 'lt-messenger-iframe' do
            expect(session).to have_text(
              'Start new conversation'
            )
          end
        end
      end
    end
  end
end
