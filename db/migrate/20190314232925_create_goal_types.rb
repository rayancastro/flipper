class CreateGoalTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :goal_types do |t|
      t.string :name
      t.integer :duration
      t.integer :identifier

      t.timestamps
    end
  end
end
