class CreateDependents < ActiveRecord::Migration[5.1]
  def change
    create_table :dependents do |t|
      t.references :applicant, foreign_key: true
      t.string :name
      t.string :gender
      t.date :dob
      t.timestamps
    end
  end
end
