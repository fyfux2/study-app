class User < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :attendances
  has_many :courses, through: :attendances
  validates :first_name, :last_name, presence: true

  def user_value
    first_name + ' ' + last_name
  end

end
