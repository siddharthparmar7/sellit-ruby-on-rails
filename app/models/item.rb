class Item < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  # for search
  searchable do
    text :title
    # text :category
  end
end
