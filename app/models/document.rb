class Document < ActiveRecord::Base
  belongs_to :users
  attr_accessible :doc_name, :filename, :original_filename
end
