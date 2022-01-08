require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouses' do
    it 'successfully' do
      Warehouse.create!(
        name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
        address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
        postal_code: '57050-000',total_area: 10000, useful_area: 8000
      )
      Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
        address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
        postal_code: '08050-000',total_area: 20000, useful_area: 18000
      )

      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response[0]["name"]).to eq 'Maceió'
      expect(parsed_response[1]["name"]).to eq 'Guarulhos'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av do Aeroporto'

    end

    it 'empty response' do
      
      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response).to eq []
    end
  end
end