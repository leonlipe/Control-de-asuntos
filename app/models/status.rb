class Status < ActiveRecord::Base
  has_many :asunto
  has_many :movimientos
  validates_associated :asunto
  validates_presence_of :tipo, :message => 'El dato es requerido'
  validates_length_of :tipo, :in => 2..255, :message => 'La longitud del texto no es válida'
end
