FactoryBot.define do
  factory :product_type do
    name { "DummyProduct" }
    weight {100}
    height {10} 
    width {10}
    length {10}
    supplier
  end
end