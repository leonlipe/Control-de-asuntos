class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios do |t|
      t.text :comentario
      t.references :asunto
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :comentarios
  end
end
