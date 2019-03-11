class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :lead
  belongs_to :contact, optional: true
end
