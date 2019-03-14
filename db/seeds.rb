puts "Cleaning database"
  User.destroy_all
  Lead.destroy_all
  LeadStatus.destroy_all
  SalesFunnelStage.destroy_all
puts "Done"







puts "Generating users..."
USERS = [
  { email: 'rayancdc@gmail.com', password: 'flipper', name: 'Rayan Castro', admin: true },
  { email: 'bruna@hortalab.com', password: 'flipper', name: 'Bruna Correa', admin: true },
  { email: 'admin@flipper.com', password: 'flipper', name: 'Nick Tesla', admin: true }
]



USERS.each do |user_params|
  User.create!(user_params)
end

puts "You have #{User.count} users"

puts "Generating Lead Statuses"

[ { name: "Em aberto", identifier: 0 },
  { name: "Perdido", identifier: 1 },
  { name: "Ganho", identifier: 2 },
].each do |params|
  LeadStatus.create!(params)
end

puts "You have #{LeadStatus.count} lead statuses"

puts "Generating Sales Funnel Stages"

[ { name: "Pesquisa", identifier: 0 },
  { name: "Smart Leads", identifier: 1 },
  { name: "Conectados", identifier: 2 },
  { name: "MQL", identifier: 3 },
  { name: "SQL", identifier: 4 },
  { name: "Nutrição", identifier: 5 },
  { name: "Propostas Enviadas", identifier: 6 },
  { name: "Forecast", identifier: 7 },
  { name: "Fechamento", identifier: 8 }
].each do |params|
  SalesFunnelStage.create!(params)
end

puts "You have #{SalesFunnelStage.count} sales funnel stages"


unless Rails.env.production?
  puts "Generating Leads"

  30.times do 
  name = Faker::Company.name
  Lead.create!( business_name: name, 
                revenue: rand(500..5000),
                closure_date: Time.now - rand(-30..30).days,
                sales_funnel_stage: SalesFunnelStage.all.sample, 
                lead_status: LeadStatus.all.sample, 
                website: "#{name}.com".gsub(" ", "").downcase, 
                address: Faker::Address.street_address, 
                city: "São Paulo", 
                state: "SP"
                )
  end

  puts "You have #{Lead.count} leads"
end