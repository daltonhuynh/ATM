class CreateAtMachines < ActiveRecord::Migration
  def self.up
    create_table :at_machines do |t|
      
      t.integer :cash, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :at_machines
  end
end
