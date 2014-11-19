require 'elasticsearch/model'

class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  validates :name, presence:true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  scope :search_text, ->(query){ search(query).records if query }
  mapping do
    indexes :id, type: 'integer'
    indexes :author_id, type: 'integer'
    indexes :author_name
    indexes :name, boost: 10       # rank score weight
    indexes :content, analyzer:'snowball'
    indexes :published_at, type: 'date'
    indexes :comments_count, type: 'integer'
  end

end

Article.import
