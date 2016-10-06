require 'mailman'
require 'ap'

class ReceiveEmailService
  def self.start()
    Mailman::Application.run do
      to 'linden_hills_coop@stampstamp.com' do
        ap "Message received: to linden_hills_coop."
        CheckInMessageController.new(message)
        PreCheckIn::SMSCheckIn.new(message,'linden_hills_coop@stampstamp.com')
      end

      to 'desking.board@gmail.com' do
        ap "Message received to desking.board@gmail.com, substituting france_44."
        PreCheckIn::SMSCheckIn.new(message,'france_44@stampstamp.com')
      end
    end
  end
end