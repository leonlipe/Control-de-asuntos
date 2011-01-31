# Assign the path to your file name first to a local variable.
logopath = "#{RAILS_ROOT}/public/images/mainlogo.jpg"
pdf.image logopath, :width => 197, :height => 91
pdf.move_down 70
pdf.font "Helvetica"
pdf.font_size 18
pdf.text_box "Asunto", :align => :right
pdf.font_size 20
pdf.text "Asunto para atender", :align => :center
pdf.move_down 20
pdf.font "Helvetica"
pdf.font_size 12
pdf.text "Asunto: #{@asunto.asunto}", :size => 14, :style => :bold, :spacing => 4
pdf.move_down(10)
pdf.text "Fecha: #{@asunto.fecha}", :spacing => 16
pdf.move_down(5)
pdf.text "Nombre del solicitante: #{@asunto.nombresolicitante}", :spacing => 16
pdf.move_down(5)
pdf.text "Organizacion: #{@asunto.organizacion}", :spacing => 16
pdf.move_down(5)
pdf.text "Descripcion: #{@asunto.descripcion}", :spacing => 16
pdf.move_down(5)
pdf.text "Telefono: #{@asunto.telefono}", :spacing => 16
pdf.move_down(5)
pdf.text "Observaciones: #{@asunto.observaciones}", :spacing => 16
pdf.move_down(5)
pdf.text "Atendido por: #{@asunto.personaatendio}", :spacing => 16
pdf.move_down(5)
pdf.text "Turnado a: #{@asunto.personaturnado}", :spacing => 16
pdf.move_down(5)
pdf.text "Prioridad: #{@asunto.prioridaddesc}", :spacing => 16
pdf.move_down(5)
pdf.text "Categoria: #{@asunto.categoriadesc}", :spacing => 16
pdf.move_down(5)
pdf.text "Fecha del ultimo contacto: #{@asunto.fechaultcont}", :spacing => 16
pdf.move_down(5)
pdf.text "Fecha del siguiente contacto: #{@asunto.fechasigcont}", :spacing => 16
pdf.move_down(5)
pdf.text "Status: #{@asunto.status.tipo}", :spacing => 16
pdf.move_down(10)
pdf.text "Comentarios", :size => 14, :style => :bold, :spacing => 4
@asunto.comentarios.each do |comentario|
pdf.text "#{comentario.user.name} en #{comentario.created_at.to_s(:short)} dijo:  #{comentario.comentario}", :spacing => 16
pdf.move_down(3)

end
