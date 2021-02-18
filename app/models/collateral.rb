class Collateral < ApplicationRecord
  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments
  enum kind: { case_study: 0, portfolio_item: 1, blog_article: 2, ebook: 3, presentation: 4, slide_desk: 5, prototype: 6, repositorium: 7, proposal: 8, estimation: 9, other: 10 }
end
