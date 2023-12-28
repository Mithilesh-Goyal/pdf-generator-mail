# class WelcomeMailer < ApplicationMailer
#   def send_welcome_mail
#     mail(to: "mithilesh.goyal1@gmail.com" , from:"mithilesh.goyal1@gmail.com",subject:"trymail", message:"hello!")
#   end
# end


class WelcomeMailer < ApplicationMailer
  def send_welcome_mail(post)
    attachments['post id 2.pdf'] = File.read('/home/developer/Downloads/post id 2.pdf')

    mail(
      to: ['mithilesh.goyal2@gmail.com' , 'gouravrathod898@gmail.com'], # Add multiple recipients to the 'to' field
      cc:  ['mithilesh.goyal2@gmail.com' , 'gouravrathod898@gmail.com'], # Add multiple recipients to the 'cc' field
      from: 'mithilesh.goyal1@gmail.com',
      subject: 'Testing Mail',
      body: 'Hi!!!'
    )
  end
end
