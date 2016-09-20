require 'mailman'

# Extracts elements from a Mail object.  Usefull for instantiating a 
# a model object, like LoyaltySubmission, that persists those elements in
# a database and trigger other business processes.
#
# ==== Examples
#   Steps
#   1. mail_elements = EmailMessageParser.new(message) #=> {sender: 'mthomas@yahoo.com', subject: 'Enroll in rewards', body: 'Please..',..}
#   2. LoyaltySubmission.create(mail_elements)
class ParseEmailMessage
  attr_reader :sender, :sender_local_part, :body, :body_text_part, :body_html_part, :recipient
  
  def initialize(message)
    Rails.logger.info "#{self.class.to_s}##{__method__.to_s}:"
    @sender = message.from.nil? ? "unknown" : message.from.first
    @sender_local_part = sender.partition('@').first
    @body = message.body.to_s
    @recipient = message.to.first

    if message.multipart?
      message.parts.each do |part|
        case part.content_type
        when 'text/plain'
          @body_text_part = part.decode_body
        when 'text/HTML'
          @body_html_part = part.decode_body
        else
          # Do nothing.
        end
      end
    end

    params =  { check_in_strategy: CheckInStrategy.find_by_name(:sms_with_code), 
                phone_number: @sender_local_part,
                store: Store.find_by_email_for_check_ins(@recipient),
                patronage_proof_attributes: { @body_html_part}
              }

    @check_in = CheckIn.new(params)
    #LoyaltySubmission.create(sender: sender, body: body)
  end
end