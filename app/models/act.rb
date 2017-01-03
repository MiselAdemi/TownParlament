class Act < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user, -> { where(:name => "alderman") }
  has_many :heads, :dependent => :destroy
end
