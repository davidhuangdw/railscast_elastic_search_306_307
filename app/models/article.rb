require 'elasticsearch/model'

class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  validates :name, presence:true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # scope :search_text, ->(query){ search(query).records if query }
  scope :search_text, ->(query)do
    if query.present?
      result = search(
        query:{
          query_string:{
            query:query
          }
        },
        facets:{
          authors:{terms:{field:'author_id'}}
        }
      )
      result.records
    end
  end
  mapping do
    indexes :id, type: 'integer'
    indexes :author_id, type: 'integer'
    indexes :author_name
    indexes :name, boost: 10       # rank score weight
    indexes :content, analyzer:'snowball'
    indexes :published_at, type: 'date'
    indexes :comments_count, type: 'integer'
  end

  def author_name; author.name end
  def as_indexed_json(options={})
    as_json(methods: [:author_name])
  end


end

Article.import
