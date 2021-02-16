class AddPolymorphic < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_assignments do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
    end
  end
end
