# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "client#{n}@gmail.com" }
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
  end
end