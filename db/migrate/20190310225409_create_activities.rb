class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :description
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: true
      t.references :lead, foreign_key: true
      t.datetime :date
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
