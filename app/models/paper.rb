class Paper < ApplicationRecord
  has_many :authors_papers
  has_many :authors, -> { order 'authors_papers.rank' }, through: :authors_papers

  has_one_attached :file

  validates :title, :abstract, :authors, presence: true
  validate :file_type

  # Returns the JEL codes prettified while removing invalid codes
  def prettify_jel_codes
    classification_jel.strip.gsub('.','').gsub(' ','').split(',').select{|e| /(^[A-Z][0-9]*$)/.match(e) != nil }.map{|e| e.strip}.join(', ')
  end

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
