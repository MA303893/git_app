class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.references :applicant, foreign_key: true
      t.string :name
      t.string :proficiency

      t.timestamps
    end
  end
end
