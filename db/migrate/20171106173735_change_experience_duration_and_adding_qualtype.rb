class ChangeExperienceDurationAndAddingQualtype < ActiveRecord::Migration[5.1]
  def change
    change_column :qualifications, :duration, :integer
    add_column :qualifications, :qualification_type, :string
  end
end
