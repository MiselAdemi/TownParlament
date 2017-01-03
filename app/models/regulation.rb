class Regulation < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :head
  has_many :subjects, :dependent => :destroy
end
