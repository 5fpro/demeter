class AddColumnIdentityToZipcode < ActiveRecord::Migration[5.2]
  def change
    add_column :zipcodes, :identity, :string, comment: '識別'
    add_index :zipcodes, [:country_code, :identity]
  end
end
