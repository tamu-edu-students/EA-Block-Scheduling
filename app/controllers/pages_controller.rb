# app/controllers/pages_controller.rb

class PagesController < ApplicationController
  def index
    if logged_in?
      redirect_to pages_path, notice: "Welcome back!"
    end
  end
end
