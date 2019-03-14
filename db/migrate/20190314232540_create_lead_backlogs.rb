class CreateLeadBacklogs < ActiveRecord::Migration[5.2]
  def change
    create_table :lead_backlogs do |t|
      t.references :lead, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :previous_stage_id
      t.integer :new_stage_id
      t.monetize :revenue

      t.timestamps
    end
  end
end
