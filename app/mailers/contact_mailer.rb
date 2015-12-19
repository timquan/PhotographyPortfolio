class ContactMailer < ActionMailer::Base
  #Specify default e-mail address
  default from: "test@example.com"

  def contact_message(message)
	@message = message
    mail to: "test@example.com", subject: "Message received from " + message.email + " about " + message.category, body: message.content
  end
end
