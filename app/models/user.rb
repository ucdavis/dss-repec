class User < ApplicationRecord
  validates :loginid, :presence => true

  def self.search(search = nil)
    if search
      where('loginid LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
