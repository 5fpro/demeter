class CreateZipcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :zipcodes do |t|
      t.string :country_code
      t.string :code
      t.string :name
      t.string :state
      t.string :city
      t.jsonb :data, default: {}
      t.timestamps
    end
    add_index :zipcodes, :country_code
    add_index :zipcodes, [:country_code, :code]
  end
end
