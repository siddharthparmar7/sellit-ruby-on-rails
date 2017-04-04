class Item < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  # for search
  searchable do
    text :category, :title, :location
    # text :category    
  end
end
