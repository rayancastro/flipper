class ChangePriceToMonetizeFromLeads < ActiveRecord::Migration[5.2]
  def change
    remove_column :leads, :revenue_cents
    add_monetize :leads, :revenue, currency: { present: false }
  end
end
