#Determines how to respond to the patron's message.
#  Echos logic found in controllers/check_ins_controller.rb
class CheckInMessageController
  def initialize(message)
    parsed_message = ParseEmailMessage.new(message)

    @check_in = CheckIn.new(parsed_message.check_in_params)

    case @check_in.status
    when :check_in
      
    when :enroll
      @check_in_id = @check_in.id
      @new_patron = Patron.new(phone_number: @check_in.phone_number)
      send_complete_check_in_message(@new_patron)
    
    end
  end
end