pdf.font "Helvetica"
pdf.text "Asunto: #{@asunto.asunto}", :size => 16, :style => :bold, :spacing => 4
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
pdf.text "Comentarios", :spacing => 16
@asunto.comentarios.each do |comentario|
pdf.text "#{comentario.user.name} en #{comentario.created_at.to_s(:short)} dijo:  #{comentario.comentario}", :spacing => 16
end
