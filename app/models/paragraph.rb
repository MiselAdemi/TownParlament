class Paragraph < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :subdot

  def act
    subdot.act
  end
end
