class Card < ApplicationRecord
  belongs_to :user
  belongs_to :card_product
end
