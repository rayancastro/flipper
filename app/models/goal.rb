class Goal < ApplicationRecord
  has_many :user_goals
  has_many :users, through: :user_goals
  
  monetize :total_revenue_cents

  before_create :set_end_date

  private

  def set_end_date
    self.end_date = self.start_date + self.duration.days
  end
end
