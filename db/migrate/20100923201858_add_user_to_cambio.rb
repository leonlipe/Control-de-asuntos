class AddUserToCambio < ActiveRecord::Migration
  def self.up
    change_table :cambios do |t|
        t.references :user
      end
  end

  def self.down
    remove_column :cambios, :user
  end
end
