# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Sobre o Projeto

Este é um projeto de exercício da turma 7 do programa Quero Ser Dev da Locaweb. O projeto consiste num sistema de gestão de galpões e de seus respectivos estoques de produtos.



## API

### Galpões

#### Listar todos galpões

**Requisição:**

```
GET /api/v1/warehouses
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "address":"Av Fernandes Lima",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  },
  {
    "id": 2,
    "name": "Guarulhos",
    "code": "GRU",
    "description": "Ótimo galpão em Guarulhos",
    "address": "Av teste",
    "city": "Guarulhos",
    "state": "SPL",
    "postal_code": "00000-000",
    "total_area": 15000,
    "useful_area": 10000
  }
]

```

#### Criar um galpão

**Requisição:**

```
POST /api/v1/warehouses
```

**Parâmetros:**

```
{
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "address": "Avenida dos Galpões, 1000",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
}
```

**Resposta:**

```
Status: 201 (Criado)

{
  "id": 10,
  "name": "Maceió",
  "code": "MCZ",
  "description": "Ótimo galpão numa linda cidade",
  "city": "Maceió",
  "state": "AL",
  "postal_code": "57050-000",
  "total_area": 10000,
  "useful_area": 8000
}
```

#### Visualizar detalhes de um galpão

**Requisição:**

```
GET /api/v1/warehouses/:id
```

**Resposta:**

```
Status: 200 (OK)

  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão numa linda cidade",
    "address":"Av Fernandes Lima",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  }
```

### Fornecedores

#### Listar todos os fornecedores

**Requisição:**

```
GET /api/v1/suppliers
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "trading_name": "Samsung",
    "company_name": "Samsung do BR LTDA",
    "cnpj": "85935972000120",
    "address": "Av Industrial, 1000, São Paulo",
    "email": "financeiro@samsung.com.br",
    "telephone": "11 1234-5678"
  },
  {
    "id": 2,
    "trading_name": "Canecas e Copos",
    "company_name": "A Fantastica Fabrica de Canecas LTDA",
    "cnpj": "51905325000154",
    "address": "Avenida Matrix, 1",
    "email": "canecas@gmail.com",
    "telephone": "51 3456-7890"
  }
]

```
#### Visualizar detalhes de um fornecedor

**Requisição**

```
GET /api/v1/suppliers/:id
```

**Resposta**

Status: 200 (OK)

```
{
    "id": 1,
    "trading_name": "Samsung",
    "company_name": "Samsung do BR LTDA",
    "cnpj": "85935972000120",
    "address": "Av Industrial, 1000, São Paulo",
    "email": "financeiro@samsung.com.br",
    "telephone": "11 1234-5678"
  }
```

### Modelos de produto

#### Listar todos os Modelos de produto

**Requisição:**

```
GET /api/v1/product_types/:id
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "Pelúcia Dumbo",
    "weight": 400,
    "height": 50,
    "length": 20,
    "width": 40,
    "sku": "OE51ZXQU81NVLVLJVWKX",
    "supplier_id": 1,
    "product_category_id": 2
  },
  {
    "id": 2,
    "name": "Caneca Star Wars",
    "weight": 300,
    "height": 14,
    "length": 8,
    "width": 10,
    "sku": "ZQZRHWLHZETNJUQH7NTS",
    "supplier_id": 1,
    "product_category_id": 1
  }
]

```
#### Visualizar detalhes de um modelo de produto

**Requisição**

```
GET /api/v1/product_type/:id
```

**Resposta**

```
Status: 200 (OK)

{
    "id": 1,
    "name": "Pelúcia Dumbo",
    "weight": 400,
    "height": 50,
    "length": 20,
    "width": 40,
    "sku": "OE51ZXQU81NVLVLJVWKX",
    "supplier_id": 1,
    "product_category_id": 2,
    "dimensions": "50 x 40 x 20"
    ""supplier": {...}
  }
```


