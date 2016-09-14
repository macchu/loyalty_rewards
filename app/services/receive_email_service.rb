# mailman_app.rb
require 'mailman'

#Mailman.config.maildir = '~/Maildir'

Mailman::Application.run do
  puts "Starting Mailman..."
  puts Mailman.config.imap
  to 'desking.board@gmail.com' do
    puts "Message received"
    puts message
  end
end