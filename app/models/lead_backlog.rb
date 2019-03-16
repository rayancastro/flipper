class LeadBacklog < ApplicationRecord
  belongs_to :lead
  belongs_to :user
  belongs_to :previous_stage, class_name: 'SalesFunnelStage'
  belongs_to :new_stage, class_name: 'SalesFunnelStage'
  validates :new_stage, uniqueness: { scope: :lead_id, message: "Já existe um LeadBacklog dessa alteração." }

  monetize :revenue_cents
end
