require 'rails_helper'

RSpec.describe ProductType, type: :model do
  it '.dimensions' do
    p = ProductType.new(height: 14, width: 10, length: 12)

    result = p.dimensions

    expect(result).to eq '14 x 10 x 12'
  end

  context 'SKU' do

    it 'should generate an SKU' do 
      cat = ProductCategory.create!(name: 'Monitores')
      supp1 = Supplier.create!( 
        trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
        cnpj: '12345678901234', address: 'Av dos Produtos',
        email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
      )
      p = ProductType.create!(
        name: 'Monitor Gamer', weight: 2000, supplier: supp1, 
        height: 14, width: 10, length: 12, product_category: cat
      )

      expect(p.sku).not_to eq nil
      expect(p.sku.length).to eq 20
    end

    it 'should generate a random SKU' do
      allow(SecureRandom).to receive(:alphanumeric).with(20).and_return 'KMBHINRS35JORIK7B75U'
      cat = ProductCategory.create!(name: 'Monitores')
      supp1 = Supplier.create!( 
        trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
        cnpj: '12345678901234', address: 'Av dos Produtos',
        email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
      )
      p = ProductType.new(
        name: 'Monitor Gamer', weight: 2000, supplier: supp1, 
        height: 14, width: 10, length: 12, product_category: cat
      )

      p.save()

      expect(p.sku).to eq 'KMBHINRS35JORIK7B75U'

    end

    it 'should not update sku' do
      # allow(SecureRandom).to receive(:alphanumeric).with(20).and_return 'KMBHINRS35JORIK7B75U'
      cat = ProductCategory.create!(name: 'Monitores')
      supp1 = Supplier.create!( 
        trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
        cnpj: '12345678901234', address: 'Av dos Produtos',
        email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
      )
      p = ProductType.new(
        name: 'Monitor Gamer', weight: 2000, supplier: supp1, 
        height: 14, width: 10, length: 12, product_category: cat
      )
      p.save()
      sku = p.sku()

      p.update(name:'Monitor 4k')

      expect(p.name).to eq 'Monitor 4k'
      expect(p.sku).to eq sku

    end

  end

  context 'invalid dimension format' do
    
    it 'negative weight' do
      cat = ProductCategory.create!(name: 'Teste')
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: -300, height: 14, width: 10, 
        length: 12, supplier: supp, product_category: cat
      )

      result = p.valid?

      expect(result).to eq false
    end

    it 'Null weight' do
      cat = ProductCategory.create!(name: 'Teste')
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 0, height: 14, width: 10, 
        length: 12, supplier: supp, product_category: cat
      )

      result = p.valid?

      expect(result).to eq false
    end
    
    it 'invalid height' do
      cat = ProductCategory.create!(name: 'Teste')
      supp =  Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 300, height: -14, width: 10, 
        length: 12, supplier: supp, product_category: cat
      )

      result = p.valid?

      expect(result).to eq false
    end

    it 'invalid width' do
      cat = ProductCategory.create!(name: 'Teste')
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 300, height: 14, width: 0, 
        length: 12, supplier: supp, product_category: cat
      )

      result = p.valid?

      expect(result).to eq false
    end

    it 'invalid length' do
      cat = ProductCategory.create!(name: 'Teste')
      supp = Supplier.create!(trading_name: 'Cerâmicas Geek', 
        company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
        email: 'geekceramicas@fornecimentos.com' 
      )
      p = ProductType.new( name: 'Caneca Star Wars', sku: 'CN202100SW',
        weight: 300, height: 14, width: 10, 
        length: -12, supplier: supp, product_category: cat
      )

      result = p.valid?

      expect(result).to eq false
    end

  end
  
end
