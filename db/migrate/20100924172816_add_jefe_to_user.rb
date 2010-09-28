class AddJefeToUser < ActiveRecord::Migration
  def self.up
     change_table :users do |t|
          t.integer :jefe_id
        end
  end

  def self.down
    remove_column :users, :jefe_id
    
  end
end
