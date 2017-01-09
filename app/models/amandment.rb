class Amandment < ActiveRecord::Base
  include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks

  TYPE = ["wait", "accepted", "declined"]

  belongs_to :owner, :polymorphic => true, :foreign_key => :owner_id
  belongs_to :user, -> { where(:name => "alderman") }
  belongs_to :act
end
