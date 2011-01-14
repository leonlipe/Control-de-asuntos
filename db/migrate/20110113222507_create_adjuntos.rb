class CreateAdjuntos < ActiveRecord::Migration
  def self.up
    create_table :adjuntos do |t|
            t.column :nombrearchivo, :string
            t.column :tipo_contenido, :string
            t.column :datos, :binary
            t.timestamps
    end
  end

  def self.down
    drop_table :adjuntos
  end
end
