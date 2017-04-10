namespace :db do
  desc "Import data"
  task :remake_data do
    puts "**********Reset Database**********"
    Rake::Task["db:migrate:reset"].invoke
    puts "**********Create Data**********"
    Rake::Task["db:datas"].invoke
  end
end
