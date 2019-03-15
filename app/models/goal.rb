class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :goal_type
end
