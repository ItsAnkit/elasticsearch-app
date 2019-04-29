require 'elasticsearch/model'

class Employee < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end