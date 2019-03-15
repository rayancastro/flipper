class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.references :user, foreign_key: true
      t.monetize :current_revenue
      t.monetize :total_revenue
      t.integer :current_mqls
      t.integer :total_mqls
      t.date :start_date
      t.date :end_date
      t.boolean :closed
      t.references :goal_type, foreign_key: true

      t.timestamps
    end
  end
end
