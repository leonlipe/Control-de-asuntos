class Pendiente < ActiveRecord::Base
  belongs_to :user
  belongs_to :asunto
end
