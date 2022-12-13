namespace :dev do
  desc "configura ambeinte de desenvolvimento"
  task setup: :environment do
    
    %x(rails db:drop db:create db:migrate)

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end

    puts "tipos de contatos cadastrados"

    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end 

    puts "contatos cadastrados"
    
    Contact.all.each do |contact|
      Random.rand(1..5).times do |i|
        phone = Phone.create!(number:Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    puts "telefones cadastrados"

    Contact.all.each do |contact|
      Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end

    puts "edereços cadastrados"
  end
end
