class Lead < ApplicationRecord
  has_many :tag_assignments, as: :taggable
end
