# frozen_string_literal: true

module Pages
  module Widget
    #
    # Class to create different widget types
    #
    # @author [danielbarria]
    #
    class WidgetSettings < Page
      YAML_PATH = File.expand_path('./support/pages/widget/widget_settings/')
      attr_reader :name, :settings, :rate
      def initialize(name:, session:)
        @session = session
        @name = name
        load_yaml
        add_rate
      end

      def query_params
        params = settings.slice(
          :widget_src,
          :organization_subdomain,
          :environment
        )
        params = { widget_name: name }.merge(params)
        URI.encode_www_form(params)
      end

      private

      def add_rate
        rate = Rate.const_get(settings[:rate_type].to_s)
        @rate = rate.new(session: session)
      end

      def load_yaml
        @settings = YAML.load_file("#{YAML_PATH}/#{name}.yaml")
      end
    end
  end
end
