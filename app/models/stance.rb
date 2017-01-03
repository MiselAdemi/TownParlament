class Stance < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :clause
  has_many :dots, :dependent => :destroy
end
