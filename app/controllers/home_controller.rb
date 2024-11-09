class HomeController < ApplicationController
  skip_before_action :check_if_establishment_or_opening_hour_is_nil
  skip_before_action :authenticate_user!
  skip_before_action :check_current_user_type_for_page
  
  def index
  end
end