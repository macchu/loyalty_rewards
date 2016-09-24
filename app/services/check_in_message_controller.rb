#Determines how to respond to the patron's message.
#  Echos logic found in controllers/check_ins_controller.rb
class CheckInMessageController
  def initialize(message)
    Rails.logger.info " #{self.class.to_s}##{__method__.to_s}"
    parsed_message = ParseEmailMessage.new(message)
    
    params = { phone_number: parsed_message.sender_local_part }
    @check_in = CheckIn.create(params)
    case @check_in.status
    when :check_in
      
    when :enroll_patron
      Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: :enroll_patron #{parsed_message.sender} "
      # @check_in_id = @check_in.id
      # @new_patron = Patron.new(phone_number: @check_in.phone_number)
      PatronEnrollmentMailer.provide_name(parsed_message.sender).deliver_now

    when :finished_enrollment
       Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: :finished_enrollment"

    end
  end
end