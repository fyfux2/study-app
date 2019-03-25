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

  def count_students
    Attendance.where(course_id: id).count
  end

  def till_start
    min_number - count_students
  end

  def min_users_reached
    if count_students >= min_number
      if start_date >= Date.current
        'Minimālais dalībnieku skaits ir sasniegts'
      else
        'Pieteikšanās kursam ir beigusies'
      end
    else
      'Lai kurss varētu sākties nepieciešami vēl ' + till_start.to_s + ' dalībnieki'
    end
  end

  def already_started
    if start_date < Date.current
      if count_students < min_number
        'Kurss ir atcelts, minimālais skaits netika sasniegts'
      else
        'Pieteikšanās ir beigusies, kurss ir sācies'
      end
    elsif count_students >= max_number
      'Maksimālais skaits ir sasniegts, pieteikšanās ir beigusies'
    else
      'Kurss vēl nav sācies'
    end
  end

  def already_ended
    if end_date < Date.current
      'Kurss ir beidzies'
    else
      'Kursa beigu datums vēl nav pienācis'
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
