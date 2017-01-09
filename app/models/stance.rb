class Stance < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :clause
  has_many :dots, :dependent => :destroy

  def act
    clause.act
  end
end
