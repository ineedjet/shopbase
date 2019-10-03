# frozen_string_literal: true

require "rails_helper"

RSpec.describe Staff, type: :model do
  describe "validation" do
    it { should validate_presence_of(:fullname) }
    it { should validate_length_of(:fullname).is_at_least(5) }

    it { should validate_presence_of(:position) }
  end
end
