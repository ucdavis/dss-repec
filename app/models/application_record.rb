class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def first_name
    self.name.split(" ")[0..-2].join(" ")
  end

  def last_name
    self.name.split(" ").last
  end
end
