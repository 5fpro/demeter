namespace :dev do

  desc 'Rebuild from schema.rb'
  task build: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'dev:fake']

  desc 'Rebuild from migrations'
  task rebuild: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'dev:fake']

  desc 'generate fake data for development'
  task fake: :environment do
    email = 'admin@5fpro.com'
    password = '12341234'
    Tyr::Administrator.find_by(email: email) || Tyr::Administrator.create(email: email, password: password, root: true)
    puts "Admin email: #{email} password: '#{password}'"
  end

end
