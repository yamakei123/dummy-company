class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false, unique: true
      t.integer :age
      t.references :groups, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
