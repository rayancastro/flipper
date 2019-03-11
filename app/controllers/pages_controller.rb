class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user
      redirect_to leads_path
    end
  end

  def control_panel
  end

  def challenges
  end
end
