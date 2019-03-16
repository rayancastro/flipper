class User < ApplicationRecord
  has_many :leads
  has_many :goals
  has_many :lead_backlogs
  has_many :activities
  has_many :notes
  has_many :user_goals
  has_many :goals, through: :user_goals

  mount_uploader :photo, PhotoUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
  	self.admin
  end

  def account_manager?
    self.account_manager
  end

  def sdr?
    !self.account_manager
  end

  def level_up
    experience_table = User.experience_table
    previous_level = self.level

    while self.experience_points >= experience_table[self.level + 1]
      self.level += 1
    end

    if self.level != previous_level
      self.save
      puts "#{self.name} leveled up to level #{self.level}!"
      return true
    else
      puts "#{self.name} ainda precisa de #{experience_table[self.level + 1] - self.experience_points} pontos de experiencia para atingir o nível #{level + 1}."
      return false
    end
  end

  def self.experience_table
    levels = {}
    total_xp = 0
    levels[1] = 0
    2.upto(100) do |level|
      level_up_ammount = 100 * (level - 1)
      total_xp += level_up_ammount
      levels[level] = total_xp
    end

    levels
  end
end
