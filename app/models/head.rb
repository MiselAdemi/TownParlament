class Head < ActiveRecord::Base
  TYPES = [:introduction, :main, :end]

  belongs_to :act
  has_many :regulations, :dependent => :destroy
end
