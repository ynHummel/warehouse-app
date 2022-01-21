FactoryBot.define do
  factory :supplier do
    trading_name { "Samsung" }
    company_name { "samsung do BR LTDA" }
    sequence(:cnpj) { |n| "0000000000000#{n}" }
    address { "Av. Industrial, 1000, São Paulo" }
    email { "financeiro@samsung.com.br" }
    telephone { "11 1234-5678" }
  end
end
