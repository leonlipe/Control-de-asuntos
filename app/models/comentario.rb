class Comentario < ActiveRecord::Base
  belongs_to :asunto
  belongs_to :user
  validates_presence_of :comentario, :message => 'El comentario no puede estar vacío'
  validates_presence_of :user
end
