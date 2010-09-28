class CreatePendientes < ActiveRecord::Migration
  def self.up
    create_table :pendientes do |t|
      t.boolean :activo
      t.references :user
      t.references :asunto

      t.timestamps
    end
  end

  def self.down
    drop_table :pendientes
  end
end
