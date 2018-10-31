class Author < ApplicationRecord
  has_and_belongs_to_many :papers

  validates :name, :presence => true

  def self.search(search = nil)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
