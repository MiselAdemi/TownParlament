class Head < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  TYPES = [:introduction, :main, :end]

  belongs_to :act
  has_many :regulations, :dependent => :destroy
end
