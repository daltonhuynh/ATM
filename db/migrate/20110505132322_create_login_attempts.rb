class CreateLoginAttempts < ActiveRecord::Migration
  def self.up
    create_table :login_attempts do |t|
      
      t.string :ip, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :login_attempts
  end
end
