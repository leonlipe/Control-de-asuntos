class Cambio < ActiveRecord::Base
  belongs_to :asunto
  belongs_to :user
end
