class Asunto < ActiveRecord::Base
  include Trimmer
  acts_as_audited
  # Restricciones
  
  # Relaciones
  belongs_to :prioridad
  belongs_to :categoria
  belongs_to :persona_atendio, :class_name => "User"
  belongs_to :persona_turnado, :class_name => "User"
  belongs_to :status
  has_many :comentarios , :order => 'created_at DESC'
  has_many :cambios
  has_many :asuntos
  has_many :movimientos
  has_many :adjuntos, :as => :attachable, :dependent => :destroy

  validates_associated :comentarios
  
  validates_presence_of :fecha, :message => 'La fecha es obligatoria'
  validates_presence_of :nombresolicitante, :message => 'El nombre de solicitante es obligatorio'
  validates_presence_of :asunto, :message => 'El asunto es obligatorio'
  validates_presence_of :descripcion, :message => 'La descripcion del asunto es obligatorio'
  validates_presence_of :telefono, :message => 'El telefono es olbigatorio'
  
  validates_uniqueness_of :nombresolicitante
  
  trimmed_fields :nombresolicitante
  
  Max_Attachments = 5
  Max_Attachment_Size = 3.megabyte
  
  def validate_attachments
     errors.add_to_base("Demasiados archivos el maximo es: #{Max_Attachments}") if assets.length > Max_Attachments
     assets.each {|a| errors.add_to_base("#{a.name} is over #{Max_Attachment_Size/1.megabyte}MB") if a.file_size > Max_Attachment_Size}
  end
  
  
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
