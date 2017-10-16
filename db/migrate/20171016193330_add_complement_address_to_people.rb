class AddComplementAddressToPeople < ActiveRecord::Migration
  def change
    add_column :people, :numero, :string
    add_column :people, :complemento, :string
    add_column :people, :bairro, :string
    add_column :people, :cidade, :string
    add_column :people, :estado, :string
    add_column :people, :cep, :string
  end
end
