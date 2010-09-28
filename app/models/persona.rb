class Persona < ActiveRecord::Base
  has_many :asunto
  validates_associated :asunto
  validates_presence_of :nombre, :message => 'El dato es requerido'
end
