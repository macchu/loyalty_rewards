if Rails.env.development?
  ActionMailer::Base.register_interceptor(StampedCardInterceptor)
end