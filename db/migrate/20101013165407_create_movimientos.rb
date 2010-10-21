class CreateMovimientos < ActiveRecord::Migration
  def self.up
    create_table :movimientos do |t|
      t.references :user
      t.references :asunto
      t.string :nombre_anterior
      t.string :nombre_actual
      t.integer :status_anterior_id
      t.integer :status_actual_id

      t.timestamps
    end
  end

  def self.down
    drop_table :movimientos
  end
end
