class ClientDatum < ActiveRecord::Base
  belongs_to :user
  attr_accessible :data, :section
end
