class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  
  def index
    @leads = Lead.all.order(updated_at: :desc)
  end

  def change_lead_stage
    @lead = Lead.find(params[:lead_id])
    @stage = SalesFunnelStage.find_by(identifier: params[:stage_identifier])
    @lead.sales_funnel_stage = @stage

    if @lead.save
      respond_to do |format|
        format.json { render json: { lead_id: @lead.id }, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: { lead_id: @lead.id }, status: 410 }
      end
    end
  end

  def show
    @note = Note.new
    @activity = Activity.new
  end

  def new
    @lead = Lead.new(sales_funnel_stage: SalesFunnelStage.find_by(identifier: 0),
                     lead_status: LeadStatus.find_by(identifier: 0))
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      redirect_to @lead
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lead.update(lead_params)
      redirect_to @lead
    else
      render :edit
    end
  end

  def destroy
    @lead.destroy

    redirect_to leads_path
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:business_name, :revenue_cents, :closure_date, :user_id, :sales_funnel_stage_id, :lead_status_id, :website, :address, :city, :state)
  end
end
