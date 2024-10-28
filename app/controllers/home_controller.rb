class HomeController < ApplicationController
  skip_before_action :check_if_establishment_or_opening_hour_is_nil
  skip_before_action :authenticate_user!
  
  def index
  end
end