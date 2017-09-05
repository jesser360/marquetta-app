class Funding < ApplicationRecord
  belongs_to :user
  belongs_to :funding_source
end
