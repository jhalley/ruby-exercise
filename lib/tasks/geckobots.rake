require 'twitter'

namespace :geckobots do
  desc "Just figuring out how tasks work"
  task test: :environment do
    puts 'Seems to be working'
  end

  desc "Just figuring out how invoking tasks work"
  task invoke_test: :environment do
    puts 'Begin invocation'
    Rake::Task['geckobots:test'].invoke
  end

end
