# frozen_string_literal: true

require "rails_helper"

RSpec.describe Client, type: :model do
  describe "validations" do
    it { should validate_presence_of(:fullname) }
    it { should validate_length_of(:fullname).is_at_least(5) }

    it { should validate_presence_of(:phone) }
    it { should validate_numericality_of(:phone) }
    it { should validate_uniqueness_of(:phone).case_insensitive }
  end
end
