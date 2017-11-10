class AddObservacaoToPeople < ActiveRecord::Migration
  def change
    add_column :people, :observacao, :text
  end
end
