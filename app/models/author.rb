class Author < ApplicationRecord
  has_and_belongs_to_many :papers

  validates :name, :presence => true

  def first_name(name)
    name.split(" ")[0..-2].join(" ")
  end

  def last_name
    self.name.split(" ").last
  end


  def self.search(search = nil)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
