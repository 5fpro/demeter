class AddColumnsForTyrUpdate < ActiveRecord::Migration[5.2]
  def change
    change_column :attachments, :description, :text
    execute 'CREATE INDEX trgm_attachments_description_idx ON attachments USING gist (description gist_trgm_ops);'
  end
end
