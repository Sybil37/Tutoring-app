class AddColumnsToTutors < ActiveRecord::Migration[6.0]
  def change
    add_column :tutors, :education, :string
  end
end
