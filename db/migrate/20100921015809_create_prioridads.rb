class CreatePrioridads < ActiveRecord::Migration
  def self.up
    create_table :prioridads do |t|
      t.string :tipo

      t.timestamps
    end
  end

  def self.down
    drop_table :prioridads
  end
end
