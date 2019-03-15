class CreateUserGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :user_goals do |t|
      t.references :user, foreign_key: true
      t.references :goal, foreign_key: true
      t.monetize :current_revenue, default: 0
      t.integer :current_mqls, default: 0

      t.timestamps
    end
  end
end
