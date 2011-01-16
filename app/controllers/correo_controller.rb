class CorreoController < ApplicationController
  def mailDeneme
     UserMailer.deliver_registration_confirmation("leon@redleon.net", "Esto es el subject", "cuerpot del mensaje")
     render :text => "OK"
   end
end
