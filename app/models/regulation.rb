class Regulation < ActiveRecord::Base
  belongs_to :head
  has_many :subject, :dependent => :destroy
end
