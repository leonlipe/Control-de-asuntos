class Asunto < ActiveRecord::Base
  acts_as_audited
  # Restricciones
  
  # Relaciones
  belongs_to :prioridad
  belongs_to :categoria
  belongs_to :persona_atendio, :class_name => "user"
  belongs_to :persona_turnado, :class_name => "user"
  belongs_to :status
  has_many :comentarios
  has_many :cambios
  has_many :asuntos

  validates_associated :comentarios
  
  validates_presence_of :fecha, :message => 'La fecha es obligatoria'
  validates_presence_of :nombresolicitante, :message => 'El nombre de solicitante es obligatorio'
  validates_presence_of :asunto, :message => 'El asunto es obligatorio'
  validates_presence_of :descripcion, :message => 'La descripcion del asunto es obligatorio'
  
  
  def prioridaddesc
    Prioridad.find(prioridad).tipo
  end
  
  def categoriadesc
    Categoria.find(categoria).tipo
  end
  
  def personaatendio
    User.find(persona_atendio_id).name
  end
  
  def personaturnado
    User.find(persona_turnado_id).name
  end
  
end
