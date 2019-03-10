class Lead < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :sales_funnel_stage
  belongs_to :lead_status
  before_create :set_lead_status
  before_create :set_sales_funnel_stage

  def self.filter_by_identifier(identifier)
    self.joins(:sales_funnel_stage).where('sales_funnel_stages.identifier = ?', "#{identifier}")
  end

  def lost?
    self.lead_status.identifier == 1
  end

  def won?
    self.lead_status.identifier == 2
  end

  def set_lead_status
    if self.lead_status.nil?
      self.lead_status = LeadStatus.find_by(identifier: 0)
    end
  end

  def set_sales_funnel_stage
    if self.sales_funnel_stage.nil?
      self.sales_funnel_stage = SalesFunnelStage.find_by(identifier: 0)
    end
  end
end
