class AddDefaultToLead < ActiveRecord::Migration[5.2]
  def change
    change_column :leads, :revenue_cents, :integer, :default => 0
  end
end
