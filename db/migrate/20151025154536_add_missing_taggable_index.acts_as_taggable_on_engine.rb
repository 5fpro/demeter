# This migration comes from acts_as_taggable_on_engine (originally 4)
class AddMissingTaggableIndex < ActiveRecord::Migration[5.1]
  def up
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def down
    remove_index :taggings, [:taggable_id, :taggable_type, :context]
  end
end
