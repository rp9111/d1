namespace :db do
  desc 'Migrates to VERSION 0 and migrates forward again'
  task remigrate: :environment do
    `rake db:migrate VERSION=0`
    `rake db:migrate`
    `rake db:test:clone`
    puts 'done...'
  end

  desc 'Migrates to VERSION 0, drops, creates, and migrates forward again'
  task nuke: :environment do
    `rake db:drop`
    `rake db:create`
    `rake db:migrate`
    `rake db:test:clone`
    puts 'done...'
  end
end
