# frozen_string_literal: true

require "rails_helper"

RSpec.describe Organization, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:kind) }

    it { should validate_presence_of(:inn) }
    it { should validate_numericality_of(:inn) }

    it { should validate_presence_of(:ogrn) }
    it { should validate_numericality_of(:ogrn) }

    it { should have_and_belong_to_many(:clients) }
    it { should have_many(:hardwares) }
  end
end
