class ChangeQualDate < ActiveRecord::Migration[5.1]
  def change
    change_column :qualifications, :date_of_completion, :date
  end
end
