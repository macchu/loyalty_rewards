namespace :email_service do
  desc "Begin rake task to for listening to email."
  task :listen => :environment do
    MailmanServiceJob.perform_now
  end
end