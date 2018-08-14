class Paper < ApplicationRecord
  has_and_belongs_to_many :authors
  has_one_attached :pdf
end
