class WelcomeMailer < ApplicationMailer
  def send_welcome_mail
    mail(to: "mithilesh.goyal2@gmail.com" , from:"mithilesh.goyal1@gmail.com",subject:"trymail", message:"hiii!")
  end
end
