class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :name

      t.timestamps
    end
  end

  def data
	  Sector.find_or_create_by!(name: "ADMINISTRATIVO")
		Sector.find_or_create_by!(name: "COMERCIAL")
		Sector.find_or_create_by!(name: "FINANCEIRO")
		Sector.find_or_create_by!(name: "REPRESENTANTE")
		Sector.find_or_create_by!(name: "OPERACIONAL")
		Sector.find_or_create_by!(name: "PALLETS")
		Sector.find_or_create_by!(name: "LOGISTICA_REVERSA")
		Sector.find_or_create_by!(name: "REGISTROS_OCORRENCIA")
		Sector.find_or_create_by!(name: "CONFIRMACAO_ENTREGA")
  end

end
