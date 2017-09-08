json.extract! current_account, :id, :account_banck_id, :cost_center_id, :sub_cost_center_id, :sub_cost_center_three_id, :nome, :date_launche, :type_launche, :price, :historic, :created_at, :updated_at
json.url current_account_url(current_account, format: :json)
