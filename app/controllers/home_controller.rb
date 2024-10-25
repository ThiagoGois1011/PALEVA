class HomeController < ApplicationController
  def index
    redirect_to establishment_path(current_user.establishment) if user_signed_in? && !current_user.establishment.nil?
  end
end