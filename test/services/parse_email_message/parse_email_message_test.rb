require 'test_helper'

#Tests basic checkin and enrollment functionality.
class ParseEmailMessageModelTests < ActiveSupport::TestCase
  test ".sender_local_part" do
    sms_check_in_with_code = Mail.read("#{Rails.root}/test/fixtures/messages/sms_check_in_with_code.eml")
    @parsed_message_for_existing_patron = ParseEmailMessage.new(sms_check_in_with_code)
    assert_equal '9528761234', @parsed_message_for_existing_patron.sender_local_part
  end

  test ".demo? is false with message to 'linden_hills_coop@stampstamp.com'" do
    sms_check_in_with_code = Mail.read("#{Rails.root}/test/fixtures/messages/sms_check_in_with_code.eml")
    @parsed_message_for_existing_patron = ParseEmailMessage.new(sms_check_in_with_code)
    refute @parsed_message_for_existing_patron.is_demo
  end

  test ".demo? is true with message to" do
    demo_check_in = Mail.read("#{Rails.root}/test/fixtures/messages/demo_check_in.eml")
    parsed_demo_message = ParseEmailMessage.new(demo_check_in)
    assert parsed_demo_message.is_demo
  end

end