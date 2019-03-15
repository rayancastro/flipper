class GoalsController < ApplicationController
  before_action :set_goal, only: [:edit, :update, :destroy]

  def index
    @goals = Goal.all
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to @goal
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal
    else
      render :edit
    end
  end

  def destroy
    @goal.destroy

    redirect_to goals_path
  end

  def create_user_goals_for_all
    @goal = Goal.find(params[:goal_id])
    previous_count = @goal.user_goals.count
    User.all.each do |user|
      begin
        UserGoal.create!(user: user, goal: @goal)
      rescue

      end
    end
    flash['notice'] = "Meta criada para #{@goal.user_goals.count - previous_count} usuários"
    redirect_to goals_path
  end

  def destroy_user_goals_for_all
    @goal = Goal.find(params[:goal_id])
    @goal.user_goals.destroy_all

    redirect_to goals_path
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :duration, :total_revenue_cents, :total_mqls, :start_date)
  end
end
