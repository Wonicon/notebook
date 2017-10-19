class WelcomeController < ApplicationController
  before_action :set_active, only: [:index]

  def index
  end

  private
  def set_active
    session[:current_controller] = 'Index'
  end
end
