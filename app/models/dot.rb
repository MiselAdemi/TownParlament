class Dot < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :stance
  has_many :subdots, :dependent => :destroy

  def act
    stance.act
  end
end
