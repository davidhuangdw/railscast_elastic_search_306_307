class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :published_at
  has_one :author
end
