class CreateReferences < ActiveRecord::Migration[5.1]
  def change
    create_table :references do |t|
      t.references :applicant, foreign_key: true
      t.string :name
      t.string :relation
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address_lin1
      t.string :address_line2
      t.string :suburb
      t.string :city
      t.string :state
      t.string :country
      t.string :school_name
      t.string :school_city
      t.string :school_state
      t.string :school_country
      t.string :worked_from
      t.string :worked_to
      t.string :type

      t.timestamps
    end
  end
end
