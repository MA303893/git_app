class AddRelationToDependent < ActiveRecord::Migration[5.1]
  def change
    add_column :dependents, :relation, :string
  end
end
