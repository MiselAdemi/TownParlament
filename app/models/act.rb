class Act < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :heads, :dependent => :destroy
	has_many :amandments
end
