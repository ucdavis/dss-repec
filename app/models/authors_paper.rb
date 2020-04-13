class AuthorsPaper < ApplicationRecord
  belongs_to :author
  belongs_to :paper
end
