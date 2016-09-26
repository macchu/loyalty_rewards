require 'mailman'

# Extracts elements from a Mail object and determines if it is a
# check_in or an enrollment message.
#
# ==== Examples
#   
class ParseEmailMessage
  attr_reader :sender, :sender_local_part, :body, :body_text_part, :body_html_part, :recipient
  
  def initialize(message)
    Rails.logger.info "#{self.class.to_s}##{__method__.to_s}:"
    @sender = message.from.nil? ? "unknown" : message.from.first
    @sender_local_part = @sender.partition('@').first
    @body = message.body.to_s
    @recipient = message.to.first

    if message.multipart?
      message.parts.each do |part|
        case 
        when part.content_type.include?('text/plain')
          @body_text_part = part.decode_body
        when part.content_type.include?('text/HTML')
          @body_html_part = part.decode_body
        else
          # Do nothing.
        end
      end
    end
  end
end