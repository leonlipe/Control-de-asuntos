class CreateAdjuntos < ActiveRecord::Migration
  def self.up
    create_table :adjuntos do |t|
      t.column :adjunto_file_name,    :string
      t.column :adjunto_content_type, :string
      t.column :adjunto_file_size,    :integer
      t.column :attachable_type,    :string
      t.column :attachable_id,    :integer
      t.timestamps
    end
    
    add_index :adjuntos, [:attachable_id, :attachable_type]
    
  end

  def self.down
    drop_table :adjuntos
  end
end
