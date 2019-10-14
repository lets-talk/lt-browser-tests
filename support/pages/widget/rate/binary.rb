# frozen_string_literal: true

module Pages
  module Widget
    module Rate
      #
      # Class to define method to interact
      # with binary
      #
      # @author [danielbarria]
      #
      class Binary < Page
        def select_yes
          session.within_frame 'lt-messenger-iframe' do
            session.click_button 'Yes'
          end
        end
      end
    end
  end
end
