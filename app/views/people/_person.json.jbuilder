json.extract! person, :id, :tipo_pessoa, :cpf_cnpj, :nome, :endereco, :created_at, :updated_at
json.url person_url(person, format: :json)
