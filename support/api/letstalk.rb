# frozen_string_literal: true

require 'base64'
require 'httparty'
require 'byebug'
require 'json'

#
# Class to implemtn Simple LT API
#
# @author [danielbarria]
#
class Letstalk
  LOGIN = '.staging.letsta.lk'

  attr_reader :email, :options

  def initialize(email:, password:, subdomain:)
    @email = email
    @options = {
      base_uri: "https://#{subdomain}#{LOGIN}",
      headers: { 'Content-Type': 'application/json' },
      follow_redirects: false
    }
    login(password: password)
  end

  def login(password:)
    response = HTTParty.post(
      '/api/v1/tokens/user',
      options.merge(
        body: { email: email, password: password }.to_json
      )
    )
    raise 'login error' if response.code != 200

    token = response.parsed_response['token']
    encoded = Base64.strict_encode64("#{token}:X")
    options[:headers]['Authorization'] = "Basic #{encoded}"
  end

  def close_conversation(id)
    HTTParty.put(
      "/api/v1/conversations/#{id}",
      options.merge(
        body: { status: 'Closed' }.to_json
      )
    )
  end
end
