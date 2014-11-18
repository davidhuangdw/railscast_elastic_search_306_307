require 'elasticsearch/model'

class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  validates :name, presence:true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  scope :search_text, ->(query){ search(query).records if query }

end

Article.import
