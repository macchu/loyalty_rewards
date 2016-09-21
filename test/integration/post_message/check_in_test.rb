require 'test_helper'

class PostMessageTest
  class CheckInTest < ActiveSupport::TestCase
    def setup
      #Note: this setup requires rails
      @message_poster = PostMessage.new({a: 1, b: 2})
      @message_poster.start_post()
    end

    test 'submits a check in message' do
      refute_nil @message_poster.authenticity_token
      assert @message_poster.authenticity_token.length > 5
    end

    
  end
end