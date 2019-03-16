class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    if params[:lead_id]
      @contact = Contact.new(lead: Lead.find(params[:lead_id]))
    else
      @contact = Contact.new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to @contact
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy

    redirect_to contacts_path
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :position, :lead_id)
  end
end
