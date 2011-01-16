class Adjunto < ActiveRecord::Base
  has_attached_file :adjunto,
                    :url  => "/adjuntos/:id",
                    :path => ":rails_root/adjuntos/docs/:id/:style/:basename.:extension"
  
  belongs_to :attachable, :polymorphic => true
  def url(*args)
    adjunto.url(*args)
  end
  
  def name
    adjunto_file_name
  end
  
  def content_type
    adjunto_content_type
  end
  
  def file_size
    adjunto_file_size
  end
end
