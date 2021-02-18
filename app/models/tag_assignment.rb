class TagAssignment < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

  def self.assign(tag, resource, weight)
    TagAssignment.create(tag: tag, taggable_id: resource.id, taggable_type: resource.class.to_s, weight:weight)
  end
end