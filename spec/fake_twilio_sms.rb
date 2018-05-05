class FakeTwilioSMS

  cattr_accessor :messages
  self.messages = []

  def self.last_message
    self.messages.last
  end

  def initialize(_sid, _token)
  end

  def messages()
    self
  end

  def create(params)
    self.class.messages << params
  end
end
