class CreateCollaterals < ActiveRecord::Migration[6.0]
  def change
    create_table :collaterals do |t|
      t.string :name
      t.string :link
      t.integer :kind

      t.timestamps
    end
  end
end
