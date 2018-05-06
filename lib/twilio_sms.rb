require 'twilio-ruby'

class TwilioSMS
  cattr_accessor :client
  self.client = Twilio::REST::Client

  def initialize(account_sid, auth_token, sender)
    @client = self.class.client.new(account_sid, auth_token)
    @sender = sender
  end

  def send(message, receiver)
    @client.messages.create({
      from: @sender,
      to: receiver,
      body: message
    })
  end
end
