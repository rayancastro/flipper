class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_progress

  def set_progress
    if current_user
      experience_table = User.experience_table
      current_user.level_up
      current_level_xp = current_user.experience_points - experience_table[current_user.level]
      next_level_xp = experience_table[ current_user.level + 1 ] - experience_table[current_user.level]
      level_percentage = (current_level_xp/next_level_xp.to_f)*100
      @progress = level_percentage.round
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
    devise_parameter_sanitizer.permit(:edit, keys: [:name, :photo])
  end
end
