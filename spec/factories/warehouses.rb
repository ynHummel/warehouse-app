FactoryBot.define do
  factory :warehouse do
    name { 'Guarulhos' }
    sequence(:code) { |n| "CD#{n}" }
    description { 'descrição teste' }
    address { 'Av. teste' }
    city { 'Guarulhos' }
    state { 'São Paulo' }
    postal_code { '00000-000' }
    total_area { 10000 }
    useful_area { 8000 }
  end
end
