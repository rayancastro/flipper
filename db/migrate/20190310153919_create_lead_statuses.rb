class CreateLeadStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :lead_statuses do |t|
      t.string :name
      t.integer :identifier

      t.timestamps
    end
  end
end
