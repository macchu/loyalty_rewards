class MailmanServiceJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Mailman::Application.run do
      to 'linden_hills_coop@stampstamp.com' do
        ap "Message received: to linden_hills_coop."
        CheckInMessageController.new(message)
        PreCheckIn::SMSCheckIn.new(message,'linden_hills_coop@stampstamp.com')
      end

      to 'admin@rasmussonprogramming.com' do
        ap "Message received to admin@rasmussonprogramming.com, substituting france_44."
        PreCheckIn::SMSCheckIn.new(message,'france_44@stampstamp.com')
      end

      to 'demo_%id%@rasmussonprogramming.com' do
        Rails.logger.info("Received message for demo_#{params[:id]}@rasmussonprogramming.com")
        PreCheckIn::SMSCheckIn.new(message,'france_44@stampstamp.com')
        Rails.logger.info("Done")
      end

      to 'demo@freebeefor.me' do
        Rails.logger.info("Received message for demo@freebeefor.me")
        PreCheckIn::SMSCheckIn.new(message,'france_44@stampstamp.com')
        Rails.logger.info("Done")
      end

    end
  end
end
