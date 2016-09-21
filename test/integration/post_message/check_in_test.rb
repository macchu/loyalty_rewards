require 'test_helper'

#TODO: Delete
class PostMessageTest
  class CheckInTest < ActionDispatch::IntegrationTest
    def setup
      # #Note: this setup requires rails
      # @message_poster = PostMessage.new({a: 1, b: 2})
      # @message_poster.start_post()
      host! 'www.example.com'
    end

    test 'submits a check in message' do
      message_poster = PostMessage.new({a: 1, b: 2})
      message_poster.start_post()
      refute_nil message_poster.authenticity_token
      assert message_poster.authenticity_token.length > 5
    end

    test 'server running' do
      get check_ins_path
      assert_response :success
    end
    
  end
end