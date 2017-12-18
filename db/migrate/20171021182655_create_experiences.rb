class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.references :applicant, foreign_key: true

      t.timestamps
    end
  end
end
