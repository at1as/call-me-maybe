class GuestMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def video_scheduled_email(email_address, start_time)
    @email = email_address
    @start_time = start_time

    mail(to: @email, subject: 'Scheduled: Upcoming Chat')
  end
  
  def video_url_email(email_address, start_time, token)
    @email = email_address 
    @start_time = start_time
    @token = token

    mail(to: @email, subject: "Here's your link: Upcoming Chat!")
  end

  def cancel_video_chat_email(email_address, start_time)
  	@email = email_address
  	@start_time = start_time
  	
  	mail(to: @email, subject: 'Cancelled: Upcoming Chat')
  end
end
