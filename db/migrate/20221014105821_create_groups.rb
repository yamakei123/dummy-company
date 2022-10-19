class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
    add_index  :groups, [:company_id, :name], unique: true
  end
end
