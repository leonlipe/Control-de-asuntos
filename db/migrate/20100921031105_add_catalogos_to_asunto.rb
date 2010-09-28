class AddCatalogosToAsunto < ActiveRecord::Migration
  def self.up
    change_table :asuntos do |t|
        t.integer :prioridad_id 
        t.integer :categoria_id
        t.integer :persona_atendio_id
        t.integer :persona_turnado_id
        t.integer :status_id
      end
  end

  def self.down
     change_table :asuntos do |t|
          t.remove :prioridad_id 
          t.remove :categoria_id
          t.remove :persona_atendio_id
          t.remove :persona_turnado_id
          t.remove :status_id
        end
    
  end
end
