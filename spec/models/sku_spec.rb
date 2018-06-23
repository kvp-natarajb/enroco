require 'rails_helper'

RSpec.describe Sku, type: :model do

	context "Model validation" do
	  it { is_expected.to validate_presence_of(:denomination) }
	  it { is_expected.to validate_presence_of(:combination) }
	  it { is_expected.to validate_numericality_of(:denomination) }
	end
end
