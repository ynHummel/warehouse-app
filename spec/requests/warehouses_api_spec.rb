require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'successfully' do
      Warehouse.create!(
        name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
        address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
        postal_code: '57050-000', total_area: 10000, useful_area: 8000
      )
      Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
        address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
        postal_code: '08050-000', total_area: 20000, useful_area: 18000
      )

      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response[0]["name"]).to eq 'Maceió'
      expect(parsed_response[1]["name"]).to eq 'Guarulhos'
    end

    it 'empty response' do
      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'successfully' do
      w = Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
        address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
        postal_code: '08050-000', total_area: 20000, useful_area: 18000
      )

      get "/api/v1/warehouses/#{w.id}"

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response["name"]).to eq 'Guarulhos'
      expect(parsed_response["code"]).to eq 'GRU'
      expect(parsed_response["city"]).to eq 'Guarulhos'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'warehouse dont exist' do
      get '/api/v1/warehouses/999'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'successfully' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{
        "name": "Maceió",
        "code": "MCZ",
        "description":
        "Desc teste",
        "address": "Av. teste",
        "city": "Maceió", "state": "AL",
        "postal_code": "50000-000",
        "total_area": 5000,
        "useful_area": 2000
        }', headers: headers

      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Maceió'
      expect(parsed_response["code"]).to eq 'MCZ'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end

    it 'has required fields' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{
        "code": "MCZ",
        "description":
        "Desc teste",
        "address": "Av. teste",
        "city": "Maceió", "state": "AL",
        "postal_code": "50000-000",
        "total_area": 5000,
        "useful_area": 2000
        }', headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

    it 'code is not unique' do
      Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
        address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
        postal_code: '08050-000', total_area: 20000, useful_area: 18000
      )

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{
        "name": "Maceió",
        "code": "GRU",
        "description":
        "Desc teste",
        "address": "Av. teste",
        "city": "Maceió", "state": "AL",
        "postal_code": "50000-000",
        "total_area": 5000,
        "useful_area": 2000
        }', headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include 'Código já está em uso'
    end
  end
end
