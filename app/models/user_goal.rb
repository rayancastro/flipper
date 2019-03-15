class UserGoal < ApplicationRecord
  belongs_to :goal
  belongs_to :user

  validates :user_id, uniqueness: { scope: :goal_id, message: "User goal já existe para esse usuário e essa meta." }
end
