class AddColumnsForPageBlockUpdate < ActiveRecord::Migration[5.2]
  def change
    add_column :page_blocks, :template_engine, :string
    add_column :page_blocks, :variables, :text
  end
end
