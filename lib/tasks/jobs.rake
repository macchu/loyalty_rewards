namespace :jobs do
  desc "Begin rake task to for listening to email."
  task :work => :environment do
    MailmanServiceJob.perform_now
  end
end