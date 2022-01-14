# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'admin@email.com', password: '12345678')
w1 = Warehouse.create!(
  name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
  address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
  postal_code: '57050-000',
  total_area: 10000, useful_area: 8000
)
w2 = Warehouse.create!( 
  name: 'Guarulhos', code: 'GRU', description: 'teste',
  address: 'Av teste', city: 'São Paulo', state: 'SP',
  postal_code: '00000-000', total_area: 10000, useful_area: 8000 
)
cat = ProductCategory.create!(name: 'Bebidas e utensílios')
cat1 = ProductCategory.create!(name: 'Brinquedos')
supplier = Supplier.create!(
  trading_name: 'Samsung', company_name: 'Samsung do BR LTDA',
  cnpj: '85935972000120', address: 'Av Industrial, 1000, São Paulo',
  email: 'financeiro@samsung.com.br', telephone: '11 1234-5678'
)
other_supplier = Supplier.create!(
  trading_name: 'Canecas e Copos', company_name: 'A Fantastica Fabrica de Canecas LTDA',
  cnpj: '51905325000154', address: 'Avenida Matrix, 1',
  email: 'canecas@gmail.com', telephone: '51 3456-7890'
)

p1 = ProductType.create!(
  name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
  weight: 400, supplier: supplier, product_category: cat1
)
p2 = ProductType.create!(
  name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
  weight: 300, supplier: supplier, product_category: cat
)
