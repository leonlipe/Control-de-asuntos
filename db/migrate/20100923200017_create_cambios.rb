class CreateCambios < ActiveRecord::Migration
  def self.up
    create_table :cambios do |t|
      t.string :descripcion
      t.references :asunto

      t.timestamps
    end
  end

  def self.down
    drop_table :cambios
  end
end
