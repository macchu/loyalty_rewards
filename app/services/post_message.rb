include Rails.application.routes.url_helpers

class PostMessage
  attr_reader :message, :uri, :authenticity_token
  
  def initialize(message)
    @message = message
    Rails.application.routes.default_url_options[:host] ||= Rails.configuration.default_host_for_posting_emails
    @uri = URI(check_ins_url)
  end

  def start
    acquire_authenticity_token_using_get
  end

  private

  def acquire_authenticity_token_using_get()
    page = Nokogiri::HTML(open(check_ins_url)) 
    @authenticity_token = page.at("input[name='authenticity_token']")['value']
  end

  def post_message
    Net::HTTP.post_form @uri,
                        { authenticity_token: @authenticity_token, "q" => "ruby", "max" => "50" }
  end

end