require 'rails_helper'

RSpec.describe ProductType, type: :model do
  it '.dimensions' do
    p = ProductType.new(height: 14, width: 10, length: 12)

    result = p.dimensions

    expect(result).to eq '14 x 10 x 12'
  end

  context 'invalid dimension format' do
    
    it 'negative weight' do
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: -300, height: 14, width: 10, 
        length: 12, supplier: supp
      )

      result = p.valid?

      expect(result).to eq false
    end

    it 'Null weight' do
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 0, height: 14, width: 10, 
        length: 12, supplier: supp
      )

      result = p.valid?

      expect(result).to eq false
    end
    
    it 'invalid height' do
      supp =  Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 300, height: -14, width: 10, 
        length: 12, supplier: supp
      )

      result = p.valid?

      expect(result).to eq false
    end

    it 'invalid width' do
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 300, height: 14, width: 0, 
        length: 12, supplier: supp
      )

      result = p.valid?

      expect(result).to eq false
    end

    it 'invalid length' do
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 300, height: 14, width: 10, 
        length: -12, supplier: supp
      )

      result = p.valid?

      expect(result).to eq false
    end

  end
  
end
