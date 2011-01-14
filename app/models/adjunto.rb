class Adjunto < ActiveRecord::Base
 def uploaded_file=(incoming_file)
        self.nombrearchivo = incoming_file.original_filename
        self.tipo_contenido = incoming_file.content_type
        self.datos = incoming_file.read
    end

    def nombrearchivo=(new_filename)
        write_attribute("nombrearchivo", sanitize_filename(new_filename))
    end

    private
    def sanitize_filename(nombrearchivo)
        #get only the filename, not the whole path (from IE)
        just_filename = File.basename(nombrearchivo)
        #replace all non-alphanumeric, underscore or periods with underscores
        just_filename.gsub(/[^\w\.\-]/, '_')
    end
end
