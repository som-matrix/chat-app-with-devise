class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    chat_rooms_path
  end
end
