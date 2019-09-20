# frozen_string_literal: true

module Helpers
  module RequestHelpers
    def token_credentials_for(user)
      user.create_new_auth_token.slice('client', 'access-token', 'uid')
    end

    def is_json?(str)
      JSON.parse(str)
      return true
    rescue JSON::ParserError => e
      return false
    end
  end
end
