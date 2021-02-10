class CollateralTagsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :collaterals_tags, id: false do |t|
      t.belongs_to :tag
      t.belongs_to :collateral
    end
  end
end
