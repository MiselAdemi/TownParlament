class Subdot < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :dot
  has_many :paragraphs, :dependent => :destroy
end
