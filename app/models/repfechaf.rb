class Repfechaf < ActiveForm
  attr_accessor :fecha_inicial, :fecha_final
  validates_presence_of :fecha_inicial, :fecha_final
end