class User < ApplicationRecord
  has_many :leads
  has_many :goals
  has_many :lead_backlogs
  has_many :activities
  has_many :notes
  has_many :goals


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
  	self.admin
  end
end
