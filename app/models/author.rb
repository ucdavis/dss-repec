class Author < ApplicationRecord
  has_many :authors_papers
  has_many :papers, through: :authors_papers

  validates :name, :presence => true

  def self.search(search = nil)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
