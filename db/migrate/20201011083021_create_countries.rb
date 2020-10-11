class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :code
      t.jsonb :data
      t.timestamps
    end
    add_index :countries, :code
  end
end
