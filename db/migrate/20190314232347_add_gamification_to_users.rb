class AddGamificationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :experience_points, :integer
    add_column :users, :level, :integer
    add_column :users, :closer, :boolean
  end
end
