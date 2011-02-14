class UserMailer < ActionMailer::Base
  def registration_confirmation(destinatario, subject, cuerpo)
     recipients  destinatario
     from        "control@test.com"
     subject     subject
     body        cuerpo #if you want to pass parameter do it like this -- > ":user => user"
   end

end
