class AddIndexToAsuntos < ActiveRecord::Migration
  def self.up
    add_index :asuntos, :nombresolicitante, :unique => true, :name => 'idxnomsoli'
  end

  def self.down
    remove_index :asuntos, :column => :nombresolicitante
  end
end
