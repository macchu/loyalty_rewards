class StampedCardInterceptor
  class << self
 
    def delivering_email(mail)
      ap "mail methods:"
      ap mail.methods

      ap mail.subject
      # mail.parts.each_with_index do |part, i|
      #   ap "part[#{i}]: #{part}"
      # end
      ap "content_id: #{mail.parts.last.content_id}"
      mail.parts.last.content_id = nil
      ap "new content_id: #{mail.parts.last.content_id}"
      ap "content_id: #{mail.content_id}"
      ap "content_description: #{mail.content_description}"
      ap "file_name: #{mail.filename}"

      mail.content_id = nil
    end
 
  end
end
