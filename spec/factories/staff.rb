# frozen_string_literal: true

FactoryBot.define do
  factory :staff, class: Staff  do
    sequence(:email) { |n| "staff#{n}@gmail.com" }
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
  end
end
