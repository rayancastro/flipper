class CreateSalesFunnelStages < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_funnel_stages do |t|
      t.string :name
      t.integer :identifier

      t.timestamps
    end
  end
end
