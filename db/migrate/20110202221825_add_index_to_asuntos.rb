class AddIndexToAsuntos < ActiveRecord::Migration
  def self.up
    add_index :asuntos, [:nombresolicitante, :asunto], :unique => true, :name => 'idxnomsoli'
  end

  def self.down
    remove_index :asuntos, :name => 'idxnomsoli'
  end
end
