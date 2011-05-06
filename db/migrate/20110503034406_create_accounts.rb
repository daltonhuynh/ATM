class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      
      t.references :person
      
      t.string :name, :null => false
      t.integer :balance, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
