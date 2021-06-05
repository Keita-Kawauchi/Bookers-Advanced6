class ProfileImage < ApplicationRecord
  belongs_to :user
  attachment :image
end
