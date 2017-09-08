json.extract! account_payable, :id, :person_id, :cost_center_id, :sub_cost_center_id, :sub_cost_center_threes_id, :data_vencimento, :documento, :valor, :obs, :status, :created_at, :updated_at
json.url account_payable_url(account_payable, format: :json)
