class AddGamificationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :experience_points, :integer, default: 0, null: false
    add_column :users, :level, :integer, default: 1, null: false
    add_column :users, :account_manager, :boolean, default: false
  end
end
