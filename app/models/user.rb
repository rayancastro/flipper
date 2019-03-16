class User < ApplicationRecord
  has_many :leads
  has_many :goals
  has_many :lead_backlogs
  has_many :activities
  has_many :notes
  has_many :user_goals
  has_many :goals, through: :user_goals

  mount_uploader :photo, PhotoUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
  	self.admin
  end

  def account_manager?
    self.account_manager
  end

  def sdr?
    !self.account_manager
  end

  def level_up
    experience_table = User.experience_table
    previous_level = self.level

    while self.experience_points >= experience_table[self.level + 1]
      self.level += 1
    end

    if self.level != previous_level
      self.save
      puts "#{self.name} leveled up to level #{self.level}!"
      return true
    else
      puts "#{self.name} ainda precisa de #{experience_table[self.level + 1] - self.experience_points} pontos de experiencia para atingir o nível #{level + 1}."
      return false
    end
  end

  def gain_experience(points)
    self.experience_points += points
    self.save
    self.level_up
  end

  def gain_goals_points(backlog)
    new_stage = backlog.new_stage
    mql_counter = 0
    sql_counter = 0
    closure_counter = 0
    revenue = 0

    user_goal = self.user_goals.first
    mql_exp = user_goal

    case new_stage.identifier
    when 3
      mql_counter += 1
    when 4
      sql_counter += 1
    when 8
      closure_counter += 1
      revenue += backlog.revenue
    end

    self.user_goals.each do |user_goal|
      user_goal.current_revenue += revenue
      user_goal.current_mqls += mql_counter
    end

    total_experience = (User.mql_exp * mql_counter) + (User.sql_exp * sql_counter) + (User.closure_exp(revenue) * closure_counter)
    self.gain_experience(total_experience)
  end

  def self.mql_exp
    goal = Goal.first
    daily_exp_constant = 300
    if goal
      mql_per_day = goal.total_mqls / goal.duration.to_f
      mql_exp = daily_exp_constant / mql_per_day
      return mql_exp.round
    else
      return nil
    end
  end
  
  def self.sql_exp
    sql_constant = 2.33
    (self.mql_exp * sql_constant).round
  end

  def self.closure_exp(revenue)
    revenue_cents = revenue.to_i*100
    goal = Goal.first
    daily_exp_constant = 500
    if goal
      revenue_cents_per_day = goal.total_revenue_cents / goal.duration.to_f
      revenue_cents_exp = daily_exp_constant / revenue_cents_per_day
      closure_exp = revenue_cents_exp * revenue_cents
      return closure_exp.round
    else
      return nil
    end
  end

  def self.experience_table
    levels = {}
    total_xp = 0
    levels[1] = 0
    2.upto(100) do |level|
      level_up_ammount = 100 * (level - 1)
      total_xp += level_up_ammount
      levels[level] = total_xp
    end

    levels
  end
end
