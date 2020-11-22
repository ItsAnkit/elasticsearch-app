require 'elasticsearch/model'

class Employee < ApplicationRecord
  include Elasticsearch::Model # add methods like search
  include Elasticsearch::Model::Callbacks # add callbacks
  
  validates_uniqueness_of :name
  belongs_to :department

  index_name Rails.application.class.parent_name.underscore
  # document_type self.name.downcase throws issue for elasticsearch 7+

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :name, analyzer: 'english'
      indexes :address, analyzer: 'keyword'
    end
  end

  # To index a virtual field, one which is not stored in DB.
  def as_indexed_json(options = {})
    self.as_json( only: [:name, :address] )
    # :method_name is either a symbol or an array of symbols corresponding to method names in your model.
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^3', 'address']
          }
        },
        highlight: {
          pre_tags: ['<mark>'],
          post_tags: ['</mark>'],
          fields: {
            name: {},
            address: {},
          }
        },
      }
    ).results
  end
  # 3 is weight of name field i.e, it's 3 times as important.

  def self.search_w_recomm(query)
    # term suggester
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^3', 'address']
          }
        },
        suggest: {
          text: query,
          name: {
            term: {
              size: 1,
              field: :name
            },
          },
          address: {
            term: {
              size: 1,
              field: :address
            }
          }
        }
      }
    ).results
  end

end