require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  it 'postal_code is required' do 
    warehouse = Warehouse.new( 
      name: 'São Luís', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Luís', state: 'MA',
      postal_code: '', total_area: 10000, useful_area: 8000 
    )
    result = warehouse.valid?
    expect(result).to eq false
  end

  context 'invalid CEP format' do
    it 'cep 757' do
      warehouse = Warehouse.new( 
        name: 'Guarulhos', code: 'GRU', description: 'teste',
        address: 'Av teste', city: 'São Paulo', state: 'SP',
        postal_code: '757', total_area: 10000, useful_area: 8000 
      )

      result = warehouse.valid?

      expect(result).to eq false
    end

    it 'cep 757996-00' do
      warehouse = Warehouse.new( 
        name: 'Guarulhos', code: 'GRU', description: 'teste',
        address: 'Av teste', city: 'São Paulo', state: 'SP',
        postal_code: '757996-00', total_area: 10000, useful_area: 8000 
      )

      result = warehouse.valid?

      expect(result).to eq false
    end

    it 'cep 12345-6789' do
      warehouse = Warehouse.new( 
        name: 'Guarulhos', code: 'GRU', description: 'teste',
        address: 'Av teste', city: 'São Paulo', state: 'SP',
        postal_code: '12345-6789', total_area: 10000, useful_area: 8000 
      )

      result = warehouse.valid?

      expect(result).to eq false
    end

    it 'cep aaaaa-aaa' do
      warehouse = Warehouse.new( 
        name: 'Guarulhos', code: 'GRU', description: 'teste',
        address: 'Av teste', city: 'São Paulo', state: 'SP',
        postal_code: 'aaaaa-aaa', total_area: 10000, useful_area: 8000 
      )

      result = warehouse.valid?

      expect(result).to eq false
    end
    
  end

  it 'duplicate code' do
    
    warehouse = Warehouse.create( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )

    warehouse2 = Warehouse.new( 
      name: 'São Luís', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Luís', state: 'MA',
      postal_code: '00002-000', total_area: 10000, useful_area: 8000 
    )

    result = warehouse2.valid?

    expect(result).to eq false
  end
end
