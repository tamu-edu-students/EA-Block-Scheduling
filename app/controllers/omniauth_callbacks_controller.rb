# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def provider
    state = State.find_by(token: request.env["omniauth.auth"]["state"])
    if state.present? && !state.expired?
      auth = request.env["omniauth.auth"]
      user = User.find_by(email: auth["info"]["email"]) || User.create_with(
        provider: auth["provider"],
        uid: auth["uid"],
        name: auth["info"]["name"],
        email: auth["info"]["email"]
      ).find_or_create_by(email: auth["info"]["email"])

      sign_in_and_redirect user, event: :authentication

      if state.data["additional_info"]
        # do something
      end

      state.destroy!
    end

    redirect_to root_path, alert: "Invalid or expired state"
  end

end
