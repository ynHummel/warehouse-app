require 'rails_helper'

describe 'Supplier API' do
  context 'GET /api/v1/suppliers' do
    it 'successfully' do 
      Supplier.create!(
        trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
        cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
        email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
      )
      Supplier.create!(
        trading_name: 'Canecas e Copos', company_name: 'A Fantastica Fabrica de Canecas LTDA',
        cnpj: '51905325000154', address: 'Avenida Matrix, 1',
        email: 'canecas@gmail.com', telephone: '51 3456-7890'
      )

      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response[0]["trading_name"]).to eq 'Samsung'
      expect(parsed_response[1]["trading_name"]).to eq 'Canecas e Copos'
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
    end

    it 'empty response' do
      
      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/suppliers/:id' do
    it 'successfully' do
      supp = Supplier.create!(
        trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
        cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
        email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
      )
      
      get "/api/v1/suppliers/#{supp.id}"

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response["trading_name"]).to eq 'Samsung'
      expect(parsed_response["cnpj"]).to eq '85935972000120'
      expect(parsed_response["email"]).to eq 'financeiro@samsung.com.br'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'supplier dont exist' do
      
      get '/api/v1/suppliers/999'

      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/suppliers' do
    it 'successfully' do
      headers = { "CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{
        "trading_name": "Samsung",
        "company_name": "Samsung do BR LTDA",
        "cnpj": "85935972000120",
        "address": "Av Industrial, 1000, São Paulo",
        "email": "financeiro@samsung.com.br",
        "telephone": "11 1234-5678"
      }', headers: headers

        expect(response.status).to eq 201
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["trading_name"]).to eq 'Samsung'
        expect(parsed_response["company_name"]).to eq 'Samsung do BR LTDA'
        expect(parsed_response["cnpj"]).to eq '85935972000120'
        expect(parsed_response["address"]).to eq 'Av Industrial, 1000, São Paulo'
        expect(parsed_response["email"]).to eq 'financeiro@samsung.com.br'
        expect(parsed_response["telephone"]).to eq '11 1234-5678'
        expect(parsed_response["id"]).to be_a_kind_of(Integer)
        expect(parsed_response.keys).not_to include 'created_at'
        expect(parsed_response.keys).not_to include 'updated_at'
      
    end

    it 'has required fields' do
      headers = { "CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{
        "address": "Av Industrial, 1000, São Paulo",
        "telephone": "11 1234-5678"
      }', headers: headers
      
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome Fantasia não pode ficar em branco'
      expect(response.body).to include 'Razão Social não pode ficar em branco'
      expect(response.body).to include 'CNPJ não pode ficar em branco'
      expect(response.body).to include 'E-mail não pode ficar em branco'
      expect(response.body).to include 'CNPJ não possui o tamanho esperado'
    end

    it 'cnpj is not unique' do
      Supplier.create!(
        trading_name: 'Canecas e Copos', company_name: 'A Fantastica Fabrica de Canecas LTDA',
        cnpj: '51905325000154', address: 'Avenida Matrix, 1',
        email: 'canecas@gmail.com', telephone: '51 3456-7890'
      )

      headers = { "CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{
        "trading_name": "Samsung",
        "company_name": "Samsung do BR LTDA",
        "cnpj": "51905325000154",
        "address": "Av Industrial, 1000, São Paulo",
        "email": "financeiro@samsung.com.br",
        "telephone": "11 1234-5678"
      }', headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include 'CNPJ já está em uso'

    end

    it 'and lost connection to the database' do
      allow(Supplier).to receive(:new).and_raise ActiveRecord::ConnectionNotEstablished

      headers = { "CONTENT_TYPE" => "application/json"}
      post '/api/v1/suppliers', params: '{
        "trading_name": "Samsung",
        "company_name": "Samsung do BR LTDA",
        "cnpj": "85935972000120",
        "address": "Av Industrial, 1000, São Paulo",
        "email": "financeiro@samsung.com.br",
        "telephone": "11 1234-5678"
      }', headers: headers

      expect(response.status).to eq 503
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Não foi possível conectar ao banco de dados'

    end

  end
  
end