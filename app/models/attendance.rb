class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :course

  
  validate :already_ended, if: -> { user_id.present? }
  validate :teachers_in_courses, if: -> { course_id.present? }
  validate :max_attendees, if: -> { course_id.present? }

  private

  def teachers_in_courses
    errors.add(:base, 'Pasniedzējs nevar būt students pats savā kursā!') if
    user.id == course.user_id
  end

  def max_attendees
    errors.add(:base, 'Maksimālais dalībnieku skaits kursā ir pārsniegts, lūdzu izvēlieties citu kursu!') if course.count_students >= course.max_number
  end

  def already_ended
    errors.add(:base, 'Pieteikšanās uz kursu ir beigusies, lūdzu izvēlieties citu kursu!') if course.start_date < Date.current
  end
end
