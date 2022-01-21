require 'rails_helper'

describe 'Product Type API' do
  context 'GET /api/v1/product_types' do
    it 'successfully' do
      supplier = Supplier.create!(
        trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
        cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
        email: 'contato@miolovinhos.com', telephone: '71 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Bebidas')
      pt = ProductType.create!(
        name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
        weight: 800, supplier: supplier, product_category: cat
      )
      ProductType.create!(
        name: 'Vinho Branco Miolo', height: 30, width: 10, length: 10,
        weight: 802, supplier: supplier, product_category: cat
      )

      get '/api/v1/product_types'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response[0]["name"]).to eq 'Vinho Tinto Miolo'
      expect(parsed_response[1]["name"]).to eq 'Vinho Branco Miolo'
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
    end

    it 'empty response' do
      get '/api/v1/product_types'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_types/:id' do
    it 'successfully' do
      supplier = Supplier.create!(
        trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
        cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
        email: 'contato@miolovinhos.com', telephone: '71 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Bebidas')
      pt = ProductType.create!(
        name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
        weight: 800, supplier: supplier, product_category: cat
      )

      get "/api/v1/product_types/#{pt.id}"

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(parsed_response["name"]).to eq 'Vinho Tinto Miolo'
      expect(parsed_response["weight"]).to eq 800
      expect(parsed_response.keys).to include 'dimensions'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'product_type not found - 404' do
      get '/api/v1/product_types/99999999999'

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto não encontrado'
      expect(response.status).to eq 404
    end

    it 'invalid parameter - 412' do # Exercicio / Reflexao
      # get("/api/v1/product_models/blabla")
    end

    it 'database error - 503' do
      supplier = Supplier.create!(
        trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
        cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
        email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Canecas')
      sw = ProductType.create!(
        name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
        weight: 300, supplier: supplier, product_category: cat
      )
      allow(ProductType).to receive(:find).with(sw.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished

      get("/api/v1/product_types/#{sw.id}")

      expect(response.status).to eq 503
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Não foi possível conectar ao banco de dados'
    end
  end

  context 'POST /api/v1/product_types' do
    it 'successfully' do
      supp = Supplier.create!(
        trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
        cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
        email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Bebidas e utensílios')

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_types', params: "{
        \"name\": \"Caneca Star Wars\",
        \"weight\": \"300\",
        \"length\": \"8\",
        \"height\": \"14\",
        \"width\": \"10\",
        \"supplier_id\": \"#{supp.id}\",
        \"product_category_id\": \"#{cat.id}\"
      }", headers: headers

      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Caneca Star Wars'
      expect(parsed_response["weight"]).to eq 300
      expect(parsed_response["height"]).to eq 14
      expect(parsed_response["length"]).to eq 8
      expect(parsed_response["width"]).to eq 10
      expect(parsed_response["supplier_id"]).to eq 1
      expect(parsed_response["product_category_id"]).to eq 1
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'has required field' do
      supp = Supplier.create!(
        trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
        cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
        email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Bebidas e utensílios')

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_types', params: "{
        \"supplier_id\": \"#{supp.id}\",
        \"product_category_id\": \"#{cat.id}\"
      }", headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
      expect(response.body).to include 'Peso não pode ficar em branco'
      expect(response.body).to include 'Altura não pode ficar em branco'
      expect(response.body).to include 'Largura não pode ficar em branco'
      expect(response.body).to include 'Profundidade não pode ficar em branco'
      expect(response.body).to include 'Peso não é um número'
      expect(response.body).to include 'Altura não é um número'
      expect(response.body).to include 'Largura não é um número'
      expect(response.body).to include 'Profundidade não é um número'
    end

    it 'and lost connection to the database' do
      allow(ProductType).to receive(:new).and_raise ActiveRecord::ConnectionNotEstablished
      supp = Supplier.create!(
        trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
        cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
        email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Bebidas e utensílios')

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_types', params: "{
        \"name\": \"Caneca Star Wars\",
        \"weight\": \"300\",
        \"length\": \"8\",
        \"height\": \"14\",
        \"width\": \"10\",
        \"supplier_id\": \"#{supp.id}\",
        \"product_category_id\": \"#{cat.id}\"
      }", headers: headers

      expect(response.status).to eq 503
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Não foi possível conectar ao banco de dados'
    end
  end
end
