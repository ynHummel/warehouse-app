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

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 404
    end
  end
end