class Tag < ApplicationRecord
  has_and_belongs_to_many :collaterals
  enum category: {stack: 0, domain:1, language:2, country:3}
  validates :name, presence: true
end
