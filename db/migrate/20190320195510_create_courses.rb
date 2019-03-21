class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :min_number
      t.integer :max_number

      t.belongs_to :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
