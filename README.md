# Call Me Maybe

Haven't mananged to keep in touch? Call Me Maybe is an app to schedule video chats.

Simply pick an available slot in on the Calendar, optionally enter your phone number (for a text message reminder), add your email address (for a video chat link) and take the call directly in your browser (using Twilio Video).

### Screenshots

#### Schedule Page
<img src="https://github.com/at1as/at1as.github.io/raw/master/github_repo_assets/call-me-maybe1.png" width="700px"/>

#### Video Chat Page
<img src="https://github.com/at1as/at1as.github.io/raw/master/github_repo_assets/call-me-maybe2.png" width="700px"/>

### Running

Call Me Maybe uses:
* ActionMailer to send out emails. Configure email credentials in `config/environments/production.rb` (note that gmail accounts require [configuration changes](http://guides.rubyonrails.org/action_mailer_basics.html) to work with ActionMailer).
* Twilio for sending SMS (provide AUTH_TOKEN and ACCOUNT_SID as environment variables)
* Twilio for video (provide TWILIO_API_KEY_SID and TWILIO_SECRET as environment variables)
* Sidekiq (redis) for scheduling emails and text messages

```
# Start Redis
$ brew services start redis

# Start Sidekiq
$ TWILIO_ACCOUNT_SID=<ACCOUNT_SID> TWILIO_AUTH_TOKEN=<AUTH_TOKEN> bundle exec sidekiq

# Start postgres
$ pg_ctl -D /usr/local/var/postgres start

# Start Rails
$ TWILIO_ACCOUNT_SID=<AC...> TWILIO_AUTH_TOKEN=<AUTH_TOKEN> TWILIO_API_KEY_SID=<SK...> TWILIO_SECRET=<SECRET> rails s
```

Note that Chrome browser requires HTTPS. One quick way to accomplish this without an SSL cert is to tunnel through ngrok `$ ngrok http 3000` and connect via https.

### Testing

To test the jobs that send twilio SMS, provide Twilio test credentials, so that real interaction with the Twilio API is performed:  

`TWILIO_ACCOUNT_SID=<test_account_sid> TWILIO_AUTH_TOKEN=<test_auth_token> FROM_NUMBER=+15005550006 rails test`. 


### Notes

* Developed with Rails 5.1 on macOS using Ruby 2.4
* Video chat will work in Chrome (only over https), Firefox (http/https), but not in Safari
* Emailed URLs will contain a URL param `token=<....>"`. This parameter is unique and required for the client to connect to Twilio. Emails are sent out with a unique token in the link just before the chat, and tokens will expire shortly thereafter.


## TODO

* Email Chat link needs to be changed from `localhost:3000` to whereever the link the site is hosted at
* Change video URL from including token to user accessing page by providing email address

