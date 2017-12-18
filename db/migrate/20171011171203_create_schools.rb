class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
