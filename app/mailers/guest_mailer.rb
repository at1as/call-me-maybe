class GuestMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def video_url_email(email_address, start_time, token)
    @email = email_address 
    @start_time = start_time
    @token = token 

    mail(to: @email, subject: 'Upcoming Chat!')
  end
end
