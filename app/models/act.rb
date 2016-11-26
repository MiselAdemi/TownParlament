class Act < ActiveRecord::Base
  belongs_to :user, -> { where(:name => "alderman") }
  has_many :heads, :dependent => :destroy
end
