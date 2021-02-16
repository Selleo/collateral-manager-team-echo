class Tag < ApplicationRecord
  has_many :tag_assignments
  enum category: {stack: 0, domain:1, language:2, country:3}
  validates :name, presence: true
end
