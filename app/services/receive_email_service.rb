require 'mailman'
require 'ap'

class ReceiveEmailService
  def self.start()
    Mailman::Application.run do
      to 'linden_hills_coop@stampstamp.com' do
        ap "Message received: to linden_hills_coop."
        CheckInMessageController.new(message)
      end
    end
  end
end