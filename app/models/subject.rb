class Subject < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :regulation
  has_many :clauses, :dependent => :destroy

  def act
    regulation.act
  end
end
