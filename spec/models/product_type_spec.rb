require 'rails_helper'

RSpec.describe ProductType, type: :model do
  it '.dimensions' do
    p = ProductType.new(height: 14, width: 10, length: 12)

    result = p.dimensions

    expect(result).to eq '14 x 10 x 12'
  end
end
