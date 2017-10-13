class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.references :job, foreign_key: true
      t.references :applicant, foreign_key: true

      t.timestamps
    end
  end
end
