class StampedCardInterceptor
  class << self
 
    def delivering_email(mail)
      #TODO: 1) Can content-id be set without an interceptor?  Possibly when the message is first mailed?
      #      2) At least dynamically access the "part" containing the attachment.
      mail.parts.last.content_id = nil
    end
 
  end
end
