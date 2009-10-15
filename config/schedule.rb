# Learn more: http://github.com/javan/whenever
set :cron_log, "#{RAILS_ROOT}/log/cron.log"

# We're using some weird times in here just to keep from collisions. 
# The server can handle multiple of these at a time, but it doesn't hurt to spread it out either

every 15.minutes do
  rake "-s scheduler:gift_mailer"
end

%w(42 22 2).each do |at|
  every 1.hour, :at => at.to_i  do
    rake "-s scheduler:session_cleaner"
  end
end

every 1.day, :at => '6:50am' do
  rake "-s scheduler:account_reminder"
end

every 1.day, :at => '7:18am' do
  rake "-s scheduler:gift_reminder"
end