class Course < ApplicationRecord
  belongs_to :user
  has_many :attendances
  has_many :users, through: :attendances

  def user_value
    user.first_name + ' ' + user.last_name
  end

  validates :title, :description, :start_date, :end_date, :min_number, :max_number, presence: true

  validate :dates_difference, if: -> { start_date.present? && end_date.present? }
  validate :attendees_difference, if: -> { min_number.present? && max_number.present? }
  validate :start_from_now, if: -> { start_date.present? }
  validate :end_from_now, if: -> { end_date.present? }
  validates :min_number, :max_number, numericality: { greater_than_or_equal_to: 0 }

  #def 
  #  Jābūt attēlotai pazīmei vai ir sasniegts minimālais studentu skaits;
  #end

  def already_started
    if start_date < Date.current
      'Pieteikšanās ir beigusies'
    else
      'Kurss vēl nav sācies'
    end
  end

  def already_ended
    if end_date < Date.current
      'Kurss ir beidzies'
    else
      'Kurss vēl nav beidzies'
    end
  end

  private

  def dates_difference
    errors.add(:base, 'Sākuma datums nevar būt lielāks par beigu datumu!') if   start_date > end_date
  end

  def attendees_difference
    errors.add(:base, 'Minimālais apmeklētāju skaits nevar būt lielāks!') if min_number > max_number
  end

  def start_from_now
    errors.add(:base, 'Sākuma datums nedrīkst būt pagātnē!') if start_date < Date.current
  end

  def end_from_now
    errors.add(:base, 'Beigu datums nedrīkst būt pagātnē!') if end_date < Date.current
  end

end
