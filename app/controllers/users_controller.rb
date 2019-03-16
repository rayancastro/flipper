class UsersController < ApplicationController

  def user_profile
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash['notice'] = "Seus dados foram atualizados!"
      redirect_to user_profile_path
    else
      render :user_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
