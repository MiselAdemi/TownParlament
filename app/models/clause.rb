class Clause < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :subject
  has_many :stances, :dependent => :destroy
end
