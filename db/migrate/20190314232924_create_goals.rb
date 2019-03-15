class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.integer :duration
      t.monetize :total_revenue
      t.integer :total_mqls
      t.date :start_date
      t.date :end_date
      t.boolean :closed, default: false
      
      t.timestamps
    end
  end
end
