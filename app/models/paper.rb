class Paper < ApplicationRecord
  has_and_belongs_to_many :authors
  #has_one_attached :pdf

  validates :title, :abstract, :presence => true

  def self.title(title)
    if title
      where('title LIKE ?', "%#{title}%")
    else
      all
    end
  end
end
