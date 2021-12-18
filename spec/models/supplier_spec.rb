require 'rails_helper'

RSpec.describe Supplier, type: :model do
  
  it 'with duplicated CNPJ' do
    supp1 = Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )

    supp2 = Supplier.new( 
      trading_name: 'Real Supplier', company_name: 'RS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Serviços',
      email: 'realprodutos@fornecimentos.com', telephone: '00000001' 
    )

    result = supp2.valid?
    expect(result).to eq false

  end

  it 'with shorter CNPJ - 1234567890123' do
    supp = Supplier.new( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '1234567890123', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )

    result = supp.valid?
    expect(result).to eq false
  end


  it 'with longer CNPJ - 123456789012345' do
    supp = Supplier.new( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '123456789012345', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )

    result = supp.valid?
    expect(result).to eq false
  end

end
