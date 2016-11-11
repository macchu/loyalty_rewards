require 'test_helper'

#Tests basic checkin and enrollment functionality.
class ParseEmailMessageModelTests < ActiveSupport::TestCase
  def setup
    sms_check_in_with_code = Mail.read("#{Rails.root}/test/fixtures/messages/sms_check_in_with_code.eml")
    @parsed_message_for_existing_patron = ParseEmailMessage.new(sms_check_in_with_code)
  end

  test '.sender_local_part' do
    assert_equal '9528761234', @parsed_message_for_existing_patron.sender_local_part
  end

end