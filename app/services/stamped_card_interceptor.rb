class StampedCardInterceptor
  class << self
 
    def delivering_email(mail)
      #TODO: 1) Can content-id be set without an interceptor?  Possibly when the message is first mailed?
      #      2) At least dynamically access the "part" containing the attachment.
      
      #The presence of content-id in the attachment part of the email, causes iMessage to choke and
      #   not display the attached loyalty card.  Setting it to nil avoids this problem.
      mail.parts.each do |part|
        if part.content_id.nil?
          #Do nothing.
          Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: Content-ID is nil."
        else
          Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: Content-ID: #{part.content_id}"
          part.content_id = nil
        end
      end
    end
  end
end
