class AddWagesToTag < ActiveRecord::Migration[6.0]
  def change
    add_column :tag_assignments, :weight, :float
  end
end
