class Contact < ApplicationRecord
  belongs_to :lead, optional: true
  has_many :activities
end
