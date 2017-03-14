if Rails.env.development? or Rails.env.production?
  ActionMailer::Base.register_interceptor(StampedCardInterceptor)
end