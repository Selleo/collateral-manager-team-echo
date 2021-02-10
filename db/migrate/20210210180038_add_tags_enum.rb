class AddTagsEnum < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :category, :integer
  end
end
