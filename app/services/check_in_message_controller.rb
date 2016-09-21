#Determines how to respond to the patron's message.
#  Echos logic found in controllers/check_ins_controller.rb
class CheckInMessageController
  def initialize(message)
    parsed_message = ParseEmailMessage.new(message)
    params = { phone_number: parsed_message.sender_local_part }
    @check_in = CheckIn.create(params)

    case @check_in.status
    when :check_in
      
    when :enroll
      @check_in_id = @check_in.id
      @new_patron = Patron.new(phone_number: @check_in.phone_number)
      #send_complete_check_in_message(@new_patron)
    
    end
  end
end