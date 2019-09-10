class Comment < ApplicationRecord
  belongs_to :article, :user
end
