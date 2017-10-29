class AddUserToApplicant < ActiveRecord::Migration[5.1]
  def change
    change_table :applicants do |t|
      t.belongs_to :user, index: true, unique: true
    end
  end
end
