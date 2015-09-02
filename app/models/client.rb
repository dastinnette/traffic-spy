class Client < ActiveRecord::Base
  validates :indentifier, :root_url, presence: true


end
