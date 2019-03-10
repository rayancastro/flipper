class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :business_name
      t.integer :revenue_cents
      t.date :closure_date
      t.references :user, foreign_key: true
      t.references :sales_funnel_stage, foreign_key: true
      t.references :lead_status, foreign_key: true
      t.string :website
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
