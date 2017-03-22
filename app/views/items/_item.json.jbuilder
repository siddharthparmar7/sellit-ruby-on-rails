json.extract! item, :id, :title, :price, :category, :description, :status, :image, :email, :phone_number, :location, :user_id, :created_at, :updated_at
json.url item_url(item, format: :json)
