require 'twilio_sms'
require 'fake_twilio_sms'

TwilioSMS.client = FakeTwilioSMS
