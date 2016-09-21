require 'mailman'
require 'ap'

class ReceiveEmailService
  def self.start()
    Mailman::Application.run do
      # to 'desking.board@gmail.com' do
      #   ap "message received!"
      #   puts message
      # end

      to 'linden_hills_coop@stampstamp.com' do
        ap "Message received: to linden_hills_coop.", options = {color: { string: :green} }
        CheckInMessageController.new(message)
      end
    end
  end
end