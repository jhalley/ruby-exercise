require 'twitter'

# Set up twitter client
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"] 
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

namespace :geckobots do
  desc "Just figuring out how tasks work"
  task :test, :environment do
    puts 'Seems to be working'
  end

  desc "Just figuring out how invoking tasks work"
  task :invoke_test, :environment do
    puts 'Begin invocation'
    Rake::Task['geckobots:test'].invoke
  end

  desc "Get tweets"
  task :get_tweets, :environment do
    client.search("chelseafc", :result_type => "recent").take(3).each do |tweet|
      puts tweet.text
    end
  end

  desc "Write tweet"
  task :write_tweet, [:msg] => :environment do |t, args|
    args.with_defaults(:msg => 'Ole!')
    client.update("#{args.msg}")
  end

  desc "Write reverse tweet"
  task :write_reverse_tweet, [:msg] => :environment do |t, args|
    args.with_defaults(:msg => 'Ole!')
    reversed_msg = args.msg.dup
    client.update("#{reversed_msg.reverse!}")
  end

  desc "Chelsea FC Retweeter"
  task :chelseafc_retweeter, :environment do |t, args|
    client.search("chelseafc", :result_type => "recent").take(1).each do |tweet|
      Rake::Task['geckobots:write_reverse_tweet'].invoke(tweet.text)
    end
  end
end
