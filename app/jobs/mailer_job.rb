class MailerJob < ApplicationJob
  queue_as :default
  # retry_count :0
  # sidekiq_options :queue => :default, :retry => false, :backtrace => true

  def perform(notification, obj, *args)
    Devise.mailer.send(notification.to_sym, obj, *args)
  end
end
