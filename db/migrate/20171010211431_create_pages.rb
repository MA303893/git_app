class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.longtext :body
      t.string :footer

      t.timestamps
    end
  end
end
