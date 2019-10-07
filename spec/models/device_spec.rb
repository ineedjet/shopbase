# frozen_string_literal: true

require "rails_helper"

RSpec.describe Device, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:kind) }

    it { should validate_presence_of(:number) }
    it { should validate_numericality_of(:number) }
    it { should validate_uniqueness_of(:number).case_insensitive }

    it { should belong_to(:organization).optional }
  end
end
