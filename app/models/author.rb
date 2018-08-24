class Author < ApplicationRecord
  has_and_belongs_to_many :papers

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
