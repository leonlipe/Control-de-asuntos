class CreateAsuntos < ActiveRecord::Migration
  def self.up
    create_table :asuntos do |t|
      t.date :fecha
      t.string :nombresolicitante
      t.string :organizacion
      t.string :asunto
      t.text :descripcion
      t.string :telefono
      t.text :observaciones
      t.date :fechaultcont
      t.date :fechasigcont
      t.boolean :audienciapub
      t.boolean :gober

      t.timestamps
    end
  end

  def self.down
    drop_table :asuntos
  end
end
