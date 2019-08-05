class AddPictureToTutor < ActiveRecord::Migration[6.0]
  def change
    add_column :tutors, :picture, :string
  end
end
