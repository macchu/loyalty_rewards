# mailman_app.rb
require 'mailman'

class ReceiveEmailService
  def self.start()
    Mailman::Application.run do
      to 'desking.board@gmail.com' do
        puts message
      end
    end
  end
end