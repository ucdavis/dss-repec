class Paper < ApplicationRecord
  has_and_belongs_to_many :authors
  has_one_attached :file

  validates :title, :abstract, :authors, :presence => true
  validate :file_type

  private
    def file_type
      if file.attached? == false
        errors.add(:file, 'must have a document attached')
      elsif !file.content_type.in?(%w(application/pdf))
        errors.add(:file, 'must be a PDF')
      elsif file.byte_size > 500.megabytes
        errors.add(:file, 'size must be less than 500 MB')
      end
    end

  def self.search(search = nil)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
