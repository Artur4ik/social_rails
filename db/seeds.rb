# frozen_string_literal: true

(1..5).each do |_n|
  User.create!(
    first_name: FFaker::NameRU.first_name,
    last_name: FFaker::NameRU.last_name,
    email: FFaker::Internet.free_email,
    country: FFaker::Address.country,
    city: FFaker::AddressRU.city,
    birthdate: '10.01.2001',
    password: '123'
  )
end
