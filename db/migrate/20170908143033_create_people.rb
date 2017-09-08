class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :tipo_pessoa
      t.string :cpf_cnpj, limit: 18, null: false
      t.string :nome, limit: 100, null: false
      t.string :endereco, limit: 150, null: false

      t.timestamps
    end
  end
end
