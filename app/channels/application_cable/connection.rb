module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # only allow authenticated users to connect
    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      # env["warden"].user is coming from devise
      if current_user = env["warden"].user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
