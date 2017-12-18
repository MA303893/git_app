class AddCloumnsToApplicant3 < ActiveRecord::Migration[5.1]
  def change
    add_column :applicants, :registered_teacher, :boolean
    add_column :applicants, :total_relevant_experience, :integer
    add_column :applicants, :can_coach_activities, :text
    add_column :applicants, :interests, :text
    add_column :applicants, :skills, :text
    add_column :applicants, :other_experiences, :text
    add_column :applicants, :comments, :text
  end
end
