# frozen_string_literal: true

class RedirectToRoot < Devise::FailureApp
  def route(scope)
    puts "!!!!! scope = #{scope} scope.class = #{scope.class}"
    puts "!!!!! polymorphic_path(scope) = #{polymorphic_path(scope.to_s.pluralize)}"
    polymorphic_path(scope.to_s.pluralize)
    # :root_path
  end

  def redirect
    store_location!

    redirect_to redirect_url
  end
end

module Devise
  module Strategies
    class Token < Base
      def valid?
        access_token.present? && uid.present? && client.present?
      end

      def authenticate!
        user = mapping.to.find_by(uid: uid)

        success! user if user.valid_token?(access_token, client)
      rescue
        fail
      end

      private

      def access_token
        request.headers['access-token'] || params['access-token']
      end

      def uid
        request.headers['uid'] || params['uid']
      end

      def client
        request.headers['client'] || params['client']
      end
    end
  end
end
