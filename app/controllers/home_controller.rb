class HomeController < ApplicationController
	def index
		@articles = Article.all
		@banners = Banner.all
	end

	def about
	end

	def contact
		@message = Message.new
	end

	def credits
	end
	
	def submit_email
		@message = Message.new(message_params)
		if @message.save
			ContactMailer.contact_message(@message).deliver
			redirect_to contact_path, notice: "Your messages has been sent."
		else
			flash[:alert] = "An error occurred while delivering this message. Please e-mail sabrxphotography@gmail.com."
			redirect_to contact_path, notice: "Your messages has not been sent."
		end
	end
	

	
	def message_params
		params.require(:message).permit(:email, :category, :content)
	end




end
