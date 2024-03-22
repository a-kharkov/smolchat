# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    sequence(:name) { |i| "Definitely Valid Name #{i}" }
    password { Faker::Internet.password }
  end
end
