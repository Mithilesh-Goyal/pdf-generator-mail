# class PostMailer < ApplicationMailer

#   # Subject can be set in your I18n file at config/locales/en.yml
#   # with the following lookup:
#   #
#   #   en.post_mailer.new_post.subject
#   #
#   def new_post
#     post = Post.first
#     @post = Post.first

#   pdf = WickedPdf.new.pdf_from_string(
#     render_to_string('posts/post.html.erb', layout: 'pdf.html.erb')
#   )
#    attachments["post_#{post.id}.pdf"] = pdf
#     @greeting = "Hi"

#     mail to: "to@example.org"
#   end
# end

# # pdf = render_to_string pdf: "some_file_name", template: "invoices/download", encoding: "UTF-8"


# class PostMailer < ApplicationMailer
#   def send_post_pdf(post_id, recipient_email)
#     @post = Post.find(post_id)

#     pdf_content = # Generate PDF content using Prawn or Wicked PDF

#     attachments["post_#{@post.id}.pdf"] = {
#       content: pdf_content,
#       mime_type: "application/pdf"
#     }

#     mail(to: recipient_email, subject: "Post PDF")
#   end
# end





class PostMailer < ApplicationMailer
  def post_pdf(post, recipient_email)
    @post = post
    attachments['post.pdf'] = create_pdf(post)
    mail(to: recipient_email, subject: "Post PDF: #{@post.title}")
  end

  def send_post_pdf(post_id, recipient_email)
    @post = Post.find(post_id)
    mail(to: recipient_email, subject: "Your Post PDF")
  end


  private

  def create_pdf(post)
    # Use a PDF generation library (e.g., Prawn, Wicked PDF) to create the PDF
    pdf_content = WickedPdf.new.pdf_from_string(render_to_string(template: "posts/pdf", layout: "pdf.html"))
    return pdf_content
  end
end
