class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :course, foreign_key: true, index: true

      t.timestamps
    end
  end
end
