class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @activities = Activity.all
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    if @activity.save
      if @activity.lead
        redirect_to lead_path(@activity.lead)
      else
        redirect_to @activity
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      if @activity.lead
        redirect_to lead_path(@activity.lead)
      else
        redirect_to @activity
      end
    else
      render :edit
    end
  end

  def destroy
    @activity.destroy

    redirect_to activitys_path
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :contact_id, :lead_id)
  end
end
