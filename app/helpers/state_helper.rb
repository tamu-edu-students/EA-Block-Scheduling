# app/helpers/state_helper.rb

module StateHelper
  def generate_state_token
    SecureRandom.urlsafe_base64(32)
  end
end
