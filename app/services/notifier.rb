require 'twilio_sms'

class Notifier
  def self.send_task_complete_notification(task)
    # In a more complete system, tasks probably track an owner,
    # the authenticated user, or both; and that entity should
    # get the notification. As none of those exist, but I
    # don't want my number in public source control...
    recipient = ENV['SMS_RECIPIANT']

    twilio_sms = TwilioSMS.new(
      Rails.configuration.twilio['account_sid'],
      Rails.configuration.twilio['auth_token'],
      Rails.configuration.twilio['sender']
    )

    # TODO: don't hard code the number
    twilio_sms.send(
      "Task #{task.name} complete!",
      recipient
    )
  end
end
