module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    # identified_by :random_id

    def connect
      self.current_user = find_verified_user
      # byebug
      # self.random_id = SecureRandom.urlsafe_base64
    end

    private

    def find_verified_user
      if verified_user = env["warden"].user(:staff)
        verified_user
      elsif verified_user = env["warden"].user(:client)
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
