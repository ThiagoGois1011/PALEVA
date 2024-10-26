class HomeController < ApplicationController
  skip_before_action :check_if_establishment_is_nil
  skip_before_action :authenticate_user!
  
  def index
  end
end