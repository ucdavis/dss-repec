class Paper < ApplicationRecord
  has_and_belongs_to_many :authors
  #has_one_attached :pdf

  validates :title, :abstract, :authors, :presence => true

  def self.search(search = nil)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
