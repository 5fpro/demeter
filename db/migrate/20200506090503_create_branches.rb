class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :code
      t.string :name
      t.string :address
      t.integer :bank_id

      t.timestamps
    end
  end
end
