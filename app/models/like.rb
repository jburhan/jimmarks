class Like < ApplicationRecord
  belongs_to :bookmarks
  belongs_to :user
end
