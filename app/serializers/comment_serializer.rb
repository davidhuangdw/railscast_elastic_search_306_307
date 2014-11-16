class CommentSerializer < ActiveModel::Serializer
  attributes :id, :name, :content
  has_one :article
end
